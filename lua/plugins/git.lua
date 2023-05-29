return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame_opts = { delay = 100 },
    },
    keys = {
      {
        "<leader>ghs",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Stage",
      },
      {
        "<leader>ghu",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "Undo",
      },
      {
        "<leader>ghp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview",
      },
      {
        "<leader>ghr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset",
      },
      {
        "<leader>ghn",
        function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            require("gitsigns").next_hunk()
          end)
          return "<Ignore>"
        end,
        desc = "Jump to next hunk",
      },
      {
        "<leader>ghN",
        function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            require("gitsigns").prev_hunk()
          end)
          return "<Ignore>"
        end,
        desc = "Jump to prev hunk",
      },
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {

      { "<leader>go", "<cmd>DiffviewOpen<cr>",          desc = "DiffView Open" },
      { "<leader>gd", "<cmd>DiffviewFileHistory<cr>",   desc = "DiffView Files" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffView Current File" },
    },
    opts = {
      keymaps = {
        disable_defaults = false, -- Disable the default keymaps
        -- view = {
        --   { "n", "nx", require("diffview.actions").prev_conflict,
        --     { desc = "In the merge-tool: jump to the previous conflict" } },
        --   { "n", "Nx", require("diffview.actions").next_conflict,
        --     { desc = "In the merge-tool: jump to the next conflict" } },
        -- },
        -- file_panel = {
        --   { "n", "s", require("diffview.actions").toggle_stage_entry, { desc = "Stage / unstage the selected entry." } },
        --   { "n", "x", require("diffview.actions").restore_entry,
        --     { desc = "Restore entry to the state on the left side." } },
        -- },
      },
    },
  },

  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    init = function()
      local function commit_range()
        local first_commit_line = string.gsub(vim.fn.getline("v"), "*", "")
        local second_commit_line = string.gsub(vim.fn.getline("."), "*", "")

        local first_commit = vim.split(first_commit_line, "%s+")[2]
        local second_commit = vim.split(second_commit_line, "%s+")[2]

        local range = first_commit .. ".." .. second_commit

        return range
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "NeogitLogView",
        },
        callback = function(event)
          vim.keymap.set("v", "d", function()
            vim.api.nvim_command("DiffviewOpen " .. commit_range())
          end, { buffer = event.buf })
        end,
      })
    end,
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
