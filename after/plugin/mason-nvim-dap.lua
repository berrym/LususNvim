local exist, custom_config = pcall(require, "custom.custom_config")
local sources = exist
    and type(custom_config) == "table"
    and custom_config.mason_ensure_installed
    and custom_config.mason_ensure_installed.dap
  or {}

require("mason-nvim-dap").setup({
  ensure_installed = sources,
})
