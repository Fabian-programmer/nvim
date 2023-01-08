-- unit-tests
local M = {
  "nvim-neotest/neotest",
  keys = {
    { "<leader>tn", function() require("neotest").run().run() end, desc = "Nearest" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "File" },
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest" },
  },
  dependencies = {
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-vim-test",
    "vim-test/vim-test",
  },
}

function M.config()
  require("neotest").setup({
    adapters = {
      require("neotest-python"),
      require("neotest-vim-test")({ ignore_file_types = { "python" } }),
    },
  })
end

return M
