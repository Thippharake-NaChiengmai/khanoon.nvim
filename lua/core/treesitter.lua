-- =============================================================================
-- Treesitter Configuration
-- =============================================================================

local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  vim.notify("Plugin 'nvim-treesitter' failed to load.", vim.log.levels.WARN)
  return
end

treesitter.setup({
  ensure_installed = {
    "java", "lua", "vim", "python", "go", "php",
    "javascript", "typescript", "tsx", "vue",
    "html", "css", "json", "markdown"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  autopairs = {
    enable = true
  },
})
