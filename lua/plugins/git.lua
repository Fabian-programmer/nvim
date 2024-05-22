return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame_opts = { delay = 100 },
    },
    -- stylua: ignore
    keys = {
      { "gp", function() require("gitsigns").preview_hunk() end, desc = "Git hunk preview" },
      { "gq", function() require("gitsigns").reset_hunk() end,   desc = "Git hunk clear" },
      {
        "gü",
        function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            require("gitsigns").next_hunk()
          end)
          return "<Ignore>"
				end,
				desc = "Jump to next git hunk",
			},
			{
				"g+",
				function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						require("gitsigns").prev_hunk()
					end)
					return "<Ignore>"
				end,
				desc = "Jump to prev git hunk",
			},
		},
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>go", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
      { "<leader>gd", "<cmd>DiffviewFileHistory<cr>", desc = "DiffView Files" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffView Current File" },
    },
    opts = {
      enhanced_diff_hl = true,
      keymaps = {
        disable_defaults = false, -- Disable the default keymaps
        view = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close View" } },
        },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close View" } },
        },
        file_history_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close View" } },
        },
      },
    },
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    init = function()
      vim.g.lazygit_floating_window_scaling_factor = 1.0
    end,
  },
}
