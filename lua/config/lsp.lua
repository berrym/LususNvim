require("mason").setup()

local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

lsp.set_sign_icons({
  error = "✘",
  warn = "▲",
  hint = "⚑",
  info = "»",
})

require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      local exist, custom_config = pcall(require, "custom.custom_config")
      local configs = exist and type(custom_config) == "table" and custom_config.lsp_configs or {}
      local config = type(configs) == "table" and configs[server_name] or {}
      require("lspconfig")[server_name].setup(config)
    end,
  },
})

lsp.setup()

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  preselect = "item",
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp_action.luasnip_supertab(),
    ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol", -- show only symbol annotations
      maxwidth = {
        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        -- can also be a function to dynamically calculate max width such as
        -- menu = function() return math.floor(0.45 * vim.o.columns) end,
        menu = 50, -- leading text (labelDetails)
        abbr = 50, -- actual suggestion item
      },
      ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(_, vim_item)
        -- ...
        return vim_item
      end,
    }),
  },
})
