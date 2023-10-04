local M = {}

M._keys = nil

function M.get()
  if not M._keys then
    M._keys = {
      { "<leader>cd", vim.diagnostic.open_float,                 desc = "Line Diagnostics" },
      { "gd",         "<cmd>Telescope lsp_definitions<cr>",      desc = "Goto Definition",       has = "definition" },
      { "gr",         "<cmd>Telescope lsp_references<cr>",       desc = "References" },
      { "gD",         vim.lsp.buf.declaration,                   desc = "Goto Declaration" },
      { "gI",         "<cmd>Telescope lsp_implementations<cr>",  desc = "Goto Implementation" },
      { "gy",         "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto T[y]pe Definition" },
      { "K",          vim.lsp.buf.hover,                         desc = "Hover" },
      { "gK",         vim.lsp.buf.signature_help,                desc = "Signature Help",        has = "signatureHelp" },
      {
        "<c-k>",
        vim.lsp.buf.signature_help,
        mode = "i",
        desc = "Signature Help",
        has =
        "signatureHelp"
      },
      {
        "<leader>ca",
        vim.lsp.buf.code_action,
        desc = "Code Action",
        mode = { "n", "v" },
        has =
        "codeAction"
      },
      {
        "<F4>",
        "<cmd>ClangdSwitchSourceHeader<CR>",
        desc = "Toggle Header",
        mode = { "n", "v" },
        has =
        "codeAction"
      },
    }
    M._keys[#M._keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
  end
  return M._keys
end

function M.on_attach(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {}

  for _, value in ipairs(M.get()) do
    local keys = Keys.parse(value)
    if keys[2] == vim.NIL or keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keys in pairs(keymaps) do
    if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
    end
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return M
