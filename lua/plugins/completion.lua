-- auto completion
return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = "rafamadriz/friendly-snippets",
    event = "InsertEnter",
    opts = {
      keymap = { preset = 'enter' },
      completion = { documentation = { auto_show = true } },
    },
  },
}
