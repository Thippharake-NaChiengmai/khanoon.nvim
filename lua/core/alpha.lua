-- =============================================================================
-- Alpha (Dashboard) Configuration
-- =============================================================================

local status_ok, alpha = pcall(require, 'alpha')
if not status_ok then
  vim.notify("Plugin 'alpha' failed to load.", vim.log.levels.WARN)
  return
end

local dashboard = require('alpha.themes.dashboard')

-- Set header
dashboard.section.header.val = {
  [[                                                    ]],
  [[                                                    ]],
  [[                                                    ]],
  [[  ██╗  ██╗██╗  ██╗ █████╗ ███╗   ██╗ ██████╗  ██████╗ ███╗   ██╗]],
  [[  ██║ ██╔╝██║  ██║██╔══██╗████╗  ██║██╔═══██╗██╔═══██╗████╗  ██║]],
  [[  █████╔╝ ███████║███████║██╔██╗ ██║██║   ██║██║   ██║██╔██╗ ██║]],
  [[  ██╔═██╗ ██╔══██║██╔══██║██║╚██╗██║██║   ██║██║   ██║██║╚██╗██║]],
  [[  ██║  ██╗██║  ██║██║  ██║██║ ╚████║╚██████╔╝╚██████╔╝██║ ╚████║]],
  [[  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝]],
  [[                                                    ]],
  [[  .nvim (v1.0.1)                                    ]],
  [[                                                    ]],
}

-- Set menu
dashboard.section.buttons.val = {
  dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
  dashboard.button("u", "  Update plugins", ":PackerSync<CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}
 
-- Add helpful hints below buttons
dashboard.section.buttons.opts.spacing = 0

-- Custom footer section for keybindings help
local keybindings_help = {
  type = "text",
  val = {
    "",
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
    "                         QUICK REFERENCE                            ",
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
    "",
    "  <Space> Leader | <leader>w Save | <leader>q Quit | <leader>x Close Buffer",
    "  <leader>e Explorer | <leader>f Find Files | <leader>g Grep Text",
    "",
    "  gd Definition | gr References | K Docs | <leader>rn Rename | <leader>ca Actions",
    "  gcc Comment | [d/]d Diagnostics | <C-h/j/k/l> Navigate Windows",
    "",
    "  NvimTree: a New | d Del | r Rename | x Cut | c Copy | p Paste | H Hidden",
    "  Git: <leader>gb Blame | <leader>gp Preview | ]c/[c Hunks",
    "",
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
    "  Press '?' in NvimTree for help  |  Type ':help' for documentation",
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
    "",
  },
  opts = {
    position = "center",
    hl = "Comment",
  },
}

-- Set footer
local function footer()
  -- Safely get plugin count
  local total_plugins = 0
  if packer_plugins then
    total_plugins = vim.tbl_count(packer_plugins)
  end
  
  local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
  local version = vim.version()
  local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

  return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
end

dashboard.section.footer.val = footer()

-- Layout
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.section.footer.opts.hl = "Type"

-- Configure layout with keybindings help
dashboard.config.layout = {
  { type = "padding", val = 2 },
  dashboard.section.header,
  { type = "padding", val = 2 },
  dashboard.section.buttons,
  { type = "padding", val = 1 },
  keybindings_help,
  { type = "padding", val = 1 },
  dashboard.section.footer,
}

dashboard.opts.opts.noautocmd = true

-- Setup
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
  autocmd FileType alpha setlocal nofoldenable
]])
