return {
  -- language server
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "pyrefly" } },
  },

  -- formatter
  -- {
  --   opts = { ensure_installed = { "autopep8" } },
  -- },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "python" } },
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "autopep8" },
      },
    },
  },
}
