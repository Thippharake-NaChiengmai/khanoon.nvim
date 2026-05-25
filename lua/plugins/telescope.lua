-- =============================================================================
-- Telescope — Fuzzy Finder for Files, Grep, Buffers
-- Lazy-loaded: only loads when you press a find keymap or run :Telescope
-- =============================================================================
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
    { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
    { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
    { "<leader>fc", "<cmd>Telescope commands<CR>", desc = "Commands" },
    { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",  -- Requires make + gcc/clang. Falls back gracefully.
    },
  },
  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = {
        prompt_prefix = "  ",
        selection_caret = "▸ ",
        entry_prefix = "  ",

        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.5,
            width = 0.88,
            height = 0.80,
          },
        },
        sorting_strategy = "ascending",

        border = true,
        color_devicons = true,
        path_display = { "smart" },

        file_ignore_patterns = {
          "node_modules", ".git/", "%.lock", "__pycache__",
          "%.class", "%.jar", "target/", "build/",
          "%.jpg", "%.jpeg", "%.png", "%.gif", "%.pdf",
        },

        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<Esc>"] = actions.close,
          },
        },
      },

      pickers = {
        find_files = {
          hidden = true,
          no_ignore = false,
        },
        live_grep = {
          additional_args = { "--hidden" },
        },
        buffers = {
          sort_mru = true,
          ignore_current_buffer = true,
        },
      },

      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    -- Load fzf-native if compiled successfully
    pcall(require("telescope").load_extension, "fzf")
  end,
}
