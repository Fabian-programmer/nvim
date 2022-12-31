-- unit-tests
local M = {
  "nvim-neotest/neotest",
  lazy = false,
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
