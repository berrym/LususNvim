local exist, custom_config = pcall(require, "custom.custom_config")
local group = exist and type(custom_config) == "table" and custom_config.enable_plugins or {}
local enabled = require("config.utils").enabled

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  "██╗     ██╗   ██╗███████╗██╗   ██╗███████╗    ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
  "██║     ██║   ██║██╔════╝██║   ██║██╔════╝    ████╗  ██║██║   ██║██║████╗ ████║",
  "██║     ██║   ██║███████╗██║   ██║███████╗    ██╔██╗ ██║██║   ██║██║██╔████╔██║",
  "██║     ██║   ██║╚════██║██║   ██║╚════██║    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
  "███████╗╚██████╔╝███████║╚██████╔╝███████║    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
  "╚══════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
}

local buttons = {}

if enabled(group, "session") and enabled(group, "project") then
  buttons = {
    dashboard.button("e", "  > New file", ":lua require('config.utils').create_new_file()<CR>"),
    dashboard.button("f", "  > Find file in git repo", ":Telescope git_files <CR>"),
    dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("l", "🗘  > Open last session", ":SessionManager load_last_session<CR>"),
    dashboard.button("o", "  > Open session", ":SessionManager load_session<CR>"),
    dashboard.button("p", "  > Open project", ":Telescope projects<CR>"),
  }
end

if not enabled(group, "session") and enabled(group, "project") then
  buttons = {
    dashboard.button("e", "  > New file", ":lua require('config.utils').create_new_file()<CR>"),
    dashboard.button("f", "  > Find file in git repo", ":Telescope git_files <CR>"),
    dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
    -- dashboard.button("l", "🗘  > Open last session", ":SessionManager load_last_session<CR>"),
    -- dashboard.button("o", "  > Open session", ":SessionManager load_session<CR>"),
    dashboard.button("p", "  > Open project", ":Telescope projects<CR>"),
  }
end

if enabled(group, "session") and not enabled(group, "project") then
  buttons = {
    dashboard.button("e", "  > New file", ":lua require('config.utils').create_new_file()<CR>"),
    dashboard.button("f", "  > Find file in git repo", ":Telescope git_files <CR>"),
    dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("l", "🗘  > Open last session", ":SessionManager load_last_session<CR>"),
    dashboard.button("o", "  > Open session", ":SessionManager load_session<CR>"),
    -- dashboard.button("p", "  > Open project", ":Telescope projects<CR>"),
  }
end

if not enabled(group, "session") and not enabled(group, "project") then
  buttons = {
    dashboard.button("e", "  > New file", ":lua require('config.utils').create_new_file()<CR>"),
    dashboard.button("f", "  > Find file in git repo", ":Telescope git_files <CR>"),
    dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
    -- dashboard.button("l", "🗘  > Open last session", ":SessionManager load_last_session<CR>"),
    -- dashboard.button("o", "  > Open session", ":SessionManager load_session<CR>"),
    -- dashboard.button("p", "  > Open project", ":Telescope projects<CR>"),
  }
end

dashboard.section.buttons.val = buttons

local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

require("alpha").setup(dashboard.opts)
