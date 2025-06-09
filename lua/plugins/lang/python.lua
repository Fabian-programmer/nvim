vim.lsp.enable('pyrefly')
return {
  -- external artefacts
  {
    "mason.nvim",
    opts = { ensure_installed = { "autopep8", "pyrefly" } },
  },

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
