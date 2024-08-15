return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 999,
    opts = { style = "moon" },
    config = function()
      require("tokyonight").load()
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false },
}
