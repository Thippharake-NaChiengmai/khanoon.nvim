# 🚀 KHANOON.nvim

> A modern, modular Neovim configuration optimized for Windows with full LSP support and beautiful UI.

![Neovim](https://img.shields.io/badge/Neovim-0.9+-green.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Windows-blue.svg)

## ✨ Features

- 🎨 **Beautiful UI** - Tokyo Night theme with Lualine & Bufferline
- 📁 **File Explorer** - Nvim-tree with git integration
- 🔍 **Fuzzy Finder** - Telescope for fast file/text search
- 🎯 **LSP Support** - Full Language Server Protocol with Mason
- ⚡ **Autocompletion** - nvim-cmp with LSP, buffer, and path sources
- 🌳 **Syntax Highlighting** - Treesitter with Zig compiler (Windows compatible)
- 🔧 **Git Integration** - Gitsigns for git status in signcolumn
- 💡 **Smart Editing** - Auto-pairs, commenting, and more
- 📦 **Modular Structure** - Clean organization in `/lua/core`
- 🎯 **Custom Dashboard** - Alpha-nvim with quick reference guide

## 📋 Prerequisites

Before installing KHANOON.nvim, ensure you have the following installed:

### Required

- **Windows 10/11**
- **Neovim** >= 0.9.0
- **Git**
- **Node.js** >= 16.x (for LSP servers)
- **Zig** (for Treesitter compilation)

### Optional but Recommended

- **ripgrep** (for Telescope live_grep)
- **fd** (for faster file search)
- **A Nerd Font** (for icons) - [Download here](https://www.nerdfonts.com/)

## 🔧 Installation

### Step 1: Install Prerequisites

#### Using Winget (Recommended)

```powershell
# Install Neovim
winget install Neovim.Neovim

# Install Git
winget install Git.Git

# Install Node.js
winget install OpenJS.NodeJS.LTS

# Install Zig (required for Treesitter)
winget install zig.zig

# Install ripgrep (optional)
winget install BurntSushi.ripgrep.MSVC

# Install fd (optional)
winget install sharkdp.fd
```

#### Using Chocolatey

```powershell
# Install Chocolatey first if you haven't
# Visit: https://chocolatey.org/install

# Install all dependencies
choco install neovim git nodejs zig ripgrep fd -y
```

#### Using Scoop

```powershell
# Install Scoop first if you haven't
# Visit: https://scoop.sh

# Add buckets
scoop bucket add main
scoop bucket add extras

# Install all dependencies
scoop install neovim git nodejs zig ripgrep fd
```

### Step 2: Verify Installation

```powershell
# Verify Neovim
nvim --version
# Should show v0.9.0 or higher

# Verify Git
git --version

# Verify Node.js
node --version

# Verify Zig
zig version

# Verify ripgrep (optional)
rg --version

# Verify fd (optional)
fd --version
```

### Step 3: Set Up Environment Variables

The installers should automatically add these to your PATH. To verify:

```powershell
# Check if commands are in PATH
Get-Command nvim
Get-Command git
Get-Command node
Get-Command zig
```

If any command is not found, add it manually to your PATH:

1. Press `Win + X` and select "System"
2. Click "Advanced system settings"
3. Click "Environment Variables"
4. Under "System variables", find and edit "Path"
5. Add the installation directories (example):
   - `C:\Program Files\Neovim\bin`
   - `C:\Program Files\Git\cmd`
   - `C:\Program Files\nodejs`
   - `C:\Users\YourUsername\AppData\Local\zig`

### Step 4: Install KHANOON.nvim

```powershell
# Backup existing config (if any)
if (Test-Path "$env:LOCALAPPDATA\nvim") {
    Rename-Item -Path "$env:LOCALAPPDATA\nvim" -NewName "nvim.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
}

# Clone KHANOON.nvim
git clone https://github.com/YOUR_USERNAME/khanoon.nvim.git "$env:LOCALAPPDATA\nvim"

# Navigate to config directory
cd "$env:LOCALAPPDATA\nvim"
```

### Step 5: First Launch

```powershell
# Launch Neovim
nvim
```

On first launch:
1. Packer will automatically install
2. Plugins will be downloaded and installed
3. Wait for the installation to complete (you'll see progress messages)
4. After installation, restart Neovim

If plugins don't install automatically, run:
```vim
:PackerSync
```

### Step 6: Install Treesitter Parsers

```vim
" Install language parsers
:TSInstall lua vim vimdoc query python javascript typescript html css json markdown

" Check installation status
:TSInstallInfo

" Update parsers
:TSUpdate
```

### Step 7: Install LSP Servers

```vim
" Open Mason
:Mason

" Navigate with j/k, press 'i' to install servers
" Recommended servers:
" - lua_ls (Lua)
" - tsserver (JavaScript/TypeScript)
" - pyright (Python)
" - html, cssls, jsonls
" - emmet_ls (HTML/CSS completion)

" Or install via command
:MasonInstall lua-language-server typescript-language-server
```

## 📁 Project Structure

```
nvim/
├── init.lua                  # Main entry point
├── lua/
│   ├── plugins.lua          # Plugin definitions (Packer)
│   └── core/                # Configuration modules
│       ├── alpha.lua        # Dashboard/Startup screen
│       ├── autopairs.lua    # Auto-pairs configuration
│       ├── bufferline.lua   # Buffer tabs
│       ├── comment.lua      # Commenting functionality
│       ├── gitsigns.lua     # Git integration
│       ├── keymaps.lua      # Key mappings
│       ├── lsp.lua          # LSP & completion setup
│       ├── lualine.lua      # Status line
│       ├── nvim-tree.lua    # File explorer
│       ├── options.lua      # Vim options
│       ├── telescope.lua    # Fuzzy finder
│       ├── theme.lua        # Colorscheme
│       └── treesitter.lua   # Syntax highlighting
├── .gitignore
└── README.md
```

## ⌨️ Key Mappings

### General

| Key | Mode | Action |
|-----|------|--------|
| `<Space>` | - | Leader key (prefix for most commands) |
| `jk` / `kj` | Insert | Exit to normal mode |
| `<leader>w` | Normal | Save file |
| `<leader>q` | Normal | Quit window |
| `<leader>x` | Normal | Close current buffer |
| `<C-h/j/k/l>` | Normal | Navigate between windows (splits) |
| `<S-h>` | Normal | Previous buffer |
| `<S-l>` | Normal | Next buffer |

### File Explorer (NvimTree)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `a` | Create new file/folder (ends with `/` for folder) |
| `d` | Delete file/folder |
| `r` | Rename file/folder |
| `x` | Cut file/folder |
| `c` | Copy file/folder |
| `p` | Paste file/folder |
| `H` | Toggle hidden files |
| `R` | Refresh tree |
| `?` | Show help |

### Fuzzy Finder (Telescope)

| Key | Action |
|-----|--------|
| `<leader>f` | Find files |
| `<leader>g` | Live grep (search text in files) |
| `<C-n>` / `<Down>` | Next item |
| `<C-p>` / `<Up>` | Previous item |
| `<CR>` | Open selected file |
| `<C-x>` | Open in horizontal split |
| `<C-v>` | Open in vertical split |
| `<C-t>` | Open in new tab |

### LSP (Code Intelligence)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Show references |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>f` | Format document |

### Git (Gitsigns)

| Key | Action |
|-----|--------|
| `<leader>gb` | Git blame line |
| `<leader>gd` | Git diff this |
| `<leader>gp` | Preview hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gs` | Stage hunk |
| `]c` | Next git hunk |
| `[c` | Previous git hunk |

### Commenting

| Key | Mode | Action |
|-----|------|--------|
| `gcc` | Normal | Toggle line comment |
| `gc` | Visual | Toggle comment for selection |
| `<leader>/` | Normal/Visual | Toggle comment |

### Editing

| Key | Mode | Action |
|-----|------|--------|
| `yy` | Normal | Copy line |
| `dd` | Normal | Cut line |
| `p` | Normal | Paste after cursor |
| `P` | Normal | Paste before cursor |
| `u` | Normal | Undo |
| `<C-r>` | Normal | Redo |

## 🎨 Customization

### Change Theme

Edit `lua/core/theme.lua`:

```lua
-- Available styles: storm, night, day, moon
vim.g.tokyonight_style = 'night'  -- Change to your preferred style
```

Other popular themes you can add:
- `catppuccin/nvim` - Catppuccin theme
- `rose-pine/neovim` - Rose Pine theme
- `EdenEast/nightfox.nvim` - Nightfox themes

### Add New LSP Server

1. Open Neovim and run `:Mason`
2. Search for your language server (use `/` to search)
3. Press `i` to install
4. Restart Neovim

Or install via command:
```vim
:MasonInstall rust-analyzer  " Example: Rust
:MasonInstall gopls          " Example: Go
```

### Add New Plugins

Edit `lua/plugins.lua`:

```lua
return require('packer').startup(function(use)
  -- ... existing plugins ...
  
  -- Add your plugin here
  use 'author/plugin-name'
end)
```

Then run:
```vim
:PackerSync
```

### Modify Keymaps

Edit `lua/core/keymaps.lua` to customize key mappings to your preference.

## 🐛 Troubleshooting

### Plugins not installing

```vim
:PackerSync
```

If that doesn't work:
```vim
:PackerClean
:PackerSync
```

### LSP not working

```vim
:Mason          " Check if language server is installed
:LspInfo        " Check LSP status
:LspInstall     " Install LSP for current filetype
```

### Treesitter errors

```vim
:TSInstallInfo  " Check parser status
:TSUpdate       " Update all parsers
```

If compilation fails:
```vim
:TSUninstall <language>
:TSInstall <language>
```

### Icons not showing

1. Install a Nerd Font from [nerdfonts.com](https://www.nerdfonts.com/)
2. Set the font in your terminal (e.g., "JetBrainsMono Nerd Font")
3. Restart terminal and Neovim

### Telescope grep not working

Install ripgrep:
```powershell
winget install BurntSushi.ripgrep.MSVC
```

## 🔄 Updating

### Update KHANOON.nvim

```powershell
cd "$env:LOCALAPPDATA\nvim"
git pull
```

Then in Neovim:
```vim
:PackerSync
```

### Update Plugins

```vim
:PackerUpdate
```

### Update LSP Servers

```vim
:Mason
# Press 'U' to update all
```

### Update Treesitter Parsers

```vim
:TSUpdate
```

## 📚 Learning Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Learn Vim](https://www.openvim.com/)
- [Vim Cheat Sheet](https://vim.rtorr.com/)
- Press `:help` in Neovim for built-in help
- Press `?` in NvimTree for file explorer help

## 🆘 Getting Help

### In Neovim

- `:help <topic>` - Get help on any topic
- `:checkhealth` - Check Neovim health
- `:Mason` - Manage LSP servers
- `:TSInstallInfo` - Check Treesitter status
- `:LspInfo` - Check LSP status

### Common Issues

**Q: Neovim is slow**
- A: Disable treesitter for large files (already configured)
- Run `:checkhealth` to find issues

**Q: LSP autocomplete not working**
- A: Install language server via `:Mason`
- Check `:LspInfo` for errors

**Q: Git signs not showing**
- A: Ensure you're in a git repository
- Check `:Gitsigns status`

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests

## 📝 License

MIT License - feel free to use and modify!

## 🙏 Acknowledgments

This configuration uses these amazing plugins:
- [packer.nvim](https://github.com/wbthomason/packer.nvim) - Plugin manager
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) - Color scheme
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) - File explorer
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP support
- [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP installer
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Autocompletion
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Status line
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - Buffer tabs
- [alpha-nvim](https://github.com/goolord/alpha-nvim) - Dashboard
- [Comment.nvim](https://github.com/numToStr/Comment.nvim) - Commenting
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Auto-pairs

And many more amazing contributors to the Neovim ecosystem!

---

**Made with ❤️ by KHANOON**

*Happy coding! 🚀*
