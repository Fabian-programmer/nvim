vim.api.nvim_command('autocmd TermOpen,TermEnter * startinsert')

-- Close buffer
local universal_closer = "<A-q>"
vim.keymap.set("n", universal_closer, "<cmd>:Bclose<cr>")

-- bang the terminal
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(event)
    vim.keymap.set({ "n", "t" }, universal_closer, "<cmd>Bclose!<cr>", { buffer = event.buf, silent = true })
  end,
})

-- hide buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "asm",
    "fugitive",
    "help",
    "man",
    "notify",
    "qf",
    "Trouble",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", universal_closer, "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "DiffviewFiles" },
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
