local create_floating_terminal = require("config.utils").create_floating_terminal
local terminal = require("toggleterm.terminal").Terminal

local M = {}
M.lazygit_toggle = create_floating_terminal(terminal, "lazygit")
M.gdu_toggle = create_floating_terminal(terminal, "gdu")
M.btop_toggle = create_floating_terminal(terminal, "btop")
_G.terminal = M
