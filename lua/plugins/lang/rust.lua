return {
  -- external artefacts
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "rust-analyzer" } },
  },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "ron", "rust", "toml" } },
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          enabled = true,
        },
      },
    },
  },
}
