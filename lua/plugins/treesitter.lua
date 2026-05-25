-- =============================================================================
-- Treesitter — Advanced Syntax Highlighting & Textobjects
-- Lazy-loaded: only activates when a buffer is opened
-- =============================================================================
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },  -- Lazy: loads on first file open
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      -- Use Zig compiler on Windows (more reliable than gcc/clang)
      local install = require("nvim-treesitter.install")
      install.prefer_git = false
      install.compilers = { "zig", "clang", "gcc" }

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- Languages you work with
          "python", "java", "javascript", "typescript",
          "dart", "sql",
          -- Web
          "html", "css", "json", "yaml", "toml",
          -- Config & docs
          "lua", "vim", "vimdoc", "markdown", "markdown_inline",
          -- DevOps
          "bash", "dockerfile", "regex",
        },
        auto_install = false,
        sync_install = false,

        highlight = {
          enable = true,
          -- Disable for very large files
          disable = function(_, buf)
            local max_filesize = 200 * 1024 -- 200 KB
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true,
          disable = { "python", "yaml" },  -- These have better indent rules natively
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",    -- Start selection
            node_incremental = "<C-space>",  -- Expand to parent node
            scope_incremental = false,
            node_decremental = "<bs>",       -- Shrink selection
          },
        },

        -- Textobjects: select/move by function, class, etc.
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
          },
        },
      })
    end,
  },
}
