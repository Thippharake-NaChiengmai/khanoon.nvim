-- =============================================================================
-- Which-Key — Keybinding Hints Popup
-- Lazy-loaded: activates after startup (VeryLazy)
--
-- Press <leader> and wait — shows all available keybindings.
-- =============================================================================
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      preset = "modern",
      delay = 300,           -- Show popup after 300ms
      icons = {
        breadcrumb = "»",
        separator = "→",
        group = "+ ",
      },
    })

    -- Register group labels for leader key prefixes
    wk.add({
      { "<leader>f", group = "Find (Telescope)" },
      { "<leader>g", group = "Git" },
      { "<leader>d", group = "Debug (DAP)" },
      { "<leader>c", group = "Code" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>x", group = "Diagnostics" },
      { "<leader>s", group = "Search" },
    })
  end,
}
