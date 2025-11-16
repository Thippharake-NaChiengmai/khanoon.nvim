--[[

  Neovim 'init.lua' Configuration
  Optimized for stability and performance.
  
  All plugin configurations have been modularized in /lua/core

--]]

-- =============================================================================
-- Bootstrap Packer Plugin Manager
-- =============================================================================
-- Ensure packer is installed before loading plugins
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- =============================================================================
-- Load Plugins
-- =============================================================================
require('plugins')

-- Automatically run :PackerCompile whenever plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- =============================================================================
-- Load Core Configurations
-- =============================================================================
-- Load configurations in order
local core_modules = {
  'core.options',      -- Vim options and settings
  'core.alpha',        -- Dashboard/Startup screen
  'core.keymaps',      -- General keymaps
  'core.theme',        -- Theme/colorscheme
  'core.bufferline',   -- Bufferline configuration
  'core.lualine',      -- Status line
  'core.treesitter',   -- Syntax highlighting
  'core.gitsigns',     -- Git integration
  'core.lsp',          -- LSP and completion
}

for _, module in ipairs(core_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    vim.notify('Error loading ' .. module .. '\n' .. err, vim.log.levels.ERROR)
  end
end

-- =============================================================================
-- Post-setup
-- =============================================================================
-- Automatically install plugins on first launch
if packer_bootstrap then
  require('packer').sync()
end
