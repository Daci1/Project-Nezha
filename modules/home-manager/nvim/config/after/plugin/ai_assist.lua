require('copilot').setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 300,
  }
})
require('avante_lib').load()
require('avante').setup({
  provider = "copilot",
  mode = "legacy",
})
