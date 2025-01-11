local exist, custom_config = pcall(require, "custom.custom_config")
local group = exist and type(custom_config) == "table" and custom_config.enable_plugins or {}
local enabled = require("config.utils").enabled
vim.g.mapleader = " " -- the leader key is the spacebar

local M = {}

-- Image Pasting
if enabled(group, "img_paste") then
  vim.keymap.set("n", "<leader>p", "<CMD>PasteImage<CR>", { desc = "Paste clipboard image" })
end

-- DAP
if enabled(group, "dap") then
  _G.dap = require("dap")
  vim.keymap.set("n", "<leader>dc", "<CMD>lua dap.continue()<CR>")
  vim.keymap.set("n", "<leader>dn", "<CMD>lua dap.step_over()<CR>")
  vim.keymap.set("n", "<leader>di", "<CMD>lua dap.step_into()<CR>")
  vim.keymap.set("n", "<leader>do", "<CMD>lua dap.step_out()<CR>")
  vim.keymap.set("n", "<leader>db", "<CMD>lua dap.toggle_breakpoint()<CR>")
  vim.keymap.set("n", "<leader>dq", "<CMD>lua dap.disconnect({ terminateDebuggee = true })<CR>")
end

-- Trouble
if enabled(group, "trouble") then
  vim.keymap.set(
    "n",
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle<cr>",
    { desc = "Diagnostics (Trouble)" }
  )
  vim.keymap.set(
    "n",
    "<leader>xX",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    { desc = "Buffer Diagnostics (Trouble)" }
  )
  vim.keymap.set(
    "n",
    "<leader>cs",
    "<cmd>Trouble symbols toggle focus=false<cr>",
    { desc = "Symbols (Trouble)" }
  )
  vim.keymap.set(
    "n",
    "<leader>cl",
    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    { desc = "LSP Definitions / references / ... (Trouble)" }
  )
  vim.keymap.set(
    "n",
    "<leader>xL",
    "<cmd>Trouble loclist toggle<cr>",
    { desc = "Location List (Trouble)" }
  )
  vim.keymap.set(
    "n",
    "<leader>xQ",
    "<cmd>Trouble qflist toggle<cr>",
    { desc = "Quickfix List (Trouble)" }
  )
end

-- UFO
if enabled(group, "ufo") then
  vim.keymap.set("n", "zR", "<CMD>lua require('ufo').openAllFolds()<CR>")
  vim.keymap.set("n", "zM", "<CMD>lua require('ufo').closeAllFolds()<CR>")
end

-- ZenMode
if enabled(group, "zen") then
  vim.keymap.set("n", "<leader>zm", "<CMD>ZenMode<CR>")
end

-- NeoTree
if enabled(group, "neotree") then
  vim.keymap.set("n", "<leader>nt", "<CMD>Neotree reveal left<CR>")
  vim.keymap.set("n", "<leader>nf", "<CMD>Neotree reveal float<CR>")
end

-- Aerial
if enabled(group, "aerial") then
  vim.keymap.set("n", "<leader>at", "<CMD>AerialToggle<CR>")
end

-- Searching and Highlighting
vim.keymap.set("n", "m", "<CMD>noh<CR>")

-- Movement
-- in insert mode, type <c-d> and your cursor will move past the next separator
-- such as quotes, parens, brackets, etc.
vim.keymap.set("i", "<C-d>", "<left><c-o>/[\"';)>}\\]]<cr><c-o><CMD>noh<cr><right>")
vim.keymap.set("i", "<C-b>", "<C-o>0")
vim.keymap.set("i", "<C-a>", "<C-o>A")

-- Window switching from terminal
vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l")

-- Command mode
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")

-- Telescope
if enabled(group, "telescope") then
  vim.keymap.set(
    "n",
    "<leader>ff",
    "<CMD>Telescope git_files hidden=true<CR>",
    { desc = "Telescope Find Files" }
  )
  vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep<CR>")
  vim.keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>")
  vim.keymap.set("n", "<leader>fh", "<CMD>Telescope help_tags<CR>")
  vim.keymap.set("n", "<leader>fa", "<CMD>Telescope aerial<CR>")
  vim.keymap.set("n", "<leader>fp", "<CMD>Telescope projects<CR>")
end

-- Move lines and blocks
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv")

