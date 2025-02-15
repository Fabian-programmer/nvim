return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>e", function() Snacks.explorer({ cwd = require("util").get_root(), diagnostics = false }) end, desc = "File Explorer (root dir)" },
      { "<leader>E", function() Snacks.explorer({ diagnostics = false }) end, desc = "File Explorer (cwd)" },
    },
  },

  {
    "folke/snacks.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    },
  },
}
