local exist, custom_config = pcall(require, "custom.custom_config")
local group = exist and type(custom_config) == "table" and custom_config.enable_plugins or {}
local enabled = require("config.utils").enabled

if enabled(group, "zen") then
  require("zen-mode").setup({
    plugins = {
      twilight = { enabled = true },
    },
  })
end
