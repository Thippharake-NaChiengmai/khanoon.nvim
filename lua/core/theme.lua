-- =============================================================================
-- Theme Configuration
-- =============================================================================

local status_ok, github_theme = pcall(require, 'github-theme')
if not status_ok then
  vim.notify("Theme 'github-theme' failed to load.", vim.log.levels.WARN)
  return
end

github_theme.setup({
  options = {
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = 'italic',
      keywords = 'bold',
      types = 'italic,bold',
    },
  },
})

-- Theme: github_dark, github_dark_dimmed, github_dark_high_contrast, github_light, github_light_high_contrast 
vim.cmd('colorscheme github_dark')
