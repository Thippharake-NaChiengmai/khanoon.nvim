--[[

  KHANOON.nvim - Modern Neovim Configuration
  Optimized for stability, performance, and productivity
  
  Features:
  - Lazy.nvim for fast plugin management
  - Full LSP support with Mason
  - DAP debugging integration
  - Git workflow automation
  - Advanced UI/UX with floating windows
  - Async job execution

--]]

-- =============================================================================
-- Bootstrap lazy.nvim Plugin Manager
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Must load options before lazy.nvim
require('core.options')

-- =============================================================================
-- Load Plugins with lazy.nvim
-- =============================================================================
require('plugins')

-- =============================================================================
-- Load Core Configurations
-- =============================================================================
local core_modules = {
  'core.keymaps',      -- Key mappings
  'core.autocmds',     -- Autocommands
  'core.theme',        -- Colorscheme
  'core.alpha',        -- Dashboard
  'core.bufferline',   -- Buffer tabs
  'core.lualine',      -- Status line
  'core.treesitter',   -- Syntax highlighting
  'core.gitsigns',     -- Git integration
  'core.lsp',          -- LSP & completion
  'core.dap',          -- Debugging (DAP)
  'core.git',          -- Advanced Git workflow
}

for _, module in ipairs(core_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    vim.notify('Error loading ' .. module .. '\n' .. err, vim.log.levels.ERROR)
  end
end
