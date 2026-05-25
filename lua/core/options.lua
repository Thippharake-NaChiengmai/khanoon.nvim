-- =============================================================================
-- Neovim Options — Minimal, Fast, IDE-Ready
-- =============================================================================

local opt = vim.opt

-- --- Line Numbers ---
opt.number = true              -- Show absolute line number on current line
opt.relativenumber = true      -- Relative numbers for easy jumping (5j, 12k)
opt.signcolumn = "yes"         -- Always show sign column (no layout shift)
opt.cursorline = true          -- Highlight current line

-- --- Indentation ---
opt.tabstop = 2                -- Tab = 2 spaces
opt.shiftwidth = 2             -- Indent = 2 spaces
opt.softtabstop = 2            -- Consistent feel
opt.expandtab = true           -- Spaces instead of tabs
opt.smartindent = true         -- Smart auto-indenting
opt.shiftround = true          -- Round indent to multiple of shiftwidth

-- --- Search ---
opt.ignorecase = true          -- Case-insensitive search
opt.smartcase = true           -- ...unless uppercase is used
opt.hlsearch = true            -- Highlight matches
opt.incsearch = true           -- Incremental search

-- --- Appearance ---
opt.termguicolors = true       -- 24-bit RGB colors
opt.wrap = false               -- No line wrapping
opt.scrolloff = 8              -- Keep 8 lines visible above/below cursor
opt.sidescrolloff = 8          -- Keep 8 columns visible left/right
opt.showmode = false           -- Lualine shows mode instead
opt.pumheight = 10             -- Max completion popup height
opt.cmdheight = 1              -- Command line height
opt.laststatus = 3             -- Global statusline
opt.fillchars = {
  eob = " ",                   -- Hide ~ on empty lines
  fold = " ",
  foldopen = "▾",
  foldclose = "▸",
  foldsep = " ",
  diff = "╱",
}

-- --- Splits ---
opt.splitright = true          -- Vertical splits open to the right
opt.splitbelow = true          -- Horizontal splits open below
opt.splitkeep = "screen"       -- Keep text on screen when splitting

-- --- Files & Undo ---
opt.undofile = true            -- Persistent undo across sessions
opt.undolevels = 10000         -- Maximum undo levels
opt.swapfile = false           -- No swap files
opt.backup = false             -- No backup files
opt.writebackup = false        -- No write backup
opt.updatetime = 200           -- Faster CursorHold events (default 4000ms)
opt.timeoutlen = 300           -- Faster key sequence completion

-- --- Clipboard ---
opt.clipboard = "unnamedplus"  -- Use system clipboard

-- --- Mouse ---
opt.mouse = "a"               -- Full mouse support

-- --- Completion ---
opt.completeopt = "menu,menuone,noselect" -- Better completion experience
opt.shortmess:append("cI")    -- Don't show completion messages, no intro

-- --- Grep ---
opt.grepprg = "rg --vimgrep"  -- Use ripgrep if available
opt.grepformat = "%f:%l:%c:%m"
