local M = {
  "akinsho/nvim-bufferline.lua",
  dependencies = { "tiagovla/scope.nvim", config = true },
  event = "VeryLazy",
}

function M.config()

  require("bufferline").setup({
    options = {
      always_show_bufferline = true,
      show_close_icon     = false,
      buffer_close_icon   = "",
      close_command       = "",
      right_mouse_command = "",
      show_tab_indicators = true,
      indicator           = {
        style = 'none',
      },
      offsets             = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          seperator = true,
        },
      },
    },
  })
end

return M
