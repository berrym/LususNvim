local vim_opts = require("config.utils").vim_opts
vim.opt.shortmess:append("sIW")

vim_opts({
  opt = {
    autochdir = false, -- deprecated, breaks with some plugins, config.autocommands handles this
    breakindent = true,
    breakindentopt = "shift:2,min:40,sbr",
    clipboard = "unnamedplus",
    colorcolumn = "100",
    confirm = true,
    cursorline = true,
    cursorlineopt = "number",
    expandtab = false,
    foldenable = true,
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
    foldlevel = 99,
    foldlevelstart = 99,
    foldopen = "jump,block,hor,mark,percent,quickfix,search,tag,undo",
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20",
    mouse = "a",
    hidden = true,
    hlsearch = true,
    ignorecase = true,
    incsearch = true,
    laststatus = 3,
    -- linebreak = true,
    number = true,
    numberwidth = 6,
    softtabstop = 8,
    shiftwidth = 8,
    relativenumber = true,
    scrolloff = 8,
    sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
    sidescrolloff = 8,
    -- showbreak = "=>>",
    showmode = false,
    signcolumn = "yes",
    smartcase = true,
    swapfile = false,
    tabstop = 8,
    textwidth = 100,
    termguicolors = true,
    undofile = true,
    wrap = false,
    writebackup = false,
  },
})

local exist, custom_config = pcall(require, "custom.custom_config")
local opts = exist and type(custom_config) == "table" and custom_config.options or {}
vim_opts(opts)
