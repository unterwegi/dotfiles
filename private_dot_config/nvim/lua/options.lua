-- global settings
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.modeline = true
vim.o.syntax = "on"
vim.o.termguicolors = true
vim.o.errorbells = false
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hidden = true
vim.o.completeopt="menuone,noinsert,noselect"
vim.opt.sessionoptions:append("localoptions") -- remember localoptions in sessions
vim.bo.smartindent = true
vim.bo.autoindent = true

vim.bo.swapfile = false
vim.o.undofile = true
vim.o.backup = false

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
vim.wo.wrap = false

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.scrolloff = 5
vim.o.sidescrolloff = 32
