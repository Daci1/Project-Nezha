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

-- Json LSP
vim.lsp.config('jsonls', {
  cmd = { "vscode-json-languageserver", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_dir = vim.fs.root(0, { ".git" }),
  on_attach = on_attach,
  settings = {
    json = {
      validate = { enable = true },
      schemas = {},
    },
  },
  capabilities = capabilities,
})

-- TS/JS LSP
vim.lsp.config('ts-server', {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
root_dir = vim.fs.root(0, { "tsconfig.json", "package.json", ".git" }),
  on_attach = on_attach,
  settings = {},
  capabilities = capabilities,
})

-- Angular LSP
vim.lsp.config('angularls', {
  cmd = (function()
    -- Try to detect node_modules path for project-specific TypeScript/Angular
    local project_root = vim.fs.root(0, { "angular.json", "project.json", "tsconfig.json", "package.json", ".git" })
    local node_modules = project_root and (project_root .. "/node_modules") or vim.fn.getcwd()

    return {
      "ngserver",
      "--stdio",
      "--tsProbeLocations", node_modules,
      "--ngProbeLocations", node_modules,
    }
  end)(),

  filetypes = {
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "html",
  },

  root_dir = vim.fs.root(0, {
    "angular.json",
    "project.json",
    "tsconfig.json",
    "package.json",
    ".git",
  }),

  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    angular = {
      suggest = {
        includeAutomaticOptionalChainCompletions = true,
      },
      completion = {
        useSnippetCompletions = true,
      },
    },
  },
})

vim.lsp.enable({ 
  'gopls',
  'jsonls',
  'ts-server',
  'angularls',
})
