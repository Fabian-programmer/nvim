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
    "NeogitOrg/neogit",
    cmd = "Neogit",
    opts = {
      disable_commit_confirmation = false,
      disable_insert_on_commit = false,
      disable_builtin_notifications = true,
      auto_show_console = false,
      remember_settings = false,
      signs = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },
      integrations = { diffview = true },
      commit_editor = {
        kind = "split",
      },
      rebase_editor = {
        kind = "split",
      },
    },
    keys = {
      {
        "<leader>gg",
        function()
          require("neogit").open({ cwd = require("util").get_root() })
        end,
        desc = "Neogit",
      },
      {
        "<leader>gl",
        function()
          require("neogit.popups.log").create()
          vim.cmd("normal l")
          vim.cmd(":wincmd p| wincmd T")
        end,
        desc = "Log current",
      },
      {
        "<leader>gL",
        function()
          require("neogit.popups.log").create()
          vim.cmd("normal b")
          vim.cmd(":wincmd p| wincmd T")
        end,
        desc = "Log",
      },
    },
  },
}
