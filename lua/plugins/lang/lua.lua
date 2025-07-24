return {
  -- language server
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "lua_ls" } },
  },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "lua" } },
  },
}
