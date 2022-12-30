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
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = true,
  },

  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" }
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = true,
  },

  -- compiler explorer
  {
    "Fabian-programmer/compiler-explorer.nvim",
    cmd = { "CECompile" },
    config = true,
  },

  -- unit-tests
  {
    "vim-test/vim-test",
    cmd = { "TestFile", "TestNearest", "TestSuite", "TestLast", "TestVisit" },
    config = { vim.cmd('let g:test#basic#start_normal = 1') },
  },
}
