local cmp = require('cmp')

cmp.setup({
	preselect = 'item',
	completion = {
		completeopt = 'menu,menuone,noinsert'
	},
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({select = false}),
	}),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }),
})

cmp.setup.filetype({ "dap-repl", "dapui_watches" }, {
  sources = {
    { name = "dap" },
  }, 
}) 