-- Notify
if enabled(group, "notify") then
  vim.keymap.set("n", "<ESC>", "<CMD>lua require('notify').dismiss()<CR>")
  vim.keymap.set("i", "<ESC>", "<CMD>lua require('notify').dismiss()<CR><ESC>")
end

-- More LSP stuff
if enabled(group, "lsp_zero") then
  _G.buf = vim.lsp.buf
  -- lsp agnostic global rename
  vim.keymap.set("n", "rg", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "global substitution" })
  vim.keymap.set("n", "gD", "<CMD>lua buf.declaration()<CR>")
  vim.keymap.set("n", "gd", "<CMD>lua buf.definition()<CR>")
  vim.keymap.set("n", "gi", "<CMD>lua buf.implementation()<CR>")
  vim.keymap.set("n", "gr", "<CMD>Telescope lsp_references<CR>")
  vim.keymap.set("n", "sh", "<CMD>lua buf.signature_help()<CR>")
  vim.keymap.set("n", "<leader>rn", "<CMD>lua buf.rename()<CR>")
  vim.keymap.set("n", "<leader>ca", "<CMD>lua buf.code_action()<CR>")
  vim.keymap.set(
    "n",
    "<C-k>",
    "<CMD>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>"
  )
end

-- Session
if enabled(group, "session_manager") then
  vim.keymap.set("n", "<leader>ss", "<CMD>SessionManager save_current_session<CR>")
  vim.keymap.set("n", "<leader>o", "<CMD>SessionManager load_session<CR>")
end

-- ToggleTerm
if enabled(group, "toggleterm") then
  local git_root = "cd $(git rev-parse --show-toplevel 2>/dev/null) && clear"
  vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>")
  -- opens terminal as a new tab at the git root
  -- as a regular window
  vim.keymap.set(
    "n",
    "<C-\\>",
    "<CMD>ToggleTerm go_back=0 cmd='" .. git_root .. "'<CR>",
    { desc = "new terminal" }
  )
  vim.keymap.set(
    "n",
    "<leader>tk",
    "<CMD>TermExec go_back=0 direction=float cmd='" .. git_root .. "&& tokei'<CR>",
    { desc = "tokei" }
  )
  vim.keymap.set("n", "<leader>gg", "<CMD>lua term.lazygit_toggle()<CR>", { desc = "open lazygit" })
  vim.keymap.set("n", "<leader>gd", "<CMD>lua term.gdu_toggle()<CR>", { desc = "open gdu" })
  vim.keymap.set("n", "<leader>bt", "<CMD>lua term.bashtop_toggle()<CR>", { desc = "open bashtop" })
end

-- Hop
if enabled(group, "hop") then
  vim.keymap.set("n", "<leader>j", "<CMD>HopWord<CR>")
end

-- Gitsigns

-- making this a function here because all it does is create keybinds for gitsigns but
-- it needs to be attached to an on_attach function.
if enabled(group, "gitsigns") then
  M.gitsigns = function()
    local gs = package.loaded.gitsigns
    -- travel between hunks, backwards and forwards
    vim.keymap.set("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "go to previous git hunk" })
    vim.keymap.set("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "go to next git hunk" })

    vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "stage hunk" })
    vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "reset hunk" })
    vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "stage buffer" })
    vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
    vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "reset buffer" })
    vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "preview hunk" })
    vim.keymap.set("n", "<leader>hb", function()
      gs.blame_line({ full = true })
    end, { desc = "complete blame line history" })
    vim.keymap.set("n", "<leader>lb", gs.toggle_current_line_blame, { desc = "toggle blame line" })
    -- diff at current working directory
    vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "diff at cwd" })
    -- diff at root of git repository
    vim.keymap.set("n", "<leader>hD", function()
      gs.diffthis("~")
    end, { desc = "diff at root of git repo" })
    vim.keymap.set("n", "<leader>td", gs.toggle_deleted, { desc = "toggle deleted line" })
  end
end

-- cmp (these are defined in cmp's configuration file)
-- ["<C-j>"] = cmp.mapping.scroll_docs(-4),
-- ["<C-k"] = cmp.mapping.scroll_docs(4),
-- ["<C-c>"] = cmp.mapping.abort(),
-- ["<C-f>"] = cmp_action.luasnip_jump_forward(),
-- ["<C-b>"] = cmp_action.luasnip_jump_backward(),

return M
