local wk = require("which-key")

local M = {}

function M.setup(client, buffer)
  local cap = client.server_capabilities

  local keymap = {
    buffer = buffer,
    ["<leader>"] = {
      c = {
        name = "+code",
        a = {
          { vim.lsp.buf.code_action, "Code Action" },
          { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = "v" },
        },
        f = {
          {
            require("plugins.lsp.formatting").format,
            "Format Document",
            cond = cap.documentFormatting,
          },
          {
            require("plugins.lsp.formatting").format,
            "Format Range",
            cond = cap.documentRangeFormatting,
            mode = "v",
          },
        },
        d = { vim.diagnostic.open_float, "Line Diagnostics" },
      },
      x = {
        d = { "<cmd>Telescope diagnostics<cr>", "Search Diagnostics" },
      },
    },
    g = {
      name = "+goto",
      d = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition" },
      r = { "<cmd>Telescope lsp_references<cr>", "References" },
      R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
      D = { "<cmd>Telescope lsp_declarations<CR>", "Goto Declaration" },
      I = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
      t = { "<cmd>Telescope lsp_type_definitions<cr>", "Goto Type Definition" },
    },
    ["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help", mode = { "n", "i" } },
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    ["<F4>"] = { "<cmd>ClangdSwitchSourceHeader<CR>", "Toggle Header" },
  }

  wk.register(keymap)
end

return M
