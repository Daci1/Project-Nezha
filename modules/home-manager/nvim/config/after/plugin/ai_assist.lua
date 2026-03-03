require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 500,
	},
})

vim.keymap.set("i", "<Tab>", function()
	local copilot = require("copilot.suggestion")
	if copilot.is_visible() then
		return copilot.accept()
	else
		return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
	end
end, { expr = true, noremap = true })

-- Dismiss copilot suggestions when typing
vim.api.nvim_create_autocmd("InsertCharPre", {
	callback = function()
		require("copilot.suggestion").dismiss()
	end,
})

require("snacks").setup({
	terminal = {
		enabled = true,
		auto_insert = false,
	},
})

vim.g.opencode_opts = {
	port = 4080,

	provider = {
		enabled = "snacks",
		terminal = {},
	},
}

vim.keymap.set("n", "<leader>ot", function()
	require("opencode").toggle()
end, { desc = "Toggle embedded" })

vim.keymap.set("n", "<leader>oa", function()
	require("opencode").ask()
end, { desc = "Ask opencode" })

vim.keymap.set("v", "<leader>oa", function()
	require("opencode").ask("@this: ")
end, { desc = "Ask opencode about selection" })

vim.keymap.set({ "n", "x" }, "<C-x>", function()
	require("opencode").select()
end, { desc = "Execute opencode action…" })

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		local pids = vim.fn.systemlist("lsof -ti:4080")

		for _, pid in ipairs(pids) do
			pid = tonumber(pid)
			if pid then
				-- try graceful kill
				vim.loop.kill(pid, vim.loop.constants.SIGTERM)

				-- force kill fallback
				vim.defer_fn(function()
					pcall(vim.loop.kill, pid, vim.loop.constants.SIGKILL)
				end, 500)
			end
		end
	end,
})
