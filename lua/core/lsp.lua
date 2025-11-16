-- =============================================================================
-- LSP & Completion Configuration
-- =============================================================================

-- --- Mason ---
local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
  vim.notify("Plugin 'mason' failed to load.", vim.log.levels.WARN)
  return
end
mason.setup()

-- --- Mason-LSPConfig ---
local mason_lsp_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lsp_ok then
  vim.notify("Plugin 'mason-lspconfig' failed to load.", vim.log.levels.WARN)
  return
end

local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
  vim.notify("Plugin 'lspconfig' failed to load.", vim.log.levels.WARN)
  return
end

local cmp_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_lsp_ok then
  vim.notify("Plugin 'cmp_nvim_lsp' failed to load.", vim.log.levels.WARN)
  return
end

local capabilities = cmp_nvim_lsp.default_capabilities()

local on_attach = function(client, bufnr)
  local bufmap = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
  end
  
  bufmap('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  bufmap('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  bufmap('n', 'gr', vim.lsp.buf.references, '[G]oto [R]eferences')
  bufmap('n', 'gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  bufmap('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
  bufmap('n', '<leader>r', vim.lsp.buf.rename, 'Rename')
  bufmap('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  bufmap('n', '<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  bufmap('n', '<leader>ds', vim.lsp.buf.document_symbol, '[D]ocument [S]ymbols')
  bufmap('n', '<leader>ws', vim.lsp.buf.workspace_symbol, '[W]orkspace [S]ymbols')
end

mason_lspconfig.setup({
  ensure_installed = {},
  automatic_installation = false,
  handlers = {
    function (server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities
      })
    end,
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = {'vim'}
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          }
        }
      })
    end,
  }
})

-- --- Completion (nvim-cmp) ---
local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  vim.notify("Plugin 'nvim-cmp' failed to load.", vim.log.levels.WARN)
  return
end

local luasnip_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_ok then
  vim.notify("Plugin 'luasnip' failed to load.", vim.log.levels.WARN)
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        luasnip = '[Snippet]',
        buffer = '[Buffer]',
        path = '[Path]',
      })[entry.source.name]
      return vim_item
    end
  },
})
