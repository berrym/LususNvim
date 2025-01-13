require("config.lazy")

for _, source in ipairs({
  "config.options",
  "config.keybindings",
  "config.utils",
  "config.autocommands",
}) do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end

local enabled = require("config.utils").enabled
local exist, custom_config = pcall(require, "custom.custom_config")
local group = exist and type(custom_config) == "table" and custom_config.enable_plugins or {}

if enabled(group, "notify") then
  vim.notify = require("notify")
end

vim.api.nvim_create_user_command("LususUpdate", function()
  require("config.utils").update_all()
end, { desc = "Updates plugins, mason packages, treesitter parsers" })

-- fix commentstrings to work with native nvim commenting
if enabled(group, "treesitter") then
  local goption = vim.filetype.get_option
  vim.filetype.get_option = function(filetype, option)
    return option == "commentstring"
        and require("ts_context_commentstring.internal").calculate_commentstring()
      or goption(filetype, option)
  end
end

pcall(require, "lsp-zero")

if exist and type(custom_config) == "table" and custom_config.custom_conf then
  custom_config.custom_conf()
end
