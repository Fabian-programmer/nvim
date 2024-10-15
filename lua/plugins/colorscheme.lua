return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    opts = { style = "moon" },
    config = function()
      require("tokyonight").load()
    end,
  },

  { "catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false },
}
