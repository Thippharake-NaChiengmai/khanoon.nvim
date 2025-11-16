-- =============================================================================
-- Keymaps Configuration
-- =============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- --- File Explorer (NvimTree) ---
keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Toggle File Explorer" })

-- --- Commenting ---
keymap('n', '<C-_>', ':CommentToggle<CR>', opts)
keymap('v', '<C-_>', ":'<,'>CommentToggle<CR>", opts)
