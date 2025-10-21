return {
  -- Blink
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "giuxtaposition/blink-cmp-copilot" },
    },
    event = "InsertEnter",
    opts = {
      keymap = { preset = 'enter' },
      completion = { documentation = { auto_show = true } },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      { "copilotlsp-nvim/copilot-lsp" },
      { "AndreM222/copilot-lualine" },
    },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
}
