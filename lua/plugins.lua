return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- --- Core Plugins ---
  use 'nvim-lua/plenary.nvim' -- Dependency for other plugins
  use 'nvim-tree/nvim-web-devicons' -- Icons
  use 'DaikyXendo/nvim-material-icon'

  -- --- UI ---
  use { 'folke/tokyonight.nvim', as = 'tokyonight' }
  use { 'akinsho/bufferline.nvim', requires = 'nvim-tree/nvim-web-devicons' }
  use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons' } }
  use { 'goolord/alpha-nvim', requires = { 'nvim-tree/nvim-web-devicons' } }
  use {
    'nvim-tree/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    config = function()
      require('nvim-tree').setup({
        git = { enable = true, ignore = false },
        renderer = { icons = { show = { file = true, folder = true, folder_arrow = true, git = true } } },
        actions = { open_file = { quit_on_open = true } },
      })
    end
  }

  -- --- Functionality ---
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    keys = { '<leader>f', '<leader>g' },
    config = function()
      require('telescope').setup({}) -- Basic setup
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = "Find Files" })
      vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = "Live Grep" })
    end
  }
  use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup() end }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'lewis6991/gitsigns.nvim'

  -- --- LSP & Completion ---
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

end)
