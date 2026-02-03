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

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
-- fixes all breakpoints getting highlighted as rejected (might cause problems but for now whatever does the trick i guess)
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })

vim.keymap.set("n", "<leader>dt", dapView.toggle, { noremap = true })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dw", "<cmd>DapViewWatch<CR>", { desc = "Add variable to watch" })
vim.keymap.set("n", "<leader>?", function()
	dapui.eval(nil, { enter = true })
end)
vim.keymap.set("n", "<F1>", dap.continue)

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

for _, language in ipairs(js_based_languages) do
	dap.configurations[language] = dap.configurations[language] or {}

	-- Launch configuration
	table.insert(dap.configurations[language], {
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		console = "integratedTerminal",
		program = "${file}",
		cwd = "${workspaceFolder}",
		sourceMaps = true,
	})

	-- Attach configuration with dynamic process picker
	table.insert(dap.configurations[language], {
		type = "pwa-node",
		request = "attach",
		name = "Attach to process",
		processId = require("dap.utils").pick_process, -- pick running Node/TS process
		cwd = "${workspaceFolder}",
		sourceMaps = true,
	})

	table.insert(dap.configurations[language], {
		type = "pwa-node",
		request = "launch",
		name = "Launch via npm",
		runtimeExecutable = "npm",
		runtimeArgs = { "run", "dev" },
		cwd = "${workspaceFolder}",
		sourceMaps = true,
	})
end

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node", -- Node binary
		args = {
			os.getenv("NIX_NVIM_JS_DEBUG_PATH"),
			"${port}",
		},
	},
}
