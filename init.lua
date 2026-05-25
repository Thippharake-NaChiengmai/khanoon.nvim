--[[
  KHANOON.nvim — Zero-Bloat Neovim IDE
  Modular configuration with aggressive lazy-loading
--]]

-- =============================================================================
-- Disable Unused Built-in Plugins (shaves ~15-25ms off startup)
-- =============================================================================
local disabled_builtins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "tohtml",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
  "matchparen",
  "tutor_mode_plugin",
  "rplugin",
  "man",
  "editorconfig",
}

for _, plugin in ipairs(disabled_builtins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Disable providers we don't need
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- =============================================================================
-- Leader Key (must be set before lazy.nvim)
-- =============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =============================================================================
-- Load Core Settings
-- =============================================================================
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- =============================================================================
-- Bootstrap lazy.nvim
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

-- =============================================================================
-- Load Plugins (auto-imports all files from lua/plugins/)
-- =============================================================================
require("lazy").setup("plugins", {
  install = {
    colorscheme = { "kanagawa", "habamax" },
  },
  checker = {
    enabled = true,
    notify = false,       -- Don't spam notifications about updates
  },
  change_detection = {
    enabled = true,
    notify = false,       -- Silent config reload
  },
  performance = {
    cache = {
      enabled = true,     -- Bytecode cache for faster startup
    },
    rtp = {
      disabled_plugins = disabled_builtins,
    },
  },
  rocks = {
    enabled = false,      -- No luarocks dependency
  },
  ui = {
    border = "rounded",
    title = "  KHANOON.nvim ",
  },
})
