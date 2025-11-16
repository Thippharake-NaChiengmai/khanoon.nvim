-- =============================================================================
-- Theme Configuration
-- =============================================================================

local status_ok, tokyonight = pcall(require, 'tokyonight')
if not status_ok then
  vim.notify("Theme 'tokyonight' failed to load.", vim.log.levels.WARN)
  return
end

tokyonight.setup({
  style = "storm",
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
  },
})

vim.cmd('colorscheme tokyonight')
