-- =============================================================================
-- Kanagawa — Vintage Japanese Ink Colorscheme
-- Loads immediately (priority 1000) since everything depends on it
-- =============================================================================
return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      compile = true,            -- Compile theme to bytecode for faster load
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,       -- Solid background for vintage feel
      dimInactive = false,
      terminalColors = true,
      theme = "wave",            -- wave = dark vintage, dragon = darker, lotus = light
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none", -- Clean gutter (no background)
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Telescope borderless style
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          -- Floating windows
          NormalFloat = { bg = theme.ui.bg_m1 },
          FloatBorder = { bg = theme.ui.bg_m1, fg = theme.ui.bg_m1 },
          FloatTitle = { bg = "none" },
          -- Completion menu
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
    })
    vim.cmd.colorscheme("kanagawa")
  end,
}
