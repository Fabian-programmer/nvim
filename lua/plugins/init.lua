return {
  {
    "willothy/flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001,
  },

  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      bigfile = {},
      indent = {},
      input = {},
      notifier = {},
      picker = {},
      scope = {},
      words = {},
    },
    keys = {
      { "üü", function() Snacks.words.jump(-1) end, desc = "Previous LSP Word" },
      { "++", function() Snacks.words.jump(1) end,  desc = "Next LSP Word" },
    },
  },

  -- framework to run tasks
  {
    "stevearc/overseer.nvim",
    keys = {
      { "<leader>oo", "<cmd>OverseerOpen<cr>", desc = "Open Overseer" },
    },
    opts = {
      task_list = {
        min_height = 25,
      },
    },
  },

  -- run cli commands in float window
  {
    "akinsho/toggleterm.nvim",
    version = "*",
  },

}
