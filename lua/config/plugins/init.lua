return {

  "nvim-lua/plenary.nvim",
  "folke/which-key.nvim",
  "numToStr/Comment.nvim",

  -- diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
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
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
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
