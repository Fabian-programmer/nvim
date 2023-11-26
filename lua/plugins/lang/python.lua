return {
  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      require("util").ensure_installed(opts, "python")
    end,
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
      },
    },
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "autopep8" })
      end,
    },
    opts = {
      formatters_by_ft = {
        python = { "autopep8" },
      },
    },
  },

  -- debugger
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "debugpy" })
      end,
      "mfussenegger/nvim-dap-python",
    -- stylua: ignore
      keys = {
        { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method" },
        { "<leader>dPc", function() require('dap-python').test_class() end,  desc = "Debug Class" },
      },
      config = function()
        require("dap-python").setup("~/.virtualenvs/avp-analyzer")
      end,
    },
  },
}
