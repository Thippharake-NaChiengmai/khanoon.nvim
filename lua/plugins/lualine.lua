-- =============================================================================
-- Lualine — Minimalist Status Line
-- Lazy-loaded: activates after startup (VeryLazy)
-- Shows only essential info: mode, branch, file, diagnostics, position
-- =============================================================================
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",  -- Lazy: not needed during startup
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",          -- Auto-detect from Kanagawa
        icons_enabled = true,
        component_separators = "",  -- No separators = clean minimal look
        section_separators = "",
        globalstatus = true,       -- Single statusline for all windows
        disabled_filetypes = {
          statusline = { "alpha", "lazy", "NvimTree", "toggleterm" },
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              -- Single character mode indicator (minimalist)
              local mode_map = {
                NORMAL = "N", INSERT = "I", VISUAL = "V",
                ["V-LINE"] = "VL", ["V-BLOCK"] = "VB",
                COMMAND = "C", REPLACE = "R", SELECT = "S",
                TERMINAL = "T",
              }
              return mode_map[str] or str:sub(1, 1)
            end,
          },
        },
        lualine_b = {
          { "branch", icon = "" },
        },
        lualine_c = {
          {
            "filename",
            path = 1,              -- Relative path
            symbols = {
              modified = " ●",    -- Modified indicator
              readonly = " ",    -- Readonly indicator
              unnamed = "[No Name]",
            },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = {
              error = "✘ ",
              warn = "▲ ",
              info = "» ",
              hint = "⚑ ",
            },
          },
        },
        lualine_y = {
          "filetype",
        },
        lualine_z = {
          { "location", padding = { left = 1, right = 1 } },
          "progress",
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
