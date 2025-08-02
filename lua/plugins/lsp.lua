return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim",           cmd = "Mason",                       opts = {} },
      { "mason-org/mason-lspconfig.nvim", opts_extend = { "ensure_installed" } },
    },
    keys = {
      { "cd",         vim.diagnostic.open_float,                                                             desc = "Line Diagnostics" },
      { "<leader>ca", vim.lsp.buf.code_action,                                                               desc = "Code Action" },
      { "gK",         vim.lsp.buf.signature_help,                                                            desc = "Signature Help" },
      { "<c-k>",      vim.lsp.buf.signature_help,                                                            mode = "i",               desc = "Signature Help" },
      { "<leader>cr", vim.lsp.buf.rename,                                                                    desc = "Rename" },
      -- diagnostics
      { "üd",         vim.diagnostic.goto_prev,                                                              desc = "Prev Diagnostic" },
      { "+d",         vim.diagnostic.goto_next,                                                              desc = "Next Diagnostic" },
      { "üe",         function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Prev Error" },
      { "+e",         function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Next Error" },
      { "üw",         function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end,  desc = "Prev Warning" },
      { "+w",         function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end,  desc = "Next Warning" },
    },
    config = function()
      -- function to register keys for lsp.config
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          if client.config and client.config.keys then
            local Keys = require("lazy.core.handler.keys")
            local keymaps = client.config.keys

            for _, keys in pairs(keymaps) do
              local opts = Keys.opts(keys)
              opts.silent = opts.silent ~= false
              opts.buffer = args.buf

              local mode, lhs, rhs = table.unpack(keys)
              local desc = keys.desc

              vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { desc = desc }, opts))
            end
          end
        end
      })
    end,
  },
}
