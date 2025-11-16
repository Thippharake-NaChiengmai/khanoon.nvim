-- =============================================================================
-- Treesitter Configuration - Using Zig Compiler
-- =============================================================================

local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  vim.notify("Plugin 'nvim-treesitter' failed to load.", vim.log.levels.WARN)
  return
end

-- Use Zig as compiler (works best on Windows)
require('nvim-treesitter.install').compilers = { "zig" }

treesitter.setup({
  -- Auto-install works with Zig!
  auto_install = false,
  sync_install = false,
  
  -- Install all needed parsers
  ensure_installed = {
    "lua", "vim", "vimdoc", "query",
    "javascript", "typescript", "tsx",
    "python", "go", "php", "java",
    "html", "css", "json",
    "markdown", "markdown_inline"
  },
  
  highlight = {
    enable = true,
    
    -- Disable for large files
    disable = function(lang, buf)
      local max_filesize = 200 * 1024 -- 200 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    
    additional_vim_regex_highlighting = false,
  },
  
  indent = {
    enable = true,
    disable = { "python", "yaml" },
  },
  
  -- Incremental selection
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
})

