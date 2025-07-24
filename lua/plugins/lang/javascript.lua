return {
  -- formatter
  -- {
  --   opts = { ensure_installed = { "prettierd", "prettier" } },
  -- },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "javascript", "json", "html", "markdown", "yaml" } },
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["html"] = { "prettier" },
        ["javascript"] = { "prettierd", "prettier" },
        ["json"] = { "prettier" },
        ["markdown"] = { "prettier" },
        ["yaml"] = { "prettier" },
      },
    },
  },
}
