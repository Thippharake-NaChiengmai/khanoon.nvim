-- =============================================================================
-- DAP (Debug Adapter Protocol) Configuration
-- =============================================================================

local dap_ok, dap = pcall(require, 'dap')
if not dap_ok then
  return
end

local dapui_ok, dapui = pcall(require, 'dapui')
if not dapui_ok then
  return
end

-- Auto open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Signs
vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', { text='🟡', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', { text='📝', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', { text='▶️', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', { text='❌', texthl='', linehl='', numhl=''})

-- Python configuration
dap.adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return 'python'
    end,
  },
}

-- Node.js / JavaScript / TypeScript
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {vim.fn.stdpath("data") .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
  {
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}

dap.configurations.typescript = dap.configurations.javascript

-- Chrome debugging
dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = {vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js"}
}

dap.configurations.html = {
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}"
  }
}

-- Keymaps
local keymap = vim.keymap.set
keymap('n', '<F5>', dap.continue, { desc = "DAP Continue" })
keymap('n', '<F10>', dap.step_over, { desc = "DAP Step Over" })
keymap('n', '<F11>', dap.step_into, { desc = "DAP Step Into" })
keymap('n', '<F12>', dap.step_out, { desc = "DAP Step Out" })
keymap('n', '<leader>dr', dap.repl.open, { desc = "DAP REPL" })
keymap('n', '<leader>dl', dap.run_last, { desc = "DAP Run Last" })
