-- =============================================================================
-- Comment Configuration
-- =============================================================================
-- Note: Comment.nvim is configured in plugins.lua
-- This file provides additional keymaps and settings

local status_ok, comment = pcall(require, 'Comment')
if not status_ok then
  vim.notify("Plugin 'Comment' failed to load.", vim.log.levels.WARN)
  return
end

-- Comment.nvim is already setup in plugins.lua
-- But we keep this file for consistency and future customization

-- Additional keymaps are defined in core/keymaps.lua
-- Default keybindings:
-- gcc - Toggle line comment
-- gbc - Toggle block comment
-- gc[motion] - Toggle comment with motion
-- gb[motion] - Toggle block comment with motion
