return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "moon" },
    config = function() require("tokyonight").load() end,
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = false },
}
