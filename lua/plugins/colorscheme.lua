return {
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 999,
    opts = { style = "moon" },
    config = function()
      require("tokyonight").load()
    end,
  },
}
