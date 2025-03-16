local notify_info = require("config.utils").notify_info
local enabled = require("config.utils").enabled
local exist, custom_config = pcall(require, "custom.custom_config")
local group = exist and type(custom_config) == "table" and custom_config.enable_plugins or {}
local custom_plugins = exist and type(custom_config) == "table" and custom_config.plugins or {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "stevearc/aerial.nvim",
    cond = enabled(group, "aerial"),
    cmd = "AerialToggle",
  },
  {
    "goolord/alpha-nvim",
    cond = enabled(group, "alpha"),
    lazy = false,
  },
  {
    "akinsho/bufferline.nvim",
    cond = enabled(group, "bufferline"),
    lazy = false,
  },
  {
    "lewis6991/gitsigns.nvim",
    cond = enabled(group, "gitsigns"),
    event = "VimEnter",
    config = function()
      require("gitsigns").setup({
        on_attach = require("config.keybindings").gitsigns(),
      })
    end,
  },
  {
    "smoka7/hop.nvim",
    version = "*",
    cond = enabled(group, "hop"),
    event = "VimEnter",
  },
  {
    "HakonHarnes/img-clip.nvim",
    cond = enabled(group, "img_clip"),
    event = "BufEnter",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    cond = enabled(group, "indent_blankline"),
    event = "VimEnter",
  },
  {
    "neovim/nvim-lspconfig",
    cond = enabled("lsp"),
    event = "VimEnter",
  },
  {
    "williamboman/mason.nvim",
    cond = enabled("lsp"),
    event = "VimEnter",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cond = enabled("lsp"),
    event = "VimEnter",
  },
  {
    "folke/lazydev.nvim",
    cond = enabled(group, "lazydev"),
    event = "VeryLazy",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "karb94/neoscroll.nvim",
    cond = enabled(group, "neoscroll"),
    event = "VeryLazy",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cond = enabled(group, "neotree"),
    event = "VeryLazy",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- requires luarocks
    },
  },
  {
    "Shatur/neovim-session-manager",
    cond = enabled(group, "session_manager"),
    event = "VimEnter",
  },
  {
    "folke/noice.nvim",
    cond = enabled(group, "noice"),
    event = "VimEnter",
    dependencies = { { "MunifTanjim/nui.nvim" } },
  },
  {
    "nvimtools/none-ls.nvim",
    cond = enabled(group, "null_ls"),
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "jay-babu/mason-null-ls.nvim",
        cmd = { "NullLsInstall", "NullLsUninstall" },
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    cond = enabled(group, "autopairs"),
    event = "InsertEnter",
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   cond = enabled(group, "cmp"),
  --   event = "InsertEnter",
  --   dependencies = {
  --     { "onsails/lspkind.nvim" },
  --     { "hrsh7th/cmp-nvim-lsp" },
  --     { "hrsh7th/cmp-buffer" },
  --     { "hrsh7th/cmp-path" },
  --     { "saadparwaiz1/cmp_luasnip" },
  --     { "hrsh7th/cmp-nvim-lua" },
  --     { "L3MON4D3/LuaSnip" },
  --     { "rafamadriz/friendly-snippets" },
  --   },
  -- },
  {
    "saghen/blink.cmp",
    cond = enabled(group, "cmp"),
    event = "InsertEnter",
    -- optional: provides snippets for the snippet source
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "L3MON4D3/LuaSnip",            version = "v2.*" },
      { "echasnovski/mini.snippets" },
    },
    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',
  },
  { "NvChad/nvim-colorizer.lua", cond = enabled(group, "colorizer"), event = "VimEnter" },
  {
    "mfussenegger/nvim-dap",
    cond = enabled(group, "dap"),
    event = "VeryLazy",
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        cmd = { "DapInstall", "DapUninstall" },
      },
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("dapui").setup()
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
      },
      {
        "nvim-neotest/nvim-nio",
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    cond = enabled(group, "notify"),
    lazy = false,
    config = function()
      vim.notify = require("notify")
      _G.message = require("notify")
    end,
  },
  {
    "kylechui/nvim-surround",
    cond = enabled(group, "surround"),
    event = "VimEnter",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    cond = enabled(group, "treesitter"),
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      {
        "nvim-treesitter/nvim-treesitter-context",
        cond = enabled(group, "context"),
      },
      { "windwp/nvim-ts-autotag",                     cond = enabled(group, "autotag") },
      { "HiPhish/rainbow-delimiters.nvim",            cond = enabled(group, "rainbow") },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          require("ts_context_commentstring").setup({
            enable_autocmd = false,
          })
        end,
      },
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    cond = enabled(group, "ufo"),
    event = "VimEnter",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require("ufo").setup()
    end,
  },
  {
    "AstroNvim/astrotheme",
    cond = enabled(group, "astrotheme"),
    lazy = false,
  },
  { "nvim-lua/plenary.nvim" },
  {
    "ahmedkhalf/project.nvim",
    cond = enabled(group, "project"),
    event = "VimEnter",
  },
  {
    "tiagovla/scope.nvim",
    cond = enabled(group, "scope"),
    event = "VimEnter",
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cond = enabled(group, "telescope"),
    cmd = "Telescope",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    cond = enabled(group, "toggleterm"),
    event = "VeryLazy",
  },
  {
    "folke/trouble.nvim",
    cond = enabled(group, "trouble"),
    opts = {},
    cmd = { "Trouble" },
  },
  {
    "folke/twilight.nvim",
    cond = enabled(group, "twilight"),
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  },
  {
    "folke/which-key.nvim", -- opted for a mostly basic config straight from github readme
    cond = enabled(group, "whichkey"),
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "folke/zen-mode.nvim",
    cond = enabled(group, "zen"),
    cmd = "ZenMode",
  },
  custom_plugins,
}

require("lazy").setup(plugins, {
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = { "tohtml", "gzip", "zipPlugin", "tarPlugin" },
    },
  },
})
