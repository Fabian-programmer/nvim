return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame_opts = { delay = 100 },
    },
    keys = {
      { "<leader>gW", function() require("gitsigns").blame_line { full = true } end, desc = "Git blame line" },
      { "<leader>gw", function() require("gitsigns").blame() end,                    desc = "Git blame" },
      { "gp",         function() require("gitsigns").preview_hunk() end,             desc = "Git hunk preview" },
      { "gq",         function() require("gitsigns").reset_hunk() end,               desc = "Git hunk clear" },
      { "<leader>gd", function() require("gitsigns").toggle_deleted() end,           desc = "Git toggle deleted" },
      { "üg",         function() require("gitsigns").nav_hunk('prev') end,           desc = "Jump to prev git hunk" },
      { "+g",         function() require("gitsigns").nav_hunk('next') end,           desc = "Jump to next git hunk" },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<leader>gg", function() require("util").create_fullscreen_terminal("lazygit") end, desc = "Lazy Git" },
    },
  },
}
