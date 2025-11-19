-- =============================================================================
-- Autocommands Configuration
-- Automatic behaviors and events
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
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight when yanking (copying) text",
})

-- =============================================================================
-- Window Management
-- =============================================================================

-- Auto-resize splits when window is resized
autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
  desc = "Resize splits if window got resized",
})

-- =============================================================================
-- Buffer Management
-- =============================================================================

-- Close certain filetypes with 'q'
autocmd("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = {
    "help",
    "lspinfo",
    "man",
    "qf",
    "checkhealth",
    "startuptime",
    "query",
    "notify",
    "git",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { 
      buffer = event.buf, 
      silent = true,
      desc = "Close window"
    })
  end,
  desc = "Close special buffers with q",
})

-- Disable auto-commenting on new line
autocmd("BufEnter", {
  group = augroup("disable_auto_comment", { clear = true }),
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable auto-commenting on new lines",
})

-- =============================================================================
-- File Operations
-- =============================================================================

-- Auto-create directories when saving a file
autocmd("BufWritePre", {
  group = augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Auto create directories when saving file",
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("trim_whitespace", { clear = true }),
  pattern = "*",
  callback = function()
    -- Save cursor position
    local save_cursor = vim.fn.getpos(".")
    -- Remove trailing whitespace
    vim.cmd([[%s/\s\+$//e]])
    -- Restore cursor position
    vim.fn.setpos(".", save_cursor)
  end,
  desc = "Remove trailing whitespace on save",
})

-- =============================================================================
-- LSP Improvements
-- =============================================================================

-- Show cursor line only in active window
autocmd({ "InsertLeave", "WinEnter" }, {
  group = augroup("auto_cursorline_show", { clear = true }),
  callback = function()
    if vim.bo.filetype ~= "alpha" then
      vim.opt.cursorline = true
    end
  end,
  desc = "Show cursor line in active window",
})

autocmd({ "InsertEnter", "WinLeave" }, {
  group = augroup("auto_cursorline_hide", { clear = true }),
  callback = function()
    vim.opt.cursorline = false
  end,
  desc = "Hide cursor line in inactive window",
})

-- =============================================================================
-- Large File Handling
-- =============================================================================

-- Disable certain features for large files
autocmd("BufReadPre", {
  group = augroup("large_file", { clear = true }),
  callback = function(event)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, event.match)
    
    if ok and stats and stats.size > max_filesize then
      vim.notify("Large file detected, disabling some features...", vim.log.levels.WARN)
      
      -- Disable features for large files
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.opt_local.breakindent = false
      vim.opt_local.colorcolumn = ""
      vim.opt_local.statuscolumn = ""
      vim.opt_local.signcolumn = "no"
      
      -- Disable treesitter
      vim.cmd("syntax off")
      
      -- Disable LSP
      vim.schedule(function()
        vim.cmd("LspStop")
      end)
    end
  end,
  desc = "Optimize settings for large files",
})

-- =============================================================================
-- Terminal
-- =============================================================================

-- Start terminal in insert mode
autocmd("TermOpen", {
  group = augroup("terminal_settings", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
  desc = "Terminal settings",
})

-- =============================================================================
-- Go to last location when opening a buffer
-- =============================================================================

autocmd("BufReadPost", {
  group = augroup("last_location", { clear = true }),
  callback = function(event)
    local exclude = { "gitcommit", "commit", "gitrebase" }
    local buf = event.buf
    
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_location then
      return
    end
    
    vim.b[buf].last_location = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Go to last location when opening a buffer",
})

-- =============================================================================
-- Better experience for quickfix
-- =============================================================================

autocmd("FileType", {
  group = augroup("quickfix_settings", { clear = true }),
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.colorcolumn = ""
    
    -- Map q to close quickfix
    vim.keymap.set("n", "q", "<cmd>cclose<cr>", { 
      buffer = true, 
      silent = true,
      desc = "Close quickfix"
    })
    
    -- Map <CR> to open item and close quickfix
    vim.keymap.set("n", "<CR>", "<CR><cmd>cclose<cr>", { 
      buffer = true,
      silent = true,
      desc = "Open item and close quickfix"
    })
  end,
  desc = "Better quickfix experience",
})

-- =============================================================================
-- Auto-save when leaving insert mode or text changed
-- =============================================================================

-- Uncomment to enable auto-save
-- autocmd({ "InsertLeave", "TextChanged" }, {
--   group = augroup("auto_save", { clear = true }),
--   pattern = "*",
--   callback = function()
--     if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
--       vim.cmd("silent! write")
--     end
--   end,
--   desc = "Auto-save when leaving insert mode or text changed",
-- })

-- =============================================================================
-- Git
-- =============================================================================

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime", { clear = true }),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
  desc = "Check if file changed outside of vim",
})

-- =============================================================================
-- Dashboard
-- =============================================================================

-- Disable statusline, tabline etc in alpha dashboard
autocmd("User", {
  pattern = "AlphaReady",
  group = augroup("alpha_settings", { clear = true }),
  callback = function()
    vim.opt.showtabline = 0
    vim.opt.laststatus = 0
  end,
  desc = "Disable statusline and tabline in alpha",
})

autocmd("BufUnload", {
  group = augroup("alpha_settings", { clear = true }),
  buffer = 0,
  callback = function()
    vim.opt.showtabline = 2
    vim.opt.laststatus = 3
  end,
  desc = "Restore statusline and tabline after alpha",
})

vim.notify("Autocommands loaded successfully", vim.log.levels.INFO)
