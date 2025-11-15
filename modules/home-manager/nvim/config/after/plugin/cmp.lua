local cmp = require('cmp')

cmp.setup({
  enabled = true,
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

cmp.setup.filetype({ "dap-repl" }, {
  sources = {
    { name = "dap" },
  }, 
}) 

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline({
    ['<S-CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = false })
      else
        fallback() -- Fall back to normal <S-CR> behavior if cmp is not visible
      end
    end, { 'i', 'c' }), -- Ensure this works in both insert and cmdline modes
  }),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})

-- Send clear command to dap REPL if buffer is dap
local function smart_ctrl_l()
  local cmp_dap = require("cmp_dap")

  -- Only handle DAP buffers in insert mode
  if cmp_dap.is_dap_buffer() and vim.api.nvim_get_mode().mode == "i" then
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes(".clear<CR>", true, false, true),
      "i",
      false
    )
    return
  end

  -- In insert mode, fallback to literal <C-l> in non-DAP buffers
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<C-l>", true, false, true),
    "i",
    true
  )
end

-- Insert-mode mapping only
vim.keymap.set("i", "<C-l>", smart_ctrl_l, { silent = true })
