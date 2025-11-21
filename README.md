# 🚀 KHANOON.nvim

<img width="1889" height="977" alt="khanoon_nvim_img2" src="https://github.com/user-attachments/assets/3656fe82-6b3c-4e4b-b813-7c54dfe111ed" />

> A modern, modular Neovim configuration optimized for Windows with full LSP support, debugging, and beautiful UI powered by Lazy.nvim.

![Neovim](https://img.shields.io/badge/Neovim-0.9+-green.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Windows-blue.svg)
![Plugins](https://img.shields.io/badge/Plugins-65+-orange.svg)

## ✨ Features

### 🎨 UI/UX

- **Catppuccin Theme** - Beautiful pastel color scheme with 4 variants (Latte, Frappé, Macchiato, Mocha)
- **Lualine** - Elegant status line with git & LSP integration
- **Bufferline** - VSCode-like buffer tabs
- **Alpha Dashboard** - Custom startup screen with KHANOON branding
- **Which-key** - Interactive command palette & keybinding hints
- **Noice.nvim** - Modern UI for messages, cmdline & popups
- **Notify** - Beautiful notification popups
- **Rainbow Brackets** - Colorful bracket pair highlighting (7 colors)
- **Indent Guides** - Visual indentation lines for better code structure
- **Colorizer** - Live color preview for hex/RGB/HSL color codes
- **Inline Diagnostics** - Modern inline error/warning display
- **Minimap** - Code overview minimap with CodeWindow and Satellite scrollbar

### 📁 File Management

- **Nvim-tree** - Fast file explorer with git integration
- **Telescope** - Fuzzy finder for files, text, buffers & more
- **Persistence** - Session management for save/restore workspaces
- **Project.nvim** - Smart project detection and quick switching
- **Spectre** - Advanced search and replace across files
- **Auto-save** - Automatic file saving

### 🎯 Code Intelligence

- **LSP Support** - Full Language Server Protocol with Mason
- **LSPSaga** - Enhanced LSP UI with better code actions & diagnostics
- **Autocompletion** - nvim-cmp with LSP, buffer, path & snippet sources
- **Treesitter** - Advanced syntax highlighting with Zig compiler (Windows compatible)
- **Trouble** - Beautiful diagnostics & quickfix list
- **Conform.nvim** - Modern auto-formatting with format-on-save
- **Flash** - Lightning-fast cursor movement and navigation
- **Harpoon** - Quick file bookmarking and switching

### 🐛 Debugging

- **nvim-dap** - Debug Adapter Protocol support
- **DAP UI** - Interactive debugging interface
- **DAP Virtual Text** - Inline variable values during debugging
- **Mason DAP** - Automatic debugger installation for Python, Node.js & Chrome

### 🔧 Git Integration

- **Gitsigns** - Git status in signcolumn with inline blame
- **Neogit** - Magit-style Git interface
- **Diffview** - Cycle through diffs & review changes
- **Git Blame** - Toggle git blame information

### 💡 Smart Editing

- **Auto-pairs** - Automatic bracket pairing
- **Comment.nvim** - Smart commenting
- **Surround** - Easily surround text with quotes, brackets, etc.
- **Multi-cursor** - Multiple cursor editing (vim-visual-multi)
- **Refactoring** - Advanced code refactoring tools
- **Todo Comments** - Highlight & navigate TODO, FIXME, etc.

### ⚡ Performance

- **Lazy.nvim** - Fast plugin manager with lazy loading
- **Optimized Startup** - Disabled unnecessary built-in plugins
- **Async Execution** - Non-blocking plugin operations
- **Large File Detection** - Auto-disable heavy features for large files

### 📦 Structure

- **Modular Design** - Clean organization in `/lua/core`
- **65+ Plugins** - Carefully selected and configured
- **Easy Customization** - Well-documented configuration files

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
- **JetBrainsMono Nerd Font** (for icons) - [Download here](https://www.nerdfonts.com/)

## 🔧 Installation

### 🚀 One-Click Installation (Recommended)

**The easiest way to install KHANOON.nvim - perfect for beginners!**

Open PowerShell and run:

```powershell
irm https://raw.githubusercontent.com/Thippharake-NaChiengmai/khanoon.nvim/main/install.ps1 | iex
```

Or download and run the installer:

1. Download: [install.ps1](https://raw.githubusercontent.com/Thippharake-NaChiengmai/khanoon.nvim/main/install.ps1)
2. Right-click the file → "Run with PowerShell"

**What the installer does:**

- ✅ Installs Neovim (latest stable)
- ✅ Installs all required tools (git, ripgrep, fd, fzf)
- ✅ Installs Node.js for LSP servers
- ✅ Downloads KHANOON.nvim configuration
- ✅ Installs JetBrainsMono Nerd Font
- ✅ Installs all 65+ plugins automatically

**Time required:** 5-10 minutes ⏱

After installation, just set your terminal font to **JetBrainsMono Nerd Font** and you're ready to go! 🎉

---

### 📦 Manual Installation

If you prefer to install manually or the one-click installer doesn't work:

#### Step 1: Install Prerequisites

##### Using Winget (Recommended)

```powershell
# Install Neovim
winget install Neovim.Neovim

# Install Git
winget install Git.Git

# Install Node.js
winget install OpenJS.NodeJS.LTS

# Install ripgrep (optional)
winget install BurntSushi.ripgrep.MSVC

# Install fd (optional)
winget install sharkdp.fd

# Install fzf (optional)
winget install junegunn.fzf
```

##### Using Chocolatey

```powershell
# Install Chocolatey first if you haven't
# Visit: https://chocolatey.org/install

# Install all dependencies
choco install neovim git nodejs ripgrep fd fzf -y
```

##### Using Scoop

```powershell
# Install Scoop first if you haven't
# Visit: https://scoop.sh

# Add buckets
scoop bucket add main
scoop bucket add extras

# Install all dependencies
scoop install neovim git nodejs ripgrep fd fzf
```

#### Step 2: Verify Installation

```powershell
# Verify Neovim
nvim --version
# Should show v0.9.0 or higher

# Verify Git
git --version

# Verify Node.js
node --version

# Verify ripgrep (optional)
rg --version

# Verify fd (optional)
fd --version
```

#### Step 3: Set Up Environment Variables

The installers should automatically add these to your PATH. To verify:

```powershell
# Check if commands are in PATH
Get-Command nvim
Get-Command git
Get-Command node
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

#### Step 4: Install KHANOON.nvim

```powershell
# Backup existing config (if any)
if (Test-Path "$env:LOCALAPPDATA\nvim") {
    Rename-Item -Path "$env:LOCALAPPDATA\nvim" -NewName "nvim.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
}

# Clone KHANOON.nvim
git clone https://github.com/Thippharake-NaChiengmai/khanoon.nvim.git "$env:LOCALAPPDATA\nvim"

# Navigate to config directory
cd "$env:LOCALAPPDATA\nvim"
```

#### Step 5: First Launch

```powershell
# Launch Neovim
nvim
```

On first launch:

1. **Lazy.nvim** will automatically bootstrap and install
2. All 60+ plugins will be downloaded and installed (lazy-loaded for performance)
3. Wait for the installation to complete (you'll see the Lazy UI)
4. **Restart Neovim** after installation completes
5. Run `:checkhealth` to verify everything is working

The KHANOON dashboard will appear on startup with quick access to common actions.

#### Step 6: Install Language Tools

**Treesitter Parsers** (for syntax highlighting):

```vim
:TSInstall lua vim python javascript typescript html css json markdown
:TSInstallInfo  " Check installation status
```

**LSP Servers** (for code intelligence):

```vim
:Mason  " Opens Mason UI

" Navigate with j/k, press 'i' to install, 'X' to uninstall
" Recommended servers:
" - lua_ls (Lua)
" - tsserver or ts_ls (JavaScript/TypeScript)
" - pyright (Python)
" - html, cssls, jsonls
" - emmet_ls (HTML/CSS)

" Or install via command:
:MasonInstall lua-language-server typescript-language-server pyright
```

**Debug Adapters** (already configured for Python, Node.js, Chrome):

```vim
:Mason
" Install: debugpy, node-debug2-adapter, chrome-debug-adapter
```

## ⌨️ Key Mappings

### General

| Key           | Mode   | Action                                |
| ------------- | ------ | ------------------------------------- |
| `<Space>`     | -      | Leader key (prefix for most commands) |
| `jk` / `kj`   | Insert | Exit to normal mode                   |
| `<leader>w`   | Normal | Save file                             |
| `<leader>q`   | Normal | Quit window                           |
| `<leader>x`   | Normal | Close current buffer                  |
| `<C-h/j/k/l>` | Normal | Navigate between windows (splits)     |
| `<S-h>`       | Normal | Previous buffer                       |
| `<S-l>`       | Normal | Next buffer                           |

### File Explorer (NvimTree)

| Key         | Action                                            |
| ----------- | ------------------------------------------------- |
| `<leader>e` | Toggle file explorer                              |
| `a`         | Create new file/folder (ends with `/` for folder) |
| `d`         | Delete file/folder                                |
| `r`         | Rename file/folder                                |
| `x`         | Cut file/folder                                   |
| `c`         | Copy file/folder                                  |
| `p`         | Paste file/folder                                 |
| `H`         | Toggle hidden files                               |
| `R`         | Refresh tree                                      |
| `?`         | Show help                                         |

### Fuzzy Finder (Telescope)

| Key                | Action                           |
| ------------------ | -------------------------------- |
| `<leader>ff`       | Find files                       |
| `<leader>fg`       | Live grep (search text in files) |
| `<leader>fb`       | Find buffers                     |
| `<leader>fh`       | Find help tags                   |
| `<leader>fo`       | Find recently opened files       |
| `<leader>fp`       | Find projects (Project switcher) |
| `<C-n>` / `<Down>` | Next item                        |
| `<C-p>` / `<Up>`   | Previous item                    |
| `<CR>`             | Open selected file               |
| `<C-x>`            | Open in horizontal split         |
| `<C-v>`            | Open in vertical split           |
| `<C-t>`            | Open in new tab                  |

### Session Management

| Key          | Action                     |
| ------------ | -------------------------- |
| `<leader>qs` | Restore session            |
| `<leader>ql` | Restore last session       |
| `<leader>qd` | Don't save current session |

### Search & Replace (Spectre)

| Key          | Action                          |
| ------------ | ------------------------------- |
| `<leader>sr` | Open Spectre (search & replace) |
| `<leader>sw` | Search current word             |
| `<leader>sf` | Search in current file          |

### LSP (Code Intelligence)

| Key          | Action                        |
| ------------ | ----------------------------- |
| `K`          | Hover documentation (LSPSaga) |
| `gd`         | Go to definition (LSPSaga)    |
| `gD`         | Peek definition (LSPSaga)     |
| `gr`         | Show references               |
| `gi`         | Go to implementation          |
| `<leader>ca` | Code action (LSPSaga)         |
| `<leader>rn` | Rename symbol (LSPSaga)       |
| `<leader>o`  | Outline (LSPSaga)             |
| `[d`         | Previous diagnostic (LSPSaga) |
| `]d`         | Next diagnostic (LSPSaga)     |
| `<leader>f`  | Format document               |
| `<leader>xx` | Toggle Trouble diagnostics    |
| `<leader>xw` | Workspace diagnostics         |
| `<leader>xd` | Document diagnostics          |

### Debugging (DAP)

| Key          | Action                     |
| ------------ | -------------------------- |
| `<F5>`       | Continue / Start debugging |
| `<F10>`      | Step over                  |
| `<F11>`      | Step into                  |
| `<F12>`      | Step out                   |
| `<leader>db` | Toggle breakpoint          |
| `<leader>dB` | Set conditional breakpoint |
| `<leader>dr` | Open REPL                  |
| `<leader>dl` | Run last debug session     |

### Git

| Key          | Action                |
| ------------ | --------------------- |
| `<leader>gg` | Open Neogit (Git UI)  |
| `<leader>gd` | Open Diffview         |
| `<leader>gh` | Diffview file history |
| `<leader>gb` | Toggle git blame line |
| `<leader>gp` | Preview hunk          |
| `<leader>gr` | Reset hunk            |
| `<leader>gs` | Stage hunk            |
| `]c`         | Next git hunk         |
| `[c`         | Previous git hunk     |

### Commenting

| Key         | Mode          | Action                       |
| ----------- | ------------- | ---------------------------- |
| `gcc`       | Normal        | Toggle line comment          |
| `gc`        | Visual        | Toggle comment for selection |
| `<leader>/` | Normal/Visual | Toggle comment               |

### Terminal

| Key          | Action                   |
| ------------ | ------------------------ |
| `<C-\>`      | Toggle floating terminal |
| `<leader>tf` | Float terminal           |
| `<leader>th` | Horizontal terminal      |
| `<leader>tv` | Vertical terminal        |

### Flash Navigation (Fast Movement)

| Key | Mode              | Action                             |
| --- | ----------------- | ---------------------------------- |
| `s` | Normal/Visual/Ops | Jump to any visible location       |
| `S` | Normal/Visual/Ops | Jump using Treesitter (smart jump) |
| `r` | Operator          | Remote Flash (for operations)      |
| `R` | Visual/Operator   | Treesitter search (select/operate) |

### Harpoon (File Bookmarks)

| Key          | Action                      |
| ------------ | --------------------------- |
| `<leader>ha` | Add current file to Harpoon |
| `<leader>hh` | Toggle Harpoon quick menu   |
| `<leader>1`  | Jump to Harpoon file 1      |
| `<leader>2`  | Jump to Harpoon file 2      |
| `<leader>3`  | Jump to Harpoon file 3      |
| `<leader>4`  | Jump to Harpoon file 4      |

### Formatting

| Key              | Mode    | Action                               |
| ---------------- | ------- | ------------------------------------ |
| `<leader>cf`     | Any     | Format current buffer                |
| `:FormatToggle`  | Command | Toggle format-on-save                |
| `:FormatToggle!` | Command | Toggle format-on-save (buffer-local) |

### Editing

| Key                | Mode   | Action                                                  |
| ------------------ | ------ | ------------------------------------------------------- |
| `ys<motion><char>` | Normal | Surround with char (e.g., `ysiw"` wraps word in quotes) |
| `ds<char>`         | Normal | Delete surrounding char                                 |
| `cs<old><new>`     | Normal | Change surrounding char                                 |
| `<C-n>`            | Visual | Multi-cursor (select next match)                        |
| `<C-x>`            | Visual | Multi-cursor (skip match)                               |
| `yy`               | Normal | Copy line                                               |
| `dd`               | Normal | Cut line                                                |
| `p`                | Normal | Paste after cursor                                      |
| `P`                | Normal | Paste before cursor                                     |
| `u`                | Normal | Undo                                                    |
| `<C-r>`            | Normal | Redo                                                    |

### Minimap

| Key          | Action         |
| ------------ | -------------- |
| `<leader>mo` | Toggle minimap |
| `<leader>mm` | Focus minimap  |

**Note:** Satellite scrollbar minimap is enabled by default and shows automatically on the right side.

### Navigation

| Key     | Action                   |
| ------- | ------------------------ |
| `<C-d>` | Scroll down half page    |
| `<C-u>` | Scroll up half page      |
| `gg`    | Go to first line         |
| `G`     | Go to last line          |
| `%`     | Jump to matching bracket |

## 🎨 Customization

### Change Theme

Edit `lua/core/theme.lua`:

```lua
-- Available Catppuccin flavours:
-- latte (light)
-- frappe (medium dark)
-- macchiato (dark)
-- mocha (darkest - default)
flavour = "mocha"  -- Change to your preferred flavour

-- Or switch themes in Neovim:
:Catppuccin mocha
:Catppuccin frappe
:Catppuccin macchiato
:Catppuccin latte
```

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

Edit `lua/plugins.lua` and add to the plugin list:

```lua
return {
  -- ... existing plugins ...

  -- Add your plugin here
  {
    'author/plugin-name',
    lazy = true,  -- Optional: lazy load
    config = function()
      -- Plugin configuration
    end,
  },
}
```

Then run:

```vim
:Lazy sync
```

### Modify Keymaps

Edit `lua/core/keymaps.lua` to customize key mappings to your preference.

## 🐛 Troubleshooting

### Plugins not installing

```vim
:Lazy sync     " Sync all plugins
:Lazy clean    " Remove unused plugins
:Lazy update   " Update all plugins
```

Check plugin status:

```vim
:Lazy          " Open Lazy UI
```

### LSP not working

```vim
:Mason         " Check if language server is installed
:LspInfo       " Check LSP status for current buffer
:checkhealth   " Run full health check
```

Debug LSP:

```vim
:LspLog        " View LSP logs
:LspRestart    " Restart LSP server
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

**Windows users**: Ensure Zig is installed for Treesitter compilation:

```powershell
winget install zig.zig
```

### DAP (Debugging) not working

```vim
:Mason         " Install debuggers: debugpy, node-debug2-adapter
:checkhealth dap
```

Ensure debug adapters are configured in `lua/core/dap.lua`.

**Q: Icons not showing**

1. Install a Nerd Font from [nerdfonts.com](https://www.nerdfonts.com/)
2. Set the font in your terminal (e.g., "JetBrainsMono Nerd Font")
3. Restart terminal and Neovim

**Q: Formatting not working**

- A: Install formatters via `:Mason` (e.g., `stylua`, `prettier`, `black`)
- Check `:ConformInfo` for status
- Toggle format-on-save with `:FormatToggle`

**Q: Rainbow brackets not showing**

- A: Ensure Treesitter is properly installed: `:TSInstallInfo`
- Install language parser: `:TSInstall <language>`

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
:Lazy sync
```

### Update Plugins

```vim
:Lazy update   " Update all plugins
:Lazy sync     " Sync (install/update/clean)
```

### Update LSP Servers & Debuggers

```vim
:Mason
# Press 'U' to update all installed tools
```

### Update Treesitter Parsers

```vim
:TSUpdate all
```

### Full System Update

```vim
:Lazy update
:Mason
" Press 'U' in Mason
:TSUpdate all
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
- `:Lazy` - Manage plugins
- `:Mason` - Manage LSP servers & debuggers
- `:TSInstallInfo` - Check Treesitter status
- `:LspInfo` - Check LSP status
- `<Space>` then wait - See all available keybindings (Which-key)
- See `FEATURES.md` for comprehensive feature guide

### Common Issues

**Q: Neovim is slow**

- A: Disable treesitter for large files (already configured)
- Run `:checkhealth` to find issues

**Q: LSP autocomplete not working**

- A: Install language server via `:Mason`
- Check `:LspInfo` for errors
- Run `:checkhealth lsp`

**Q: Git signs not showing**

- A: Ensure you're in a git repository
- Check `:Gitsigns status`

**Q: Debugging not working**

- A: Install debuggers via `:Mason`
- Check `:checkhealth dap`
- Ensure debug adapters are configured in `lua/core/dap.lua`

**Q: Plugins not loading**

- A: Run `:Lazy sync`
- Check `:Lazy` UI for errors
- Restart Neovim

## 🤝 Contributing

Contributions are welcome! Feel free to:

- Report bugs
- Suggest features
- Submit pull requests

## 📝 License

MIT License - feel free to use and modify!

## 🙏 Acknowledgments

This configuration is powered by 65+ carefully selected plugins:

### Core Infrastructure

- [lazy.nvim](https://github.com/folke/lazy.nvim) - Fast plugin manager with lazy loading
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Lua utility functions

### UI/UX

- [catppuccin](https://github.com/catppuccin/nvim) - Soothing pastel theme with excellent plugin integration
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Status line
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - Buffer tabs
- [alpha-nvim](https://github.com/goolord/alpha-nvim) - Dashboard
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Command palette
- [noice.nvim](https://github.com/folke/noice.nvim) - Modern UI
- [nvim-notify](https://github.com/rcarriga/nvim-notify) - Notifications
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) - Floating terminal
- [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) - Rainbow brackets
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) - Indent guides
- [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) - Color highlighter
- [tiny-inline-diagnostic.nvim](https://github.com/rachartier/tiny-inline-diagnostic.nvim) - Inline diagnostics

### File Management

- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) - File explorer
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [persistence.nvim](https://github.com/folke/persistence.nvim) - Session management
- [project.nvim](https://github.com/ahmedkhalf/project.nvim) - Project management
- [nvim-spectre](https://github.com/nvim-pack/nvim-spectre) - Search and replace

### Code Intelligence

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP support
- [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP/DAP installer
- [lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim) - Enhanced LSP UI
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Autocompletion
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting
- [trouble.nvim](https://github.com/folke/trouble.nvim) - Diagnostics
- [conform.nvim](https://github.com/stevearc/conform.nvim) - Auto-formatting

### Debugging

- [nvim-dap](https://github.com/mfussenegger/nvim-dap) - Debug Adapter Protocol
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) - DAP UI
- [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) - Inline debugging

### Git

- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git signs
- [neogit](https://github.com/NeogitOrg/neogit) - Git interface
- [diffview.nvim](https://github.com/sindrets/diffview.nvim) - Diff viewer
- [git-blame.nvim](https://github.com/f-person/git-blame.nvim) - Git blame

### Navigation & Productivity

- [flash.nvim](https://github.com/folke/flash.nvim) - Fast cursor movement
- [harpoon](https://github.com/ThePrimeagen/harpoon) - File bookmarks
- [codewindow.nvim](https://github.com/gorbit99/codewindow.nvim) - Code overview minimap
- [satellite.nvim](https://github.com/lewis6991/satellite.nvim) - Scrollbar minimap with git/diagnostic signs

### Editing

- [Comment.nvim](https://github.com/numToStr/Comment.nvim) - Commenting
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Auto-pairs
- [nvim-surround](https://github.com/kylechui/nvim-surround) - Surround text
- [vim-visual-multi](https://github.com/mg979/vim-visual-multi) - Multi-cursor
- [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim) - Refactoring
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - TODO highlighting
- [auto-save.nvim](https://github.com/Pocco81/auto-save.nvim) - Auto-save

And many more! See `lua/plugins.lua` for the complete list.

Special thanks to the Neovim community and all plugin authors! 🙏

---

**Made with ❤️ by KHANOON**

_Happy coding! 🚀_
