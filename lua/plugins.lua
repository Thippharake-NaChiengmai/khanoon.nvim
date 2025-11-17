-- =============================================================================
-- Plugin Configuration with lazy.nvim
-- Optimized for performance with lazy loading
-- =============================================================================

require("lazy").setup({
  
  -- =========================================================================
  -- UI & Themes
  -- =========================================================================
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },
  
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "DaikyXendo/nvim-material-icon" },
    event = "VeryLazy",
  },
  
  {
    "akinsho/bufferline.nvim",
    dependencies = "DaikyXendo/nvim-material-icon",
    event = "VeryLazy",
  },
  
  {
    "goolord/alpha-nvim",
    dependencies = { "DaikyXendo/nvim-material-icon" },
    event = "VimEnter",
  },
  
  -- Command Palette / Quick Actions (like VS Code)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        preset = "modern",
        delay = 500,
      })
    end,
  },
  
  -- Floating Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    },
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<C-\>]],
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })
    end,
  },
  
  -- Notification UI
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      vim.notify = require("notify")
      require("notify").setup({
        background_colour = "#000000",
        fps = 60,
        render = "compact",
        timeout = 3000,
        top_down = true,
      })
    end,
  },
  
  -- Better UI for messages, cmdline and popups
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = true,
        },
      })
    end,
  },
  
  -- =========================================================================
  -- File Management
  -- =========================================================================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "DaikyXendo/nvim-material-icon" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
    },
    config = function()
      require('nvim-tree').setup({
        actions = { open_file = { quit_on_open = true } },
        view = { width = 35 },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
      })
    end,
  },
  
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git", "%.lock" },
          layout_config = {
            horizontal = { preview_width = 0.6 },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
          },
        },
      })
      pcall(require('telescope').load_extension, 'fzf')
    end,
  },
  
  -- =========================================================================
  -- Core Dependencies
  -- =========================================================================
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
  {
    "DaikyXendo/nvim-material-icon",
    lazy = false,
    priority = 1000,
  },
  
  -- =========================================================================
  -- Treesitter - Syntax Highlighting
  -- =========================================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "HiPhish/rainbow-delimiters.nvim",
    },
  },
  
  -- Rainbow brackets
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require('rainbow-delimiters.setup').setup({
        strategy = {
          [''] = require('rainbow-delimiters').strategy['global'],
        },
        query = {
          [''] = 'rainbow-delimiters',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      })
    end,
  },
  
  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = { enabled = false },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
      })
    end,
  },
  
  -- Colorizer (แสดงสีจริงของ hex colors)
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require('colorizer').setup({
        '*',
      }, {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
      })
    end,
  },
  
  -- =========================================================================
  -- LSP & Completion
  -- =========================================================================
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    config = function()
      require("mason").setup()
    end,
  },
  
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    lazy = true,
  },
  
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  
  -- Code Intelligence Enhancement
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        handler_opts = {
          border = "rounded"
        },
        floating_window = true,
        hint_enable = true,
      })
    end,
  },
  
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
  },
  
  -- Better LSP UI
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        ui = {
          border = "rounded",
          code_action = "💡",
        },
        lightbulb = {
          enable = true,
          sign = true,
          virtual_text = false,
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "DaikyXendo/nvim-material-icon",
    },
  },
  
  -- Conform (Auto-formatting)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
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
          lua = { "stylua" },
          python = { "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          go = { "gofmt" },
          rust = { "rustfmt" },
        },
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
      })
      
      -- Toggle format on save
      vim.api.nvim_create_user_command("FormatToggle", function(args)
        if args.bang then
          vim.b.disable_autoformat = not vim.b.disable_autoformat
        else
          vim.g.disable_autoformat = not vim.g.disable_autoformat
        end
      end, {
        desc = "Toggle autoformat-on-save",
        bang = true,
      })
    end,
  },
  
  -- =========================================================================
  -- Debugging (DAP)
  -- =========================================================================
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
      { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
      { "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step Into" },
      { "<leader>do", "<cmd>DapStepOver<cr>", desc = "Step Over" },
      { "<leader>dO", "<cmd>DapStepOut<cr>", desc = "Step Out" },
      { "<leader>dt", "<cmd>DapTerminate<cr>", desc = "Terminate" },
    },
  },
  
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle DAP UI" },
    },
    config = function()
      require("dapui").setup()
    end,
  },
  
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "python", "node2", "chrome" },
        automatic_installation = true,
      })
    end,
  },
  
  -- =========================================================================
  -- Git Integration
  -- =========================================================================
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },
  
  -- Advanced Git Workflow
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
    },
    config = function()
      require("neogit").setup({
        integrations = {
          diffview = true,
          telescope = true,
        },
      })
    end,
  },
  
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git Diff" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Git History" },
    },
  },
  
  -- Git Blame
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function()
      vim.g.gitblame_enabled = 0
    end,
  },
  
  -- =========================================================================
  -- Editing Support
  -- =========================================================================
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
    },
    config = function()
      require('Comment').setup()
    end,
  },
  
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  
  -- Auto save
  {
    "pocco81/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    config = function()
      require("auto-save").setup({
        enabled = false,
        trigger_events = {"InsertLeave", "TextChanged"},
      })
    end,
  },
  
  -- Multiple cursors
  {
    "mg979/vim-visual-multi",
    keys = {
      { "<C-n>", mode = {"n", "v"}, desc = "Multi cursor" },
    },
  },
  
  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  
  -- Flash (Better navigation)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
    config = function()
      require("flash").setup({
        labels = "asdfghjklqwertyuiopzxcvbnm",
        search = {
          multi_window = true,
          forward = true,
          wrap = true,
        },
        jump = {
          jumplist = true,
          pos = "start",
          history = false,
          register = false,
          nohlsearch = false,
        },
        label = {
          uppercase = true,
          rainbow = {
            enabled = true,
            shade = 5,
          },
        },
        modes = {
          char = {
            enabled = true,
            jump_labels = true,
          },
        },
      })
    end,
  },
  
  -- Harpoon (Quick file navigation)
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Harpoon Add File" },
      { "<leader>hh", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon Menu" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon File 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon File 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon File 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon File 4" },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },
  
  -- =========================================================================
  -- Code Actions & Refactoring
  -- =========================================================================
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>re", "<cmd>Refactor extract<cr>", mode = "x", desc = "Extract function" },
      { "<leader>rf", "<cmd>Refactor extract_to_file<cr>", mode = "x", desc = "Extract to file" },
    },
    config = function()
      require("refactoring").setup()
    end,
  },
  
  -- Todo Comments
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("todo-comments").setup()
    end,
  },
  
  -- Trouble - Better diagnostics
  {
    "folke/trouble.nvim",
    dependencies = { "DaikyXendo/nvim-material-icon" },
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
    },
  },
  
  -- Inline diagnostics
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup({
        preset = "modern",
        options = {
          show_source = true,
          throttle = 20,
          softwrap = 30,
          multiple_diag_under_cursor = true,
          multilines = true,
          show_all_diags_on_cursorline = false,
          enable_on_insert = false,
        },
      })
      -- Disable default virtual text
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
  
}, {
  -- =========================================================================
  -- lazy.nvim Configuration
  -- =========================================================================
  install = {
    colorscheme = { "tokyonight" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  rocks = {
    enabled = false,  -- ปิด luarocks (ไม่จำเป็นสำหรับ config นี้)
  },
  ui = {
    border = "rounded",
  },
})
