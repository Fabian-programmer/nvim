vim.api.nvim_command('autocmd TermOpen,TermEnter term://* startinsert')

-- Close buffer
local universal_closer = "<A-q>"
vim.keymap.set("n", universal_closer, "<cmd>:Bclose<cr>")

-- bang the terminal
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(event)
    vim.keymap.set({ "n", "t" }, universal_closer, "<cmd>Bclose!<cr>", { buffer = event.buf, silent = true })
  end,
})

-- restore buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})


-- hide buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "asm",
    "fugitive*",
    "help",
    "man",
    "notify",
    "qf",
    "Trouble*",
    "Neogit*",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", universal_closer, "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "Diffview*" },
  callback = function(event)
    vim.keymap.set("n", universal_closer, "<cmd>DiffviewClose<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "NvimTree" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", universal_closer, "<cmd>NvimTreeClose<cr>", { buffer = event.buf, silent = true })
  end,
})
