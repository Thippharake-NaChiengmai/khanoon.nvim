-- =============================================================================
-- Nvim-Tree — Minimal File Explorer
-- Lazy-loaded: only activates on toggle keymap or :NvimTree commands
-- =============================================================================
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
    { "<leader>E", "<cmd>NvimTreeFindFile<CR>", desc = "Find file in explorer" },
  },
  config = function()
    require("nvim-tree").setup({
      filters = {
        dotfiles = false,
        git_ignored = true,
      },
      actions = {
        open_file = {
          quit_on_open = true,  -- Close tree when opening a file
        },
      },
      view = {
        width = 30,
        side = "left",
        signcolumn = "no",
      },
      renderer = {
        group_empty = true,     -- Collapse empty folders
        indent_markers = {
          enable = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            none = " ",
          },
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = false,         -- No git icons (cleaner look)
          },
          glyphs = {
            folder = {
              arrow_closed = "▸",
              arrow_open = "▾",
            },
          },
        },
      },
      git = {
        enable = true,
        ignore = true,
      },
      diagnostics = {
        enable = false,          -- Keep it minimal
      },
      update_focused_file = {
        enable = true,
        update_root = false,
      },
    })
  end,
}
