-- disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

require("config.lazy")

for _, source in ipairs({
  "config.options",
  "config.keybindings",
  "config.utils",
  "config.autocommands",
  "config.lsp",
}) do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end

vim.api.nvim_create_user_command("LususUpdate", function()
  require("config.utils").update_all()
end, { desc = "Updates plugins, mason packages, treesitter parsers" })

local exist, custom_config = pcall(require, "custom.custom_config")
if exist and type(custom_config) == "table" and custom_config.custom_conf then
  custom_config.custom_conf()
end
