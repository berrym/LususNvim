local exist, custom_config = pcall(require, "custom.custom_config")
local group = exist and type(custom_config) == "table" and custom_config.enable_plugins or {}
local enabled = require("config.utils").enabled

if enabled(group, "astrotheme") then
  local colors = require("config.utils").colors
  colors("astromars")
end
