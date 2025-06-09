vim.lsp.enable('lua_ls')
return {
  -- external artefacts
  {
    "mason.nvim",
    opts = { ensure_installed = { "stylua" } },
  },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "lua" } },
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
}
