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

-- --- Better window navigation ---
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- --- Buffer navigation ---
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)
keymap('n', '<leader>x', ':bdelete<CR>', { desc = "Close Buffer" })

-- --- Save and Quit ---
keymap('n', '<leader>w', ':w<CR>', { desc = "Save File" })
keymap('n', '<leader>q', ':q<CR>', { desc = "Quit" })
keymap('n', '<leader>Q', ':qa!<CR>', { desc = "Quit All" })

-- --- Better paste ---
keymap('v', 'p', '"_dP', opts)

-- --- Stay in indent mode ---
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- --- Move text up and down ---
keymap('v', '<A-j>', ':m .+1<CR>==', opts)
keymap('v', '<A-k>', ':m .-2<CR>==', opts)
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)

-- --- LSP Saga (if available) ---
keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = "Code Action" })
keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { desc = "Hover Documentation" })
keymap('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', { desc = "Rename" })
keymap('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', { desc = "Go to Definition" })
keymap('n', 'gD', '<cmd>Lspsaga peek_definition<CR>', { desc = "Peek Definition" })
keymap('n', '<leader>o', '<cmd>Lspsaga outline<CR>', { desc = "Toggle Outline" })

-- --- Diagnostics ---
keymap('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { desc = "Previous Diagnostic" })
keymap('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', { desc = "Next Diagnostic" })

-- --- Terminal ---
keymap('n', '<C-\\>', '<cmd>ToggleTerm<CR>', { desc = "Toggle Terminal" })
keymap('t', '<C-\\>', '<cmd>ToggleTerm<CR>', { desc = "Toggle Terminal" })

-- --- Quick Fix ---
keymap('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = "Diagnostics (Trouble)" })
keymap('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = "Buffer Diagnostics (Trouble)" })

-- --- Macro ---
keymap('n', 'Q', 'q', { desc = "Start/Stop Recording Macro" })
keymap('n', 'q', '<Nop>', opts)  -- Disable accidental macro recording

-- --- Clear search highlight ---
keymap('n', '<Esc>', ':nohlsearch<CR>', opts)

-- --- Better jk ---
keymap('i', 'jk', '<Esc>', opts)
keymap('i', 'kj', '<Esc>', opts)
