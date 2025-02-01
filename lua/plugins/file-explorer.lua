return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = true,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          Snacks.explorer({ cwd = require("util").get_root() })
        end,
        desc = "File Explorer (root dir)",
      },
      {
        "<leader>E",
        function()
          Snacks.explorer()
        end,
        desc = "File Explorer (cwd)",
      },
    },
  },
}
