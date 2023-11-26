return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    -- stylua: ignore
    { "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "Format" },
    {
      "<leader>ct",
      function()
        local Util = require("lazy.core.util")
        vim.g.autoformat = not vim.g.autoformat
        if vim.g.autoformat then
          Util.info("Enabled format on save", { title = "Format" })
        else
          Util.warn("Disabled format on save", { title = "Format" })
        end
      end,
      desc = "Toggle format on save",
    },
  },
  opts = {
    formatters_by_ft = {},
    format_on_save = function()
      if vim.g.autoformat then
        return { timeout_ms = 500, lsp_fallback = true }
      end
    end,
  },
}
