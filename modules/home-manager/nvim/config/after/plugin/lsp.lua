local cmp_nvim_lsp = require ("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false}
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gu", function() require('telescope.builtin').lsp_references({ initial_mode = 'normal'}) end, opts)
  vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("v", "ga", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "gr", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "gf", function() vim.lsp.buf.format() end, opts)
end

-- Go LSP
vim.lsp.config('gopls', {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = vim.fs.root(0, {"go.work", "go.mod", ".git"}),
  on_attach = on_attach,
  settings = {},
  capabilities = capabilities,
})

vim.lsp.enable('gopls')
