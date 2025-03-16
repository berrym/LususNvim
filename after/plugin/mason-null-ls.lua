local exist, custom_config = pcall(require, "custom.custom_config")
local group = exist and type(custom_config) == "table" and custom_config.enable_plugins or {}
local sources = exist
    and type(custom_config) == "table"
    and custom_config.mason_ensure_installed
    and custom_config.mason_ensure_installed.null_ls
    or {}
local enabled = require("config.utils").enabled

if enabled(group, "lsp") then
  require("mason-null-ls").setup({
    automatic_installation = true,
    ensure_installed = sources,
  })
end
