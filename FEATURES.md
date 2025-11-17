# 🚀 KHANOON.nvim Feature Guide

## ✨ New Features Overview

### 1. 🐛 Debugging with DAP

**Setup:**

```vim
:Mason
" Install debuggers:
" - debugpy (Python)
" - node-debug2 (Node.js)
" - chrome-debug-adapter (Chrome/Web)
```

**Keymaps:**

- `<leader>db` - Toggle breakpoint
- `<leader>dc` - Continue/Start debugging
- `<leader>di` - Step into
- `<leader>do` - Step over
- `<leader>dO` - Step out
- `<leader>dt` - Terminate
- `<leader>du` - Toggle DAP UI
- `<F5>` - Continue
- `<F10>` - Step over
- `<F11>` - Step into
- `<F12>` - Step out

**Example:**

1. Open a Python file
2. Press `<leader>db` to set breakpoint
3. Press `<leader>dc` to start debugging
4. Use `<F10>` to step through code

---

### 2. 🎯 Git Workflow with Neogit

**Keymaps:**

- `<leader>gg` - Open Neogit (full Git UI)
- `<leader>gd` - Open Diffview
- `<leader>gh` - Git file history
- `<leader>gb` - Toggle Git blame
- `<leader>gdo` - Open diff view
- `<leader>gdc` - Close diff view

**Neogit Commands:**

- `s` - Stage file/hunk
- `u` - Unstage file/hunk
- `c` - Commit
- `P` - Push
- `p` - Pull
- `F` - Fetch
- `l` - Log
- `b` - Branch
- `?` - Show help

**Example Workflow:**

1. Press `<leader>gg` to open Neogit
2. Navigate to changed files
3. Press `s` to stage
4. Press `c` to commit
5. Write commit message and save
6. Press `P` to push

---

### 3. 💡 Code Intelligence (LSPSaga)

**Keymaps:**

- `K` - Hover documentation (Saga)
- `gd` - Go to definition (Saga)
- `gD` - Peek definition (floating)
- `<leader>ca` - Code action (with preview)
- `<leader>rn` - Rename (with preview)
- `<leader>o` - Toggle outline
- `[d` - Previous diagnostic
- `]d` - Next diagnostic

**Features:**

- Floating documentation
- Code action lightbulb 💡
- Hover with better UI
- Peek definition (no split)
- Outline navigator

---

### 4. 📋 Command Palette (Which-key)

**Usage:**

- Press `<leader>` and wait 500ms
- A popup shows all available commands
- Navigate with `j/k`
- Press the key to execute

**Categories:**

- `<leader>f` - Find (Telescope)
- `<leader>g` - Git operations
- `<leader>d` - Debug (DAP)
- `<leader>x` - Diagnostics (Trouble)
- `<leader>c` - Code actions
- `<leader>r` - Refactoring

---

### 5. 🔍 Better Diagnostics (Trouble)

**Keymaps:**

- `<leader>xx` - Toggle diagnostics
- `<leader>xX` - Buffer diagnostics only
- `<leader>cs` - Symbols
- `<leader>cl` - LSP references

**In Trouble window:**

- `Enter` - Jump to location
- `Tab` - Jump and stay in Trouble
- `q` - Close
- `r` - Refresh

---

### 6. 📝 Enhanced Editing

**Multiple Cursors:**

- `<C-n>` - Start multi-cursor
- `<C-n>` - Select next occurrence
- `<C-x>` - Skip current occurrence
- `n/N` - Navigate cursors
- `q` - Remove cursor

**Surround:**

- `ys{motion}{char}` - Add surround
- `ds{char}` - Delete surround
- `cs{old}{new}` - Change surround
- Example: `ysiw"` - Surround word with quotes

**Auto-save:**

- `:ASToggle` - Toggle auto-save
- Saves on InsertLeave and TextChanged

---

### 7. 🎨 Better UI/UX (Noice)

**Features:**

- Command palette style cmdline
- Floating messages
- LSP progress in bottom right
- Prettier notifications
- Better search UI

**Commands:**

- `:Noice` - Show message history
- `:Noice telescope` - Search messages
- `:Noice errors` - Show only errors

---

### 8. 🖥️ Floating Terminal (ToggleTerm)

**Keymaps:**

- `<C-\>` - Toggle terminal
- In terminal: `<C-\>` to hide

**Usage:**

```vim
" Open Python REPL
:ToggleTerm direction=float

" Run command
:ToggleTerm size=20 direction=horizontal cmd="npm run dev"

" Multiple terminals
:1ToggleTerm
:2ToggleTerm
:3ToggleTerm
```

---

### 9. 🔧 Refactoring Tools

**Keymaps (Visual mode):**

- `<leader>re` - Extract function
- `<leader>rf` - Extract to file

**Example:**

1. Select code in visual mode
2. Press `<leader>re`
3. Name the function
4. Code is extracted

---

### 10. 📝 TODO Comments

**Syntax:**

```lua
-- TODO: Something to do
-- FIXME: This needs fixing
-- HACK: Temporary workaround
-- NOTE: Important note
-- WARNING: Be careful here
```

**Commands:**

- `:TodoTelescope` - Search all TODOs
- `:TodoQuickFix` - Send to quickfix
- `:TodoLocList` - Send to location list

---

## 🎯 Lazy.nvim Commands

**Plugin Management:**

- `:Lazy` - Open UI
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Install + Update + Clean
- `:Lazy clean` - Remove unused plugins
- `:Lazy profile` - View startup time
- `:Lazy log` - View recent changes
- `:Lazy check` - Check for updates

**In Lazy UI:**

- `u` - Update plugins
- `I` - Install
- `C` - Check for updates
- `S` - Sync
- `X` - Clean
- `L` - Log
- `P` - Profile
- `?` - Help

---

## 🚀 Performance Tips

1. **Check startup time:**

   ```vim
   :Lazy profile
   ```

2. **Disable unused plugins:**
   Edit `plugins.lua` and comment out unwanted plugins

3. **Lazy load more:**
   Add `event`, `cmd`, or `keys` to plugin config

4. **Clear cache:**
   ```vim
   :Lazy clear
   ```

---

## 🐛 Troubleshooting

### Plugins not installing

```vim
:Lazy
# Press 'I' to install
```

### LSP not working

```vim
:Mason
# Install language servers
:LspInfo
```

### Treesitter errors

```vim
:TSUpdate
:TSInstall lua vim python javascript
```

### DAP not working

```vim
:Mason
# Install debuggers: debugpy, node-debug2
```

---

## 📚 More Resources

- `:help lazy.nvim`
- `:help dap`
- `:help lspsaga`
- `:help which-key`
- `:help trouble`

---

**Happy Coding! 🎉**
