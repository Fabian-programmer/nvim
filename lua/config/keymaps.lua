-- better up/down
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move Lines
vim.keymap.set("n", "<A-Up>", ":m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
vim.keymap.set("i", "<A-Up>", "<Esc>:m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("n", "<A-Down>", ":m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("i", "<A-Down>", "<Esc>:m .+1<cr>==gi", { desc = "Move down" })

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
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "No highlight" })

-- save in insert mode
vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>:w<cr><esc>", { desc = "Save Buffer" })

-- change cwd to current file
vim.keymap.set("n", "<leader>c", function()
	vim.cmd(":cd " .. require("util").get_root())
end, { desc = "cd to current file (root dir)" })

-- better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Intend left" })
vim.keymap.set("v", ">", ">gv", { desc = "Intend right" })

-- Tab through buffers
vim.keymap.set("n", "<Tab>", "<cmd>:bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>:bprev<cr>", { desc = "Previous buffer" })

-- Use <esc> to go to normal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { desc = "Normal mode" })

-- Open Terminal
vim.keymap.set({ "i", "n" }, "<A-t>", "<cmd>tab term<cr>", { desc = "Open Terminal" })

-- windows
vim.keymap.set("n", "<leader>wo", "<C-W>o", { desc = "Only visible" })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete" })
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split below" })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split right" })

-- tabs
vim.keymap.set("n", "<leader><tab>o", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader><tab>N", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })