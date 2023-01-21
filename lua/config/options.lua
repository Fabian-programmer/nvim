-- Load bclose.vim
vim.cmd('source ~/.config/nvim/lua/config/bclose.vim')

-- Buffer
vim.opt.relativenumber = true
vim.cmd('set noswapfile')

-- Indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.conceallevel = 3 -- Hide * markup for bold and italic

vim.opt.fillchars = { eob = " " }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"


vim.opt.laststatus = 3 -- global statusline
vim.opt.showmode = false

vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true

-- Numbers
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.ruler = false

-- disable nvim intro
vim.opt.shortmess:append "sI"

vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.timeoutlen = 400
vim.opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
vim.opt.updatetime = 200
