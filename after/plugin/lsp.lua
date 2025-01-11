local lsp = require("lsp-zero")
lsp.preset("minimal")

lsp.set_sign_icons({
  error = "✘",
  warn = "▲",
  hint = "⚑",
  info = "»",
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
local exist, custom_config = pcall(require, "custom.custom_config")
lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = custom_config.formatting_servers,
})

require("mason").setup({})
require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("lspconfig")[server_name].setup({
        capabilities = capabilities
      })
    end,
  },
})

require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      local configs = exist and type(custom_config) == "table" and custom_config.lsp_configs or {}
      local config = type(configs) == "table" and configs[server_name] or {}
      require("lspconfig")[server_name].setup(config)
    end,
  },
})
lsp.setup()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = {buffer = bufnr, remap = false}
    vim.keymap.set("n","gd",function() vim.lsp.buf.definition() end, opts) --go to definition
    vim.keymap.set('n','K',function() vim.lsp.buf.hover() end, opts) -- hover
    vim.keymap.set('n','<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts) --view workspace
    vim.keymap.set('n','<leader>vd', function() vim.diagnostic.open_foat() end, opts) --view diagnostic
    vim.keymap.set('n','[d',function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n',']d',function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n','<leader>vca', function() vim.lsp.buf.code_action() end, opts) --view code action
    vim.keymap.set('n','<leader>vrn', function() vim.lsp.buf.rename() end, opts) --rename variables
    vim.keymap.set('n','<leader>vrr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n','<leader>h', function() vim.lsp.buf.signature_help() end, opts)
  end
})
