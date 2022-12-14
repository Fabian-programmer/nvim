return {

  "nvim-lua/plenary.nvim",

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = { spelling = true },
        key_labels = { ["<leader>"] = "SPC" },
      })
      wk.register({
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>d"] = { name = "+debug" },
        ["<leader>f"] = { name = "+find" },
        ["<leader>h"] = { name = "+help" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunk" },
        ["<leader>t"] = { name = "+test" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      })
    end,
  },


  {
    "numToStr/Comment.nvim",
    keys = {
      { "<leader>/", function() require("Comment.api").toggle.linewise.current() end, desc = "Comment" },
      { "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "Comment",
        mode = "v" },
    },
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    keys = {
      { "<leader>fr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  -- diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble" },
    },
    config = {
      auto_open = false,
      use_diagnostic_signs = true,
    },
  },

  {
    "stevearc/dressing.nvim",
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- git stuff
  {
    --dir = "~/gitsigns.nvim",
    "Fabian-programmer/gitsigns.nvim",
    event = "BufReadPre",
    config = {
      current_line_blame_opts = { delay = 100 }
    },
    keys = {
      { "<leader>ghs", function() require("gitsigns").stage_hunk() end, desc = "Stage" },
      { "<leader>ghu", function() require("gitsigns").undo_stage_hunk() end, desc = "Undo" },
      { "<leader>ghp", function() require("gitsigns").preview_hunk() end, desc = "Preview" },
      { "<leader>ghr", function() require("gitsigns").reset_hunk() end, desc = "Reset" },
      { "<leader>ghn",
        function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            require("gitsigns").next_hunk()
          end)
          return "<Ignore>"
        end, desc = "Jump to next hunk" },
      { "<leader>ghN",
        function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            require("gitsigns").prev_hunk()
          end)
          return "<Ignore>"
        end, desc = "Jump to prev hunk" },
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
    config = true,
  },

  -- compiler explorer
  {
    -- dir = "~/compiler-explorer.nvim/",
    "Fabian-programmer/compiler-explorer.nvim",
    cmd = { "CECompile" },
    config = true,
  },
}
