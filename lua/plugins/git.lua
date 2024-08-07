return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame_opts = { delay = 100 },
    },
    -- stylua: ignore
      keys = {
        { "<leader>gW", function() require("gitsigns").blame_line{full=true} end, desc = "Git blame line" },
        { "<leader>gw", function() require("gitsigns").blame() end, desc = "Git blame" },
        { "gp", function() require("gitsigns").preview_hunk() end, desc = "Git hunk preview" },
        { "gq", function() require("gitsigns").reset_hunk() end,   desc = "Git hunk clear" },
        { "<leader>gd", function() require("gitsigns").toggle_deleted() end,   desc = "Git toggle deleted" },
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
      { "<leader>gf", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit Current File" },
    },
    init = function()
      vim.g.lazygit_floating_window_scaling_factor = 1.0
    end,
  },
}
