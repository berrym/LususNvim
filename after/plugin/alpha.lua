local exist, custom_config = pcall(require, "custom.custom_config")
local group = exist and type(custom_config) == "table" and custom_config.enable_plugins or {}
local enabled = require("config.utils").enabled
local is_git_repo = require("config.utils").is_git_repo()
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

if is_git_repo and enabled(group, "session") and enabled(group, "project") then
  buttons = {
    dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
    dashboard.button("n", "  New file", ":lua require('config.utils').create_new_file()<CR>"),
    dashboard.button("s", "  New scratch file", ":ene!<CR>"),
    dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("t", "󱎸  Find text", ":Telescope live_grep<CR>"),
    dashboard.button("g", "󰊢  Find file in git repo", ":Telescope git_files<CR>"),
    dashboard.button("l", "🗘  Open last session", ":SessionManager load_last_session<CR>"),
    dashboard.button("o", "  Open session", ":SessionManager load_session<CR>"),
    dashboard.button("p", "  Open project", ":Telescope projects<CR>"),
    dashboard.button("q", "󰩈  Quit", ":qall<CR>"),
  }
end

if is_git_repo and enabled(group, "session") and not enabled(group, "project") then
  buttons = {
    dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
    dashboard.button("n", "  New file", ":lua require('config.utils').create_new_file()<CR>"),
    dashboard.button("s", "  New scratch file", ":ene!<CR>"),
    dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("t", "󱎸  Find text", ":Telescope live_grep<CR>"),
    dashboard.button("g", "󰊢  Find file in git repo", ":Telescope git_files<CR>"),
    dashboard.button("l", "🗘  Open last session", ":SessionManager load_last_session<CR>"),
    dashboard.button("o", "  Open session", ":SessionManager load_session<CR>"),
    -- dashboard.button("p", "  Open project", ":Telescope projects<CR>"),
    dashboard.button("q", "󰩈  Quit", "<CMD>qall<CR>"),
  }
end

if is_git_repo and not enabled(group, "session") and enabled(group, "project") then
  buttons = {
    dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
    dashboard.button("n", "  New file", ":lua require('config.utils').create_new_file()<CR>"),
    dashboard.button("s", "  New scratch file", ":ene!<CR>"),
    dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("t", "󱎸  Find text", ":Telescope live_grep<CR>"),
    dashboard.button("g", "󰊢  Find file in git repo", ":Telescope git_files<CR>"),
    -- dashboard.button("l", "🗘  Open last session", ":SessionManager load_last_session<CR>"),
    -- dashboard.button("o", "  Open session", ":SessionManager load_session<CR>"),
    dashboard.button("p", "  Open project", ":Telescope projects<CR>"),
    dashboard.button("q", "󰩈  Quit", "<CMD>qall<CR>"),
  }
end

if not is_git_repo and enabled(group, "session") and enabled(group, "project") then
  buttons = {
    dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
    dashboard.button("n", "  New file", ":lua require('config.utils').create_new_file()<CR>"),
    dashboard.button("s", "  New scratch file", ":ene!<CR>"),
    dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("t", "󱎸  Find text", ":Telescope live_grep<CR>"),
    -- dashboard.button("g", "  Find file in git repo", ":Telescope git_files<CR>"),
    dashboard.button("l", "🗘  Open last session", ":SessionManager load_last_session<CR>"),
    dashboard.button("o", "  Open session", ":SessionManager load_session<CR>"),
    dashboard.button("p", "  Open project", ":Telescope projects<CR>"),
    dashboard.button("q", "󰩈  Quit", "<CMD>qall<CR>"),
  }
end

if not is_git_repo and not enabled(group, "session") and enabled(group, "project") then
  buttons = {
    dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
    dashboard.button("n", "  New file", ":lua require('config.utils').create_new_file()<CR>"),
    dashboard.button("s", "  New scratch file", ":ene!<CR>"),
    dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("t", "󱎸  Find text", ":Telescope live_grep<CR>"),
    -- dashboard.button("g", "  Find file in git repo", ":Telescope git_files<CR>"),
    -- dashboard.button("l", "🗘  Open last session", ":SessionManager load_last_session<CR>"),
    -- dashboard.button("o", "  Open session", ":SessionManager load_session<CR>"),
    dashboard.button("p", "  Open project", ":Telescope projects<CR>"),
    dashboard.button("q", "󰩈  Quit", "<CMD>qall<CR>"),
  }
end

if not is_git_repo and enabled(group, "session") and not enabled(group, "project") then
  buttons = {
    dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
    dashboard.button("n", "  New file", ":lua require('config.utils').create_new_file()<CR>"),
    dashboard.button("s", "  New scratch file", ":ene!<CR>"),
    dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("t", "󱎸  Find text", ":Telescope live_grep<CR>"),
    -- dashboard.button("g", "  Find file in git repo", ":Telescope git_files<CR>"),
    dashboard.button("l", "🗘  Open last session", ":SessionManager load_last_session<CR>"),
    dashboard.button("o", "  Open session", ":SessionManager load_session<CR>"),
    -- dashboard.button("p", "  Open project", ":Telescope projects<CR>"),
    dashboard.button("q", "󰩈  Quit", "<CMD>qall<CR>"),
  }
end

if not is_git_repo and not enabled(group, "session") and not enabled(group, "project") then
  buttons = {
    dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
    dashboard.button("n", "  New file", ":lua require('config.utils').create_new_file()<CR>"),
    dashboard.button("s", "  New scratch file", ":ene!<CR>"),
    dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("t", "󱎸  Find text", ":Telescope live_grep<CR>"),
    -- dashboard.button("g", "  Find file in git repo", ":Telescope git_files<CR>"),
    -- dashboard.button("l", "🗘  Open last session", ":SessionManager load_last_session<CR>"),
    -- dashboard.button("o", "  Open session", ":SessionManager load_session<CR>"),
    -- dashboard.button("p", "  Open project", ":Telescope projects<CR>"),
    dashboard.button("q", "󰩈  Quit", "<CMD>qall<CR>"),
  }
end

dashboard.section.buttons.val = buttons

local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

require("alpha").setup(dashboard.opts)
