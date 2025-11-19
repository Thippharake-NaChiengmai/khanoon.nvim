-- =============================================================================
-- Theme Configuration - Catppuccin Mocha
-- =============================================================================

local status_ok, catppuccin = pcall(require, 'catppuccin')
if not status_ok then
  vim.notify("Theme 'catppuccin' failed to load.", vim.log.levels.WARN)
  return
end

catppuccin.setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  transparent_background = false,
  show_end_of_buffer = false,
  term_colors = true,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false,
  no_bold = false,
  no_underline = false,
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {}, 
  },
  color_overrides = {},
  custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = true,
    noice = true,
    telescope = {
      enabled = true,
    },
    which_key = true,
    mason = true,
    dap = true,
    dap_ui = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
    },
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    alpha = true,
    dashboard = true,
    flash = true,
    lsp_saga = true,
    markdown = true,
    rainbow_delimiters = true,
  },
})

-- Available flavours: latte, frappe, macchiato, mocha
vim.cmd.colorscheme('catppuccin')
