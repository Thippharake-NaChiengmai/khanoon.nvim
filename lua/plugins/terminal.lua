-- =============================================================================
-- ToggleTerm — Floating Terminal + LazyGit Integration
-- Lazy-loaded: only activates on Ctrl+\ or :ToggleTerm
-- =============================================================================
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = "ToggleTerm",
  keys = {
    { "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
    { "<C-\\>", "<cmd>ToggleTerm<CR>", mode = "t", desc = "Toggle terminal" },
  },
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<C-\>]],
      direction = "float",
      float_opts = {
        border = "curved",
        winblend = 3,
      },
      highlights = {
        FloatBorder = { link = "FloatBorder" },
      },
      shell = vim.o.shell,
    })

    -- Terminal mode keymaps for easy navigation
    vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
    vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Move to left window" })
    vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Move to lower window" })
    vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Move to upper window" })
    vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Move to right window" })

    -- LazyGit integration: open lazygit in a floating terminal
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "curved",
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.keymap.set("t", "q", "<cmd>close<CR>", { buffer = term.bufnr, silent = true })
      end,
    })

    vim.keymap.set("n", "<leader>gl", function() lazygit:toggle() end, { desc = "LazyGit" })
  end,
}
