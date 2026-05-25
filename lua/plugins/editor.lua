-- =============================================================================
-- Editor Plugins — Small, Focused Editing Enhancements
-- Each plugin is individually lazy-loaded
-- =============================================================================
return {
  -- Comment.nvim: Toggle comments with gcc / gc
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Toggle line comment" },
      { "gc", mode = { "n", "o" }, desc = "Toggle comment (motion)" },
      { "gc", mode = "x", desc = "Toggle comment (visual)" },
      { "gbc", mode = "n", desc = "Toggle block comment" },
    },
    config = function()
      require("Comment").setup()
    end,
  },

  -- Autopairs: auto-close brackets, quotes, etc.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",  -- Lazy: only when typing
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        check_ts = true,          -- Use treesitter for smart pairing
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
        },
      })

      -- Integrate with nvim-cmp (auto-add closing pair on confirm)
      local cmp_ok, cmp = pcall(require, "cmp")
      if cmp_ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },

  -- Surround: add/change/delete surrounding pairs (ys, cs, ds)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Flash: lightning-fast navigation with labels
  {
    "folke/flash.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Flash remote" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Flash treesitter search" },
    },
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = { multi_window = true },
      label = {
        uppercase = true,
        rainbow = { enabled = true, shade = 5 },
      },
      modes = {
        char = { enabled = true, jump_labels = true },
      },
    },
  },

  -- Indent guides: subtle vertical lines showing indentation
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },  -- Lazy: loads on file open
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = { enabled = false },  -- No scope highlighting (cleaner)
        exclude = {
          filetypes = {
            "help", "alpha", "dashboard", "NvimTree",
            "Trouble", "lazy", "mason", "notify", "toggleterm",
          },
        },
      })
    end,
  },

  -- Todo Comments: highlight TODO, FIXME, etc.
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("todo-comments").setup()
    end,
  },
}
