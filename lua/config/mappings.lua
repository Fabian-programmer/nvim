local wk = require("which-key")

vim.o.timeoutlen = 300

wk.setup({
  show_help = false,
  triggers = "auto",
  plugins = { spelling = true },
  key_labels = { ["<leader>"] = "SPC" },
})

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
vim.keymap.set({"i", "n"}, "<C-s>", "<cmd>:w<cr><esc>")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Toggling NvimTree
vim.keymap.set("n", "<C-n>", "<cmd>:NvimTreeToggle<cr>")

-- Tab through buffers
vim.keymap.set("n", "<Tab>", "<cmd>:bnext<cr>")
vim.keymap.set("n", "<S-Tab>", "<cmd>:bprev<cr>")

-- Use <esc> to go to normal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>")

-- Open Terminal
vim.keymap.set({"i", "n"}, "<A-t>", "<cmd>tab term<cr>")

local leader = {
  ["/"] = {
    {
      require("Comment.api").toggle.linewise.current,
      "Comment",
    },
    {
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
      "Comment range",
      mode = 'v',
    },
  },

  c = {
    name = "+code",
  },
  d = {
    name = "+debug",
  },
  g = {
    name = "+git",
    c = { "<cmd>Telescope git_commits<cr>", "Commits" },
    b = { "<cmd>Telescope git_branches<cr>", "Branches" },
    s = { "<cmd>Telescope git_status<cr>", "Status" },
    o = { "<cmd>DiffviewOpen<cr>", "DiffView open" },
    d = { "<cmd>DiffviewFileHistory<cr>", "DiffView files" },
    f = { "<cmd>DiffviewFileHistory %<cr>", "DiffView current files" },
    h = { name = "+hunk" },
  },
  ["h"] = {
    name = "+help",
    t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
    c = { "<cmd>:Telescope commands<cr>", "Commands" },
    h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
    m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
    k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
    s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
    l = { vim.show_pos, "Highlight Groups at cursor" },
    f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
    o = { "<cmd>:Telescope vim_options<cr>", "Options" },
    a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
  },
  f = {
    name = "+find",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    o = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    g = { "<cmd>Telescope live_grep<cr>", "Grep" },
    b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
    h = { "<cmd>Telescope command_history<cr>", "Command History" },
    p = { "<cmd>Telescope project<cr>", "Project" },
    s = {
      function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        })
      end,
      "Goto Symbol",
    },
    m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
  },
  ["t"] = {
    name = "+test",
    n = { "<cmd>TestNearest<cr>", "Nearest" },
    f = { "<cmd>TestFile<cr>", "File" },
    s = { "<cmd>TestSuite<cr>", "Suite" },
    l = { "<cmd>TestLast<cr>", "Last" },
    v = { "<cmd>TestVisit<cr>", "Visit" },
  },
}

for i = 0, 10 do
  leader[tostring(i)] = "which_key_ignore"
end

wk.register(leader, { prefix = "<leader>" })

wk.register({ g = { name = "+goto" } })
