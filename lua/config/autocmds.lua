-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local exclude = { "gitcommit" }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- start in insert mode in terminal
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
  pattern = {
    "term://*bash",
  },
  callback = function()
    vim.cmd("startinsert")
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = {
    "term://*bash",
  },
  callback = function(event)
    -- go to normal mode
    vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { desc = "Normal mode", buffer = event.buf, silent = true })
    -- bang the terminal
    -- stylua: ignore
    vim.keymap.set({ "n", "t" }, "<A-q>", function() require("mini.bufremove").delete(0, true) end, { buffer = event.buf, silent = true })
  end,
})

-- hide buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "asm",
    "help",
    "man",
    "notify",
    "qf",
    "Trouble*",
    "dap-float",
    "spectre_panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
