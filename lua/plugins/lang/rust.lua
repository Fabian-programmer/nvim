vim.lsp.enable('rust_analyzer')
return {
  -- external artefacts
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "rust-analyzer" } },
  },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "ron", "rust", "toml" } },
  },
}
