return {
  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "cmake" })
      end
    end,
  },

  -- linter
  {
    "mfussenegger/nvim-lint",
    dependencies = {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "cmakelint" })
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
