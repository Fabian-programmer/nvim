return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    -- stylua: ignore
    keys = {
      { "gp", function() require("gitsigns").preview_hunk() end, desc = "Git hunk preview" },
      { "gq", function() require("gitsigns").reset_hunk() end,   desc = "Git hunk clear" },
      { "<leader>gf", function() require("gitsigns").toggle_deleted() end,   desc = "toggle deleted" },
      { "gü", function() require("gitsigns").nav_hunk('next') end, desc = "Jump to next git hunk" },
      { "g+", function() require("gitsigns").nav_hunk('prev') end, desc = "Jump to prev git hunk" },
		},
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    init = function()
      vim.g.lazygit_floating_window_scaling_factor = 1.0
    end,
  },
}
