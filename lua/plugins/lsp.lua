-- =============================================================================
-- LSP — Mason + LSP Config for All Languages
-- Lazy-loaded: activates when a buffer is read/created
--
-- Supported: Python (FastAPI), Java, Node.js/TS, Flutter/Dart, SQL, Lua
-- =============================================================================
return {
  -- Mason: manages LSP/DAP/linter/formatter installations
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<CR>", desc = "Mason" } },
    opts = {
      ui = { border = "rounded" },
    },
  },

  -- Bridge between Mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    dependencies = { "williamboman/mason.nvim" },
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Enhanced capabilities with nvim-cmp
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Diagnostic display configuration
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 4,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = true,
        },
      })

      -- Keymaps applied when an LSP server attaches to a buffer
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gr", vim.lsp.buf.references, "Go to references")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "K", vim.lsp.buf.hover, "Hover documentation")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<leader>D", vim.lsp.buf.type_definition, "Type definition")
        map("n", "<leader>ds", vim.lsp.buf.document_symbol, "Document symbols")
        map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
        map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
      end

      -- Servers to auto-install and configure
      mason_lspconfig.setup({
        ensure_installed = {
          "pyright",       -- Python / FastAPI
          "jdtls",         -- Java
          "ts_ls",         -- TypeScript / Node.js
          "dartls",        -- Flutter / Dart
          "sqls",          -- SQL / PostgreSQL
          "lua_ls",        -- Lua (nvim config)
          "html",          -- HTML
          "cssls",         -- CSS
          "jsonls",        -- JSON
          "yamlls",        -- YAML
        },
        automatic_installation = true,
        handlers = {
          -- Default handler for most servers
          function(server_name)
            lspconfig[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,

          -- Lua: recognize vim global
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                  },
                  telemetry = { enable = false },
                },
              },
            })
          end,

          -- Python: configure for FastAPI projects
          ["pyright"] = function()
            lspconfig.pyright.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "basic",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "openFilesOnly",
                  },
                },
              },
            })
          end,

          -- Java: basic config (full jdtls handled separately if needed)
          ["jdtls"] = function()
            lspconfig.jdtls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,

          -- SQL: PostgreSQL connection
          ["sqls"] = function()
            lspconfig.sqls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                sqls = {
                  connections = {
                    {
                      driver = "postgresql",
                      dataSourceName = "host=127.0.0.1 port=5432 user=postgres dbname=postgres sslmode=disable",
                    },
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
