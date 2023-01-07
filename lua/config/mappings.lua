-- Move to window using the <ctrl> movement keys
vim.keymap.set("n", "<C-Left>", "<C-w>h")
vim.keymap.set("n", "<C-Down>", "<C-w>j")
vim.keymap.set("n", "<C-Up>", "<C-w>k")
vim.keymap.set("n", "<C-Right>", "<C-w>l")

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- save in insert mode
vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>:w<cr><esc>")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Tab through buffers
vim.keymap.set("n", "<Tab>", "<cmd>:bnext<cr>")
vim.keymap.set("n", "<S-Tab>", "<cmd>:bprev<cr>")

-- Use <esc> to go to normal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>")

-- Open Terminal
vim.keymap.set({ "i", "n" }, "<A-t>", "<cmd>tab term<cr>")
