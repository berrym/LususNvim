local exist, custom_config = pcall(require, "custom.custom_config")
local group = exist and type(custom_config) == "table" and custom_config.enable_plugins or {}
local parsers = exist
    and type(custom_config) == "table"
    and custom_config.treesitter_ensure_installed
    or {}
local enabled = require("config.utils").enabled
local autotag = enabled(group, "autopairs")
local rainbow = enabled(group, "rainbow")

if enabled(group, "treesitter") then
  require("nvim-treesitter.configs").setup({
    auto_install = true,
    ensure_installed = parsers,
    highlight = {
      enable = true,
    },
    incremental_selection = { enable = true },
    autotag = { enable = autotag },
    rainbow = { enable = rainbow, disable = { "html" }, extended_mode = false },
  })
end
