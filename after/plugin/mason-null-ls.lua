local exist, custom_config = pcall(require, "custom.custom_config")
local sources = exist
    and type(custom_config) == "table"
    and custom_config.mason_ensure_installed
    and custom_config.mason_ensure_installed.null_ls
  or {}

require("mason-null-ls").setup({
  ensure_installed = sources,
})
