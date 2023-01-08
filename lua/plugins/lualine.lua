local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
}

local function clock()
  return " " .. os.date("%H:%M")
end

local function lsp()
  local msg = ''
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return " LSP: " .. client.name
    end
  end
  return msg
end

function M.config()
  if vim.g.started_by_firenvim then
    return
  end

  require("lualine").setup({
    options = {
      theme = "auto",
      section_separators = { left = " ", right = " " },
      component_separators = '',
      icons_enabled = true,
      globalstatus = true,
      disabled_filetypes = { statusline = { "dashboard", "lazy" } },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {
        { "diagnostics", sources = { "nvim_diagnostic" } },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
      },
      lualine_x = { lsp },
      lualine_y = { "location" },
      lualine_z = { clock },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    -- winbar = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = { "filename" },
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {},
    -- },
    --
    -- inactive_winbar = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = { "filename" },
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {},
    -- },
    extensions = { "nvim-tree" },
  })
end

return M
