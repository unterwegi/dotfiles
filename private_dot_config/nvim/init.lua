require("options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Spacebar is <Leader> (must be set up before lazy is set up)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("", "<Space>", "<Nop>", { silent = true })

require("lazy").setup("plugins")
require("keymaps")
require("autocmds")

-- Some custom filetype associations
vim.filetype.add({
  extension = {
    dox = "cpp",
  },
})
