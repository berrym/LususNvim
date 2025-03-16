local exist, custom_config = pcall(require, "custom.custom_config")
local group = exist and type(custom_config) == "table" and custom_config.enable_plugins or {}
local enabled = require("config.utils").enabled

if enabled(group, "telescope") then
  local telescope = require("telescope")
  if enabled(group, "scope") then
    telescope.load_extension("scope")
  end
  if enabled(group, "aerial") then
    telescope.load_extension("aerial")
  end
  if enabled(group, "notify") then
    telescope.load_extension("notify")
  end
  if enabled(group, "noice") then
    telescope.load_extension("noice")
  end
  if enabled(group, "projects") then
    telescope.load_extension("projects")
  end
end
