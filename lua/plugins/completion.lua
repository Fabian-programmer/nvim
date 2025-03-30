-- auto completion
return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = "rafamadriz/friendly-snippets",
    event = "InsertEnter",

    opts = {
      -- disables autocomplete in rename ui input
      enabled = function()
        return not vim.tbl_contains({}, vim.bo.filetype)
            and vim.bo.buftype ~= "nofile"
            and vim.bo.buftype ~= "prompt"
            and vim.b.completion ~= false
      end,
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = true,
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      cmdline = {
        enabled = false
      },

      keymap = {
        preset = "enter",
        ["<C-y>"] = { "select_and_accept" },
      },
    },
    opts_extend = { "sources.default" },
  },
}
