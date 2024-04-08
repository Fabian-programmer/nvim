return {
  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      require("util").ensure_installed(opts, "javascript")
    end,
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
        ["javascript"] = { { "prettierd", "prettier" } },
        ["json"] = { "prettier" },
        ["markdown"] = { "prettier" },
      },
    },
  },
}
