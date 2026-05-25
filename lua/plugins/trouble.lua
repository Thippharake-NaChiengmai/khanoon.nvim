-- =============================================================================
-- Trouble — Pretty Diagnostics List
-- Lazy-loaded: only activates on keymaps or :Trouble command
-- =============================================================================
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Workspace diagnostics" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols (Trouble)" },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", desc = "LSP references" },
    { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Todo comments" },
  },
  opts = {
    auto_close = true,       -- Close when no more diagnostics
    use_diagnostic_signs = true,
  },
}
