return {
  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      require("util").ensure_installed(opts, "lua")
    end,
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "stylua" })
      end,
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
      },
    },
  },
}
