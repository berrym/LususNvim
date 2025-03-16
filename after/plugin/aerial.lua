local exist, custom_config = pcall(require, "custom.custom_config")
local group = exist and type(custom_config) == "table" and custom_config.enable_plugins or {}
local enabled = require("config.utils").enabled

if enabled(group, "aerial") then
  require("aerial").setup({
    highlight_on_hover = true,
    autojump = true,
    highlight_on_jump = false,
    manage_folds = true,
    show_guides = true,
  })
end
