-- =============================================================================
-- Bufferline Configuration
-- =============================================================================

local status_ok, bufferline = pcall(require, 'bufferline')
if not status_ok then
  vim.notify("Plugin 'bufferline' failed to load.", vim.log.levels.WARN)
  return
end

bufferline.setup({
  options = {
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      }
    }
  }
})
