-- =============================================================================
-- Neovim Options Configuration
-- =============================================================================

local opt = vim.opt
local g = vim.g

-- --- General Settings ---
opt.number = true         -- Show line numbers
opt.relativenumber = false -- Disable relative line numbers (use absolute line numbers)
opt.mouse = 'a'           -- Enable mouse support
opt.wrap = false          -- Disable line wrapping
opt.scrolloff = 8         -- Keep 8 lines of context around the cursor
opt.clipboard = "unnamedplus" -- Use system clipboard

-- --- Indentation ---
opt.tabstop = 2           -- Tab width of 2 spaces
opt.shiftwidth = 2        -- Indent width of 2 spaces
opt.expandtab = true      -- Use spaces instead of tabs

-- --- Search ---
opt.ignorecase = true     -- Ignore case in search
opt.smartcase = true      -- But respect case if uppercase is used

-- --- Appearance ---
opt.termguicolors = true  -- Enable 24-bit RGB colors

-- --- Leader Key ---
g.mapleader = ' '         -- Set leader key to space

-- --- Disable Netrw (for nvim-tree) ---
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
