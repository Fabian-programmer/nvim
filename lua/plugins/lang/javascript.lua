return {
  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "javascript" },
    },
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "prettierd", "prettier" })
      end,
    },
    opts = {
      formatters_by_ft = {
        javascript = { { "prettierd", "prettier" } },
      },
    },
  },
}
