return {
  -- external artefacts
  {
    "mason.nvim",
    opts = { ensure_installed = { "cmakelint", "neocmake" } },
  },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "cmake" } },
  },

  -- linter
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      linters_by_ft = {
        cmake = { "cmakelint" },
      },
    },
  },

  -- lsp with formatting. This has horribly many dependencies. Don't use it
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       neocmake = {},
  --     },
  --   },
  -- },
}
