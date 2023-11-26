return {
  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      require("util").ensure_installed(opts, "cmake")
    end,
  },

  -- linter
  {
    "mfussenegger/nvim-lint",
    dependencies = {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        require("util").ensure_installed(opts, "cmakelint")
      end,
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      linters_by_ft = {
        cmake = { "cmakelint" },
      },
    },
  },

  -- lsp with formatting
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        neocmake = {},
      },
    },
  },
}
