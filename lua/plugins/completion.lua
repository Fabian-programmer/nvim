-- auto completion
return {

  {
    "saghen/blink.cmp",
    version = "*",
    build = "cargo build --release",
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
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
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
        cmdline = {},
      },

      keymap = {
        preset = "enter",
        ["<C-y>"] = { "select_and_accept" },
      },
    },
  },
}
