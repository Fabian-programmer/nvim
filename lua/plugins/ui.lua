return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = { enabled = true },
      scope = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      { "üü", function() Snacks.words.jump(-1) end, desc = "Previous LSP Word" },
      { "++", function() Snacks.words.jump(1) end,  desc = "Next LSP Word" },
    },
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "tiagovla/scope.nvim", config = true },
    opts = {
      options = {
        always_show_bufferline = true,
        show_close_icon = false,
        buffer_close_icon = "",
        close_command = "",
        right_mouse_command = "",
        show_tab_indicators = true,
        indicator = {
          style = "none",
        },
      },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local function clock()
        return " " .. os.date("%H:%M")
      end

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics"
            },
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = {
                left = 1,
                right = 0,
              },
            },
            {
              "filename",
              path = 1,
              symbols = { modified = "  ", readonly = "", unnamed = "" },
            },
            {},
          },
          lualine_x = {
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " "
              },
            },
          },
          lualine_y = { "location" },
          lualine_z = { clock },
        },
      }
    end,
  },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
}
