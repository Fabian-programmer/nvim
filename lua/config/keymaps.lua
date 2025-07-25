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
vim.keymap.set({ "i", "n" }, "<Esc>", "<cmd>noh<cr><Esc>", { desc = "No highlight" })

-- delete word
vim.keymap.set("i", "<A-BS>", "<Esc>ciw", { desc = "Delete word" })
vim.keymap.set("n", "<BS>", "ciw", { desc = "Delete word" })

-- center in middle
vim.keymap.set("n", "<C-b>", "<C-b>zz", { noremap = true })
vim.keymap.set("n", "<C-f>", "<C-f>zz", { noremap = true })

-- redo on same key
vim.keymap.set("n", "U", "<C-r>")

-- save in insert mode
vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>:w<cr><esc>", { desc = "Save Buffer" })

-- change cwd to current buffer
vim.keymap.set("n", "<leader>C", function() vim.cmd(":cd %:h") end, { desc = "cd to current file" })

-- toggle inlay hints
---@format disable-next
vim.keymap.set("n", "<leader>ci", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle Inlay Hints" })

-- better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Intend left" })
vim.keymap.set("v", ">", ">gv", { desc = "Intend right" })

-- Tab through buffers
vim.keymap.set("n", "<Tab>", "<cmd>:bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>:bprev<cr>", { desc = "Previous buffer" })

-- Open Terminal
vim.keymap.set({ "i", "n" }, "<A-t>", "<cmd>:terminal<cr>", { desc = "Open Terminal" })

-- tabs
vim.keymap.set("n", "<leader><Tab>n", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><Tab><Tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><Tab>q", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader><Tab><S-Tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- directories (like fzf keybinding)
---@format disable-next
vim.keymap.set("n", "<A-c>", function() require("util").find_directory(os.getenv("HOME")) end, { desc = "Directories (Home)" })
vim.keymap.set("n", "<A-C>", function() require("util").find_directory('/') end, { desc = "Directories (/)" })

-- cmake targets
vim.keymap.set("n", "<leader>cc", function() require("util.cmake").find_cmake_targets() end, { desc = "CMake Targets" })

-- find and open corresponding assembly
---@format disable-next
vim.keymap.set("n", "<leader>ba", function() require("util.workflow").open_asm_file_in_split() end, { desc = "Find corresponding assembly file" })
