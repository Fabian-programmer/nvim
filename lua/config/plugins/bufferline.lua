local M = {
  "akinsho/nvim-bufferline.lua",
  dependencies = {"tiagovla/scope.nvim", config = true},
  event = "BufAdd",
}

function M.config()

  require("bufferline").setup({
    options = {
      show_close_icon = true,
      always_show_bufferline = true,
      offsets = {
        {
          filetype = "NvimTree",
          text = "NvimTree",
          highlight = "Directory",
          text_align = "center",
        },
      },
      show_tab_indicators = true,
    },
  })
end
return M
