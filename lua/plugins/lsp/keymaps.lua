local M = {}

M._keys = nil

function M.get()
  if M._keys then
    return M._keys
  end
  -- stylua: ignore
  M._keys = {
    { "cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
    { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
    -- diagnostics
    { "üd", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
    { "+d", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
    { "üe", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Next Error" },
    { "+e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Prev Error" },
    { "üw", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end, desc = "Next Warning" },
    { "+w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end, desc = "Prev Warning" },
  }
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

return M
