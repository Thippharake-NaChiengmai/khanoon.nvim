<#
.SYNOPSIS
    KHANOON.nvim - One-Click Installer
.DESCRIPTION
    Automatic installation script for complete Neovim setup
    Perfect for beginners - just run and go!
.NOTES
    Author: KHANOON
    Repository: https://github.com/Thippharake-NaChiengmai/khanoon.nvim
#>

# ============================================================================
# Configuration
# ============================================================================
$ErrorActionPreference = "Stop"
$RepoUrl = "https://github.com/Thippharake-NaChiengmai/khanoon.nvim/archive/refs/heads/main.zip"
$NvimConfigPath = "$env:LOCALAPPDATA\nvim"
$TempDir = "$env:TEMP\khanoon-nvim-install"

# ============================================================================
# Helper Functions
# ============================================================================
function Write-Step {
    param([string]$Message)
    Write-Host "`n▶ $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-Info {
    param([string]$Message)
    Write-Host "ℹ $Message" -ForegroundColor Yellow
}

function Write-Error-Custom {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
}

function Test-AdminRights {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Install-Winget {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Success "winget already installed"
        return
    }
    
    Write-Info "winget not found. Please install from Microsoft Store: 'App Installer'"
    Write-Info "Or download from: https://aka.ms/getwinget"
    Start-Process "https://aka.ms/getwinget"
    Read-Host "Press Enter after installing winget"
}

function Refresh-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# ============================================================================
# Main Installation
# ============================================================================
Clear-Host
Write-Host @"
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║     🚀 KHANOON.nvim - One-Click Installer                ║
║                                                           ║
║     Modern Neovim Configuration for Everyone             ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
"@ -ForegroundColor Magenta

Write-Host "`nThis installer will set up:" -ForegroundColor Cyan
Write-Host "  • Neovim (latest stable version)" -ForegroundColor White
Write-Host "  • KHANOON.nvim configuration" -ForegroundColor White
Write-Host "  • Required tools (git, ripgrep, fd, fzf)" -ForegroundColor White
Write-Host "  • Node.js (for LSP servers)" -ForegroundColor White
Write-Host "  • UbuntuMono Nerd Font" -ForegroundColor White
Write-Host "  • 60+ plugins (auto-configured)" -ForegroundColor White

Write-Host "`nInstallation path: " -NoNewline -ForegroundColor Yellow
Write-Host $NvimConfigPath -ForegroundColor White

Write-Host "`nEstimated time: 5-10 minutes ⏱" -ForegroundColor Cyan

$confirm = Read-Host "`nContinue installation? (Y/n)"
if ($confirm -eq 'n' -or $confirm -eq 'N') {
    Write-Host "Installation cancelled." -ForegroundColor Yellow
    exit 0
}

