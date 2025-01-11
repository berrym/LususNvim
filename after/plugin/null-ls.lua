local null_ls = require("null-ls")

local exist, custom_config = pcall(require, "custom.custom_config")
local sources = exist
    and type(custom_config) == "table"
    and custom_config.setup_sources
    and custom_config.setup_sources(null_ls.builtins)
  or {}

null_ls.setup({
  sources = sources,
})
