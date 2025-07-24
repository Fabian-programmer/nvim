return {
  -- language server
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "rust_analyzer" } },
  },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "ron", "rust", "toml" } },
  },
}