try {
    # ========================================================================
    # Step 1: Check Prerequisites
    # ========================================================================
    Write-Step "Checking prerequisites..."
    
    if (Test-AdminRights) {
        Write-Info "Running as Administrator (recommended for font installation)"
    } else {
        Write-Info "Running as regular user (fonts will install for current user only)"
    }
    
    Install-Winget
    
    # ========================================================================
    # Step 2: Backup Existing Config
    # ========================================================================
    if (Test-Path $NvimConfigPath) {
        Write-Step "Backing up existing Neovim configuration..."
        $backupPath = "$env:LOCALAPPDATA\nvim.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Move-Item $NvimConfigPath $backupPath -Force
        Write-Success "Backed up to: $backupPath"
    }
    
    # ========================================================================
    # Step 3: Install Neovim
    # ========================================================================
    Write-Step "Installing Neovim..."
    
    if (Get-Command nvim -ErrorAction SilentlyContinue) {
        $nvimVersion = (nvim --version | Select-Object -First 1) -replace 'NVIM v', ''
        Write-Success "Neovim already installed: v$nvimVersion"
    } else {
        Write-Info "Downloading and installing Neovim..."
        winget install --id Neovim.Neovim --silent --accept-source-agreements --accept-package-agreements
        Write-Success "Neovim installed successfully"
        Refresh-Path
    }
    
    # Verify installation
    if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
        Write-Error-Custom "Neovim installation failed. Please install manually from: https://neovim.io"
        exit 1
    }
    
    # ========================================================================
    # Step 4: Install Required Tools
    # ========================================================================
    Write-Step "Installing required development tools..."
    
    $tools = @(
        @{Id="Git.Git"; Name="git"; DisplayName="Git"},
        @{Id="BurntSushi.ripgrep.MSVC"; Name="rg"; DisplayName="ripgrep"},
        @{Id="sharkdp.fd"; Name="fd"; DisplayName="fd"},
        @{Id="junegunn.fzf"; Name="fzf"; DisplayName="fzf"}
    )
    
    foreach ($tool in $tools) {
        if (Get-Command $tool.Name -ErrorAction SilentlyContinue) {
            Write-Success "$($tool.DisplayName) already installed"
        } else {
            Write-Info "Installing $($tool.DisplayName)..."
            try {
                winget install --id $tool.Id --silent --accept-source-agreements --accept-package-agreements
                Write-Success "$($tool.DisplayName) installed"
            } catch {
                Write-Info "Failed to install $($tool.DisplayName), continuing..."
            }
        }
    }
    
    Refresh-Path
    
    # ========================================================================
    # Step 5: Install Node.js (for LSP servers)
    # ========================================================================
    Write-Step "Checking Node.js installation..."
    
    if (Get-Command node -ErrorAction SilentlyContinue) {
        $nodeVersion = node --version
        Write-Success "Node.js already installed: $nodeVersion"
    } else {
        Write-Info "Installing Node.js LTS..."
        winget install --id OpenJS.NodeJS.LTS --silent --accept-source-agreements --accept-package-agreements
        Write-Success "Node.js installed"
        Refresh-Path
    }
    
    # ========================================================================
    # Step 6: Download KHANOON.nvim Configuration
    # ========================================================================
    Write-Step "Downloading KHANOON.nvim configuration..."
    
    # Create temp directory
    if (Test-Path $TempDir) {
        Remove-Item $TempDir -Recurse -Force
    }
    New-Item -ItemType Directory -Path $TempDir -Force | Out-Null
    
    # Download ZIP
    $zipPath = "$TempDir\nvim.zip"
    Write-Info "Downloading from GitHub..."
    try {
        Invoke-WebRequest -Uri $RepoUrl -OutFile $zipPath -UseBasicParsing
    } catch {
        Write-Error-Custom "Failed to download config. Please check your internet connection."
        exit 1
    }
    
    # Extract
    Write-Info "Extracting configuration files..."
    Expand-Archive -Path $zipPath -DestinationPath $TempDir -Force
    
    # Move to correct location
    $extractedFolder = Get-ChildItem $TempDir -Directory | Select-Object -First 1
    New-Item -ItemType Directory -Path $NvimConfigPath -Force | Out-Null
    Copy-Item "$($extractedFolder.FullName)\*" $NvimConfigPath -Recurse -Force
    
    Write-Success "Configuration installed successfully"
    
    # ========================================================================
    # Step 7: Install JetBrainsMono Nerd Font
    # ========================================================================
    Write-Step "Installing UbuntuMono Nerd Font..."
    
    $fontName = "UbuntuMonoNerdFont-Regular.ttf"
    $userFontsPath = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
    $fontInstalled = Test-Path "$userFontsPath\$fontName"
    
    if (-not $fontInstalled) {
        $fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/UbuntuMono.zip"
        $fontZip = "$TempDir\font.zip"
        $fontDir = "$TempDir\font"
        
        Write-Info "Downloading UbuntuMono Nerd Font (~10MB)..."
        try {
            Invoke-WebRequest -Uri $fontUrl -OutFile $fontZip -UseBasicParsing
        } catch {
            Write-Info "Font download failed, skipping font installation"
            Write-Info "You can install fonts manually later from: https://www.nerdfonts.com"
        }
        
        if (Test-Path $fontZip) {
            Write-Info "Extracting fonts..."
            Expand-Archive -Path $fontZip -DestinationPath $fontDir -Force
            
            # Create user fonts directory if it doesn't exist
            if (-not (Test-Path $userFontsPath)) {
                New-Item -ItemType Directory -Path $userFontsPath -Force | Out-Null
            }
            
            # Install fonts
            $fonts = Get-ChildItem "$fontDir\*.ttf" -Recurse | Where-Object { $_.Name -like "*NerdFont*" }
            $installedCount = 0
            
            foreach ($font in $fonts) {
                try {
                    Copy-Item $font.FullName $userFontsPath -Force
                    $installedCount++
                } catch {
                    Write-Info "Could not install $($font.Name)"
                }
            }
            
            if ($installedCount -gt 0) {
                Write-Success "Installed $installedCount font files"
            }
        }
        
        Write-Info "⚠ IMPORTANT: Set your terminal font to 'UbuntuMono Nerd Font'"
    } else {
        Write-Success "UbuntuMono Nerd Font already installed"
    }
    
    # ========================================================================
    # Step 8: Install Neovim Plugins
    # ========================================================================
    Write-Step "Installing Neovim plugins (this may take a few minutes)..."
    Write-Info "Installing 60+ plugins and dependencies..."
    
    # Install plugins headlessly
    $nvimProcess = Start-Process -FilePath "nvim" -ArgumentList "--headless", "+Lazy! sync", "+qa" -Wait -NoNewWindow -PassThru
    
    if ($nvimProcess.ExitCode -eq 0) {
        Write-Success "All plugins installed successfully"
    } else {
        Write-Info "Plugins will be installed on first Neovim launch"
    }
    
    # ========================================================================
    # Cleanup
    # ========================================================================
    Write-Step "Cleaning up temporary files..."
    Remove-Item $TempDir -Recurse -Force -ErrorAction SilentlyContinue
    Write-Success "Cleanup complete"
    
    # ========================================================================
    # Success Message
    # ========================================================================
    Write-Host "`n"
    Write-Host "╔═══════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║                                                           ║" -ForegroundColor Green
    Write-Host "║         ✓ Installation Complete! 🎉                      ║" -ForegroundColor Green
    Write-Host "║                                                           ║" -ForegroundColor Green
    Write-Host "╚═══════════════════════════════════════════════════════════╝" -ForegroundColor Green
    
    Write-Host "`n📋 Next Steps:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  1. " -NoNewline -ForegroundColor White
    Write-Host "Configure your terminal font:" -ForegroundColor Yellow
    Write-Host "     • Open Windows Terminal settings (Ctrl + ,)" -ForegroundColor Gray
    Write-Host "     • Go to: Profiles → Defaults → Appearance" -ForegroundColor Gray
    Write-Host "     • Set Font face to: " -NoNewline -ForegroundColor Gray
    Write-Host "UbuntuMono Nerd Font" -ForegroundColor Green
    Write-Host "     • Font size: 13 or 14" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  2. " -NoNewline -ForegroundColor White
    Write-Host "Launch Neovim:" -ForegroundColor Yellow
    Write-Host "     " -NoNewline
    Write-Host "nvim" -ForegroundColor Green
    Write-Host ""
    Write-Host "  3. " -NoNewline -ForegroundColor White
    Write-Host "Install LSP servers (in Neovim):" -ForegroundColor Yellow
    Write-Host "     " -NoNewline
    Write-Host ":Mason" -ForegroundColor Green
    Write-Host "     Recommended servers:" -ForegroundColor Gray
    Write-Host "     • lua-language-server (Lua)" -ForegroundColor Gray
    Write-Host "     • typescript-language-server (JS/TS)" -ForegroundColor Gray
    Write-Host "     • pyright (Python)" -ForegroundColor Gray
    Write-Host "     • prettier, stylua, black (formatters)" -ForegroundColor Gray
    
    Write-Host "`n⌨️  Quick Keyboard Shortcuts:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Leader key = " -NoNewline -ForegroundColor White
    Write-Host "Space" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Space + e       " -NoNewline -ForegroundColor Yellow
    Write-Host "→ File Explorer" -ForegroundColor White
    Write-Host "  Space + ff      " -NoNewline -ForegroundColor Yellow
    Write-Host "→ Find Files" -ForegroundColor White
    Write-Host "  Space + fg      " -NoNewline -ForegroundColor Yellow
    Write-Host "→ Search Text" -ForegroundColor White
    Write-Host "  Space + cf      " -NoNewline -ForegroundColor Yellow
    Write-Host "→ Format Code" -ForegroundColor White
    Write-Host "  Ctrl + \        " -NoNewline -ForegroundColor Yellow
    Write-Host "→ Toggle Terminal" -ForegroundColor White
    Write-Host "  s + <letter>    " -NoNewline -ForegroundColor Yellow
    Write-Host "→ Flash jump (fast navigation)" -ForegroundColor White
    Write-Host "  gcc             " -NoNewline -ForegroundColor Yellow
    Write-Host "→ Toggle comment" -ForegroundColor White
    
    Write-Host "`n📚 Documentation:" -ForegroundColor Cyan
    Write-Host "  • README: " -NoNewline -ForegroundColor White
    Write-Host "$NvimConfigPath\README.md" -ForegroundColor Gray
    Write-Host "  • GitHub: " -NoNewline -ForegroundColor White
    Write-Host "https://github.com/Thippharake-NaChiengmai/khanoon.nvim" -ForegroundColor Gray
    Write-Host "  • Help in Neovim: " -NoNewline -ForegroundColor White
    Write-Host ":help" -ForegroundColor Green
    Write-Host "  • Check health: " -NoNewline -ForegroundColor White
    Write-Host ":checkhealth" -ForegroundColor Green
    
    Write-Host "`n💡 Tips for Beginners:" -ForegroundColor Cyan
    Write-Host "  • Press Space and wait to see available commands" -ForegroundColor Gray
    Write-Host "  • Type :Tutor to learn Vim basics" -ForegroundColor Gray
    Write-Host "  • Be patient - it takes 1-2 weeks to get comfortable" -ForegroundColor Gray
    
    Write-Host "`n🚀 Enjoy KHANOON.nvim!" -ForegroundColor Magenta
    Write-Host ""
    
    # Offer to open terminal settings
    $openSettings = Read-Host "Open Windows Terminal settings now to configure font? (Y/n)"
    if ($openSettings -ne 'n' -and $openSettings -ne 'N') {
        try {
            Start-Process "wt" -ArgumentList "settings"
        } catch {
            Write-Info "Please open Windows Terminal settings manually (Ctrl + ,)"
        }
    }
    
    # Offer to launch Neovim
    Write-Host ""
    $launchNvim = Read-Host "Launch Neovim now? (Y/n)"
    if ($launchNvim -ne 'n' -and $launchNvim -ne 'N') {
        Start-Process "nvim"
    }
    
} catch {
    Write-Host "`n"
    Write-Error-Custom "Installation failed: $_"
    Write-Host "`nError details:" -ForegroundColor Yellow
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host "`nPlease report this issue at:" -ForegroundColor Yellow
    Write-Host "https://github.com/Thippharake-NaChiengmai/khanoon.nvim/issues" -ForegroundColor Cyan
    Write-Host "`nInclude the error message above in your report." -ForegroundColor Yellow
    exit 1
}
