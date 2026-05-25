-- =============================================================================
-- Conform — Auto-Formatting on Save
-- Lazy-loaded: runs on BufWritePre (before save) or manual keymap
-- =============================================================================
return {
  "stevearc/conform.nvim",
  event = "BufWritePre",  -- Lazy: loads just before saving
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        -- Python (FastAPI)
        python = { "black" },
        -- Java
        java = { "google-java-format" },
        -- Node.js / Web
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        -- Flutter / Dart
        dart = { "dart_format" },
        -- SQL
        sql = { "sql_formatter" },
        -- Web
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        -- Lua (nvim config)
        lua = { "stylua" },
      },

      -- Format on save with toggle support
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          timeout_ms = 1000,
          lsp_fallback = true,
        }
      end,
    })

    -- Toggle auto-format command
    vim.api.nvim_create_user_command("FormatToggle", function(args)
      if args.bang then
        vim.b.disable_autoformat = not vim.b.disable_autoformat
      else
        vim.g.disable_autoformat = not vim.g.disable_autoformat
      end
      vim.notify(
        "Auto-format: " .. (vim.g.disable_autoformat and "OFF" or "ON"),
        vim.log.levels.INFO
      )
    end, { desc = "Toggle auto-format on save", bang = true })
  end,
}
