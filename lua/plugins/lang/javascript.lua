return {
  -- external artefacts
  {
    "mason.nvim",
    opts = { ensure_installed = { "prettierd", "prettier" } },
  },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "javascript" } },
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["javascript"] = { { "prettierd", "prettier" } },
        ["json"] = { "prettier" },
        ["markdown"] = { "prettier" },
      },
    },
  },
}
