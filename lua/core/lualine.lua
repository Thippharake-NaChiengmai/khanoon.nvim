-- =============================================================================
-- Lualine Configuration
-- =============================================================================

local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  vim.notify("Plugin 'lualine' failed to load.", vim.log.levels.WARN)
  return
end

lualine.setup({
  options = {
    theme = 'auto',  -- Auto-detect theme from colorscheme
    icons_enabled = true,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
})
