vim.api.nvim_create_user_command("LususUpdate", function()
  require("config.utils").update_all()
end, { desc = "Updates plugins, mason packages, treesitter parsers" })

vim.api.nvim_create_user_command("AstroTransparencyOn", function()
  require("astrotheme").setup({
    style = { transparent = true },
  })
  require("config.utils").colors("astromars")
end, { desc = "Enable astrotheme transparency" })

vim.api.nvim_create_user_command("AstroTransparencyOff", function()
  require("astrotheme").setup({
    style = { transparent = false },
  })
  require("config.utils").colors("astromars")
end, { desc = "Disable astrotheme transparency" })
