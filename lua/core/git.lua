-- =============================================================================
-- Advanced Git Workflow Configuration
-- =============================================================================

-- Neogit is configured in plugins.lua with lazy loading
-- This file provides additional git-related keymaps and automation

-- Git keymaps
local keymap = vim.keymap.set

-- Git operations
keymap('n', '<leader>gb', '<cmd>GitBlameToggle<cr>', { desc = "Toggle Git Blame" })
keymap('n', '<leader>gB', '<cmd>GitBlame<cr>', { desc = "Show Git Blame" })

-- Diffview shortcuts
keymap('n', '<leader>gdo', '<cmd>DiffviewOpen<cr>', { desc = "Open Diff View" })
keymap('n', '<leader>gdc', '<cmd>DiffviewClose<cr>', { desc = "Close Diff View" })
keymap('n', '<leader>gdf', '<cmd>DiffviewFileHistory %<cr>', { desc = "File History" })

-- Create autocmd for Git commit messages
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 72
  end,
})

-- Auto-update gitsigns on file save
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  callback = function()
    local gs_ok, gitsigns = pcall(require, "gitsigns")
    if gs_ok then
      gitsigns.refresh()
    end
  end,
})
