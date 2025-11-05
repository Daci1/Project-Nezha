local dap = require("dap")
local dapui = require("dapui")
local dapView = require("dap-view")

dapView.setup({
  winbar = {
    controls = {
      enabled = true,
    },
  },
})

dapui.setup({
  expand_lines = true,
  floating = { border = "rounded" },
  render = {
    max_type_length = 0,
  },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 1.0 },
      },
      size = 15, 
      position = "bottom",
    },
  },
})

vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', numhl='DapBreakpoint' })
-- fixes all breakpoints getting highlighted as rejected (might cause problems but for now whatever does the trick i guess)
vim.fn.sign_define('DapBreakpointRejected', {text = '', texthl = 'DapBreakpoint', numhl='DapBreakpoint'})

vim.keymap.set("n", "<leader>dt", dapView.toggle, {noremap=true})
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dw', '<cmd>DapViewWatch<CR>', { desc = 'Add variable to watch' })
vim.keymap.set("n", "<leader>?", function() 
	dapui.eval(nil, { enter = true })
end)
vim.keymap.set("n", '<F1>', dap.continue)


dap.listeners.before.attach.dapui_config = function()
    dapView.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapView.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapView.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapView.close()
end

-- GO
require("dap-go").setup()

-- JS -- Still not working
local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "typescriptreact",
}

require("dap-vscode-js").setup({
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  debugger_path = "/etc/profiles/per-user/daci/bin/js-debug",
  debugger_cmd = { "js-debug" },
})

for _,language in ipairs(js_based_languages) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node",
    },
  }
end
