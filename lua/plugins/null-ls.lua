local M = {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  opts = function()
    local nls = require("null-ls")
    return {
      root_dir = require("null-ls.utils").root_pattern(".git"),
      sources = {
        nls.builtins.formatting.prettierd.with({ filetypes = { "markdown" } }),
        nls.builtins.formatting.black,
        nls.builtins.formatting.clang_format,
        nls.builtins.formatting.cmake_format,
      },
    }
  end,
}

function M.has_formatter(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
