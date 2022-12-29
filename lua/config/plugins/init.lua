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
    config = { vim.cmd('let g:test#basic#start_normal = 1') },
  },
}
