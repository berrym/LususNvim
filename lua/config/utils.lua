local M = {}

-- sets main options from options (table)
M.vim_opts = function(options)
  if options ~= nil then
    for scope, table in pairs(options) do
      for setting, value in pairs(table) do
        vim[scope][setting] = value
      end
    end
  end
end

-- check if inside a working git repository
M.is_git_repo = function()
  local _ = vim.fn.system("git rev-parse --is-inside-work-tree")
  return vim.v.shell_error == 0
end

-- creating new file for alpha nvim buffer
M.create_new_file = function()
  local filename = vim.fn.input("Enter the filename: ")
  if filename ~= "" then
    vim.cmd("edit " .. filename)
  end
end

-- helper for cmp completion
M.has_words_before = function()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- creates floating terminal for toggleterm
M.create_floating_terminal = function(terminal, cmd)
  local instance = nil
  if vim.fn.executable(cmd) == 1 then
    instance = terminal:new({
      cmd = cmd,
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "rounded",
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          "n",
          "q",
          "<cmd>close<CR>",
          { noremap = true, silent = true }
        )
      end,
      on_close = function(_)
        vim.cmd("startinsert!")
      end,
    })
  end
  -- check if TermExec function exists
  return function()
    if vim.fn.executable(cmd) == 1 and instance ~= nil then
      instance:toggle()
    else
      M.notify_error("Command not found: " .. cmd .. ". Ensure it is installed.")
    end
  end
end

-- updates all Mason packages
M.update_mason = function()
  local registry = require("mason-registry")
  registry.refresh()
  registry.update()
  local packages = registry.get_all_packages()
  for _, pkg in ipairs(packages) do
    if pkg:is_installed() then
      pkg:install()
    end
  end
end

-- updates everything in LususNvim
M.update_all = function()
  M.notify_info("Pulling latest changes...")
  vim.fn.jobstart({ "git", "pull", "--rebase" })
  require("lazy").sync({ wait = true })
  M.notify_info("Updating Mason packages...")
  M.update_mason()
  -- make sure treesitter is loaded so it can update parsers
  require("nvim-treesitter")
  vim.cmd("TSUpdate")
  M.notify_info("LususNvim updated!")
end

-- check if attached lsp supports formatting
M.supports_formatting = function()
  local clients = vim.lsp.get_clients()
  for _, client in ipairs(clients) do
    if client.supports_method("textDocument/formatting") then
      return true
    end
  end
  return false
end

-- check if option to disable is active from specified group
M.enabled = function(group, opt)
  return group == nil or group[opt] == nil or group[opt] == true
end

M.notify_info = function(body, header)
  message.notify(body, "info", { title = header })
end

M.notify_warn = function(body, header)
  message.notify(body, "warn", { title = header })
end

M.notify_error = function(body, header)
  message.notify(body, "error", { title = header })
end

M.colors = function(scheme)
  vim.cmd.colorscheme(scheme)
end

return M
