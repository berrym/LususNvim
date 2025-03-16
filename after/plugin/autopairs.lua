local exist, custom_config = pcall(require, "custom.custom_config")
local group = exist and type(custom_config) == "table" and custom_config.enable_plugins or {}
local enabled = require("config.utils").enabled

if enabled(group, "autopairs") then
  require("nvim-autopairs").setup({ map_c_w = true }) -- C-w will delete a pair
end
