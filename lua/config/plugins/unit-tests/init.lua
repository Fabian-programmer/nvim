
  -- unit-tests
  return {
    "vim-test/vim-test",
    cmd = { "TestFile", "TestNearest", "TestSuite", "TestLast", "TestVisit" },
    init = function ()
      vim.cmd('let g:test#strategy = "neovim"')
      vim.cmd('let g:test#neovim#start_normal = 1')
      vim.cmd('let g:test#preserve_screen = 1')
    end,
  }
