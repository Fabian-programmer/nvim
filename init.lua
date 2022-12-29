vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")

require("config.options")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.commands")
    require("config.mappings")
  end,
})

