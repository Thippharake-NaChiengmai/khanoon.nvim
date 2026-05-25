-- =============================================================================
-- Autocommands — Lean & Essential Only
-- =============================================================================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- =============================================================================
-- Visual Feedback
-- =============================================================================

-- Highlight yanked text briefly
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Show cursorline only in active window
autocmd({ "InsertLeave", "WinEnter" }, {
  group = augroup("auto_cursorline_show", { clear = true }),
  callback = function()
    if vim.bo.filetype ~= "" then
      vim.opt_local.cursorline = true
    end
  end,
})

autocmd({ "InsertEnter", "WinLeave" }, {
  group = augroup("auto_cursorline_hide", { clear = true }),
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- =============================================================================
-- Window Management
-- =============================================================================

-- Auto-resize splits when terminal is resized
autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- =============================================================================
-- Buffer Behavior
-- =============================================================================

-- Close special buffers with 'q'
autocmd("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = {
    "help", "lspinfo", "man", "qf", "checkhealth",
    "startuptime", "query", "notify", "git",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- Disable auto-commenting on new lines
autocmd("BufEnter", {
  group = augroup("no_auto_comment", { clear = true }),
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Restore cursor position on file open
autocmd("BufReadPost", {
  group = augroup("restore_cursor", { clear = true }),
  callback = function(event)
    local exclude = { "gitcommit", "commit", "gitrebase" }
    if vim.tbl_contains(exclude, vim.bo[event.buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- =============================================================================
-- File Operations
-- =============================================================================

-- Auto-create parent directories on save
autocmd("BufWritePre", {
  group = augroup("auto_mkdir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Trim trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("trim_whitespace", { clear = true }),
  callback = function()
    local save = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save)
  end,
})

-- =============================================================================
-- Performance
-- =============================================================================

-- Optimize large files
autocmd("BufReadPre", {
  group = augroup("large_file", { clear = true }),
  callback = function(event)
    local max_size = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.uv.fs_stat, event.match)
    if ok and stats and stats.size > max_size then
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.opt_local.signcolumn = "no"
      vim.cmd("syntax off")
      vim.schedule(function() vim.cmd("LspStop") end)
    end
  end,
})

-- =============================================================================
-- Terminal
-- =============================================================================

-- Clean terminal buffers
autocmd("TermOpen", {
  group = augroup("term_settings", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
})

-- =============================================================================
-- Git
-- =============================================================================

-- Check for external file changes
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime", { clear = true }),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Git commit settings
autocmd("FileType", {
  group = augroup("git_commit", { clear = true }),
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 72
  end,
})
