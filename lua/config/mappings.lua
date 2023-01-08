-- Move to window using the <ctrl> movement keys
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Move to left Window" })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Move to bottom Window" })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Move to top Window" })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Move to right Window" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>", { desc = "Resize + horizontal" })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>", { desc = "Resize - horizontal" })
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize - vertical" })
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize + vertical" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "No highlight"})

-- save in insert mode
vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>:w<cr><esc>", { desc = "Save Buffer"})

-- better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Intend left"})
vim.keymap.set("v", ">", ">gv", { desc = "Intend right"})

-- Tab through buffers
vim.keymap.set("n", "<Tab>", "<cmd>:bnext<cr>", { desc = "Next buffer"})
vim.keymap.set("n", "<S-Tab>", "<cmd>:bprev<cr>", { desc = "Previous buffer"})

-- Use <esc> to go to normal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { desc = "Normal mode"})

-- Open Terminal
vim.keymap.set({ "i", "n" }, "<A-t>", "<cmd>tab term<cr>", { desc = "Open Terminal"})
