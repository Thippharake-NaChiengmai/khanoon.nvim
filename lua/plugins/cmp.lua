-- =============================================================================
-- nvim-cmp — Autocompletion with Snippets
-- Lazy-loaded: activates only when entering insert mode
-- =============================================================================
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",  -- Lazy: only loads when you start typing
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",       -- LSP completion source
    "hrsh7th/cmp-buffer",          -- Buffer words
    "hrsh7th/cmp-path",            -- File paths
    "L3MON4D3/LuaSnip",           -- Snippet engine
    "saadparwaiz1/cmp_luasnip",   -- Snippet completion source
    "rafamadriz/friendly-snippets", -- Pre-built snippet collection
    "onsails/lspkind.nvim",        -- VSCode-like icons
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Load VSCode-style snippets from friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder",
        }),
      },

      mapping = cmp.mapping.preset.insert({
        -- Scroll docs
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Trigger completion manually
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Abort completion
        ["<C-e>"] = cmp.mapping.abort(),

        -- Confirm selection
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        -- Smart Tab: cycle completion OR jump snippet placeholder
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      -- Completion sources (ordered by priority)
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
      }, {
        { name = "buffer", priority = 500, keyword_length = 3 },
        { name = "path", priority = 250 },
      }),

      -- VSCode-like icons in completion menu
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 40,
          ellipsis_char = "…",
          menu = {
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            buffer = "[Buf]",
            path = "[Path]",
          },
        }),
      },

      -- Performance tuning
      performance = {
        debounce = 60,
        throttle = 30,
        max_view_entries = 30,
      },
    })
  end,
}
