return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  -- stylua: ignore
  keys = {
    { "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "Format" },
    {
      "<leader>ct",
      function()
        vim.g.autoformat = not vim.g.autoformat
        if vim.g.autoformat then
          Snacks.notify.info("Enabled format on save", { title = "Format" })
        else
          Snacks.notify.warn("Disabled format on save", { title = "Format" })
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
