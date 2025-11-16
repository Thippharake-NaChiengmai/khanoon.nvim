-- =============================================================================
-- Autopairs Configuration
-- =============================================================================
-- Note: Autopairs is configured in plugins.lua
-- This file provides additional customization

local status_ok, autopairs = pcall(require, 'nvim-autopairs')
if not status_ok then
  vim.notify("Plugin 'nvim-autopairs' failed to load.", vim.log.levels.WARN)
  return
end

-- Autopairs is already setup in plugins.lua
-- Integration with nvim-cmp is handled in core/lsp.lua

-- Auto pairs will work automatically for:
-- ( ) [ ] { } ' " ` < >

-- Additional customization can be added here if needed
-- Example: Custom rules for specific filetypes
