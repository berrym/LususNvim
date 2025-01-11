local vim_opts = require("config.utils").vim_opts
vim.opt.shortmess:append("sIW")

vim_opts({
  opt = {
    confirm = true,
    number = true,
    relativenumber = true,
    tabstop = 8,
    softtabstop = 8,
    shiftwidth = 8,
    expandtab = false,
    hlsearch = false,
    incsearch = true,
    colorcolumn = "100",
    showmode = false,
    signcolumn = "yes",
    numberwidth = 6,
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20",
    cursorline = true,
    cursorlineopt = "number",
    linebreak = true,
    showbreak = "=>>",
    textwidth = 100,
    breakindent = true,
    breakindentopt = "shift:2,min:40,sbr",
    smartcase = true,
    ignorecase = true,
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
    foldlevel = 99,
    foldlevelstart = 99,
    foldopen = "jump,block,hor,mark,percent,quickfix,search,tag,undo",
    foldenable = true,
    clipboard = "unnamedplus",
    scrolloff = 5,
    autowrite = true,
    autochdir = true,
    termguicolors = true,
    undofile = true,
    sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
    hidden = true,
    laststatus = 3,
  },
})

local exist, custom_config = pcall(require, "custom.custom_config")
local opts = exist and type(custom_config) == "table" and custom_config.options or {}
vim_opts(opts)
