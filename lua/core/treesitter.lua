-- =============================================================================
-- Treesitter Configuration - Using Zig Compiler
-- =============================================================================

local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

-- Use Zig as compiler (works best on Windows)
local install = require('nvim-treesitter.install')
install.prefer_git = false
install.compilers = { "zig", "clang", "gcc" }

treesitter.setup({
  -- Install parsers manually to avoid auto-install errors
  auto_install = false,
  sync_install = false,
  
  -- Only stable parsers
  ensure_installed = {
    "lua",
    "vim",
    "query",
    "markdown",
    "markdown_inline",
    "python",
    "javascript",
    "typescript",
    "html",
    "css",
    "json",
  },
  
  -- Ignore problematic parsers
  ignore_install = { "vimdoc" },
  
  highlight = {
    enable = true,
    
    -- Disable for specific filetypes
    disable = function(lang, buf)
      -- Disable for vimdoc/help files
      if lang == "vimdoc" or lang == "help" then
        return true
      end
      
      -- Disable for large files
      local max_filesize = 200 * 1024 -- 200 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
      
      return false
    end,
    
    -- Use additional vim regex for help files
    additional_vim_regex_highlighting = { "vim", "help" },
  },
  
  indent = {
    enable = true,
    disable = { "python", "yaml" },
  },
  
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  
  -- Textobjects
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
})

