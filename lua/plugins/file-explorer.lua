return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = true,
        diagnostics = false,
      },
      picker = {
        sources = {
          explorer = { diagnostics = false, hidden = true, ignored = true },
        },
      },
    },
    keys = {
      { "<leader>e", function() Snacks.explorer({ cwd = require("util").get_root() }) end, desc = "File Explorer (root dir)" },
      { "<leader>E", function() Snacks.explorer() end,                                     desc = "File Explorer (cwd)" },
    },
  },

  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>.", function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
      { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    },
  },
}
