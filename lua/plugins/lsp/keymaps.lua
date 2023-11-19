local M = {}

M._keys = nil

function M.get()
  if M._keys then
    return M._keys
  end

  M._keys = {
    { "cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
    { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition", has = "definition" },
    { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
    { "gI", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
    { "gy", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto T[y]pe Definition" },
    { "K", vim.lsp.buf.hover, desc = "Hover" },
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "üd", M.diagnostic_goto(true), desc = "Next Diagnostic" },
    { "+d", M.diagnostic_goto(false), desc = "Prev Diagnostic" },
    { "üe", M.diagnostic_goto(true, "ERROR"), desc = "Next Error" },
    { "+e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
    { "üw", M.diagnostic_goto(true, "WARN"), desc = "Next Warning" },
    { "+w", M.diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
    {
      "<c-k>",
      vim.lsp.buf.signature_help,
      mode = "i",
      desc = "Signature Help",
      has = "signatureHelp",
    },
    {
      "<leader>ca",
      vim.lsp.buf.code_action,
      desc = "Code Action",
      mode = { "n", "v" },
      has = "codeAction",
    },
  }
  M._keys[#M._keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
  return M._keys
end

function M.has(buffer, method)
  method = method:find("/") and method or "textDocument/" .. method
  local clients = require("util").get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

function M.resolve(buffer)
  local Keys = require("lazy.core.handler.keys")
  if not Keys.resolve then
    return {}
  end
  local spec = M.get()
  local opts = require("util").opts("nvim-lspconfig")
  local clients = require("util").get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    if not keys.has or M.has(buffer, keys.has) then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
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
