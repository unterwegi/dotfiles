local keymap = vim.keymap
local g = vim.g

-- Spacebar is <Leader>
g.mapleader = " "
g.maplocalleader = " "
keymap.set("", "<Space>", "<Nop>", { silent = true })

-- Fast save, save quit, force exit
keymap.set("n", "<Leader>w", ":w!<CR>", { desc = "Write!" })
keymap.set("n", "<Leader>x", ":x<CR>", { desc = "Write and exit" })
keymap.set("n", "<Leader>qq", ":q<CR>", { desc = "Quit" })
keymap.set("n", "<Leader>qa", ":qa!<CR>", { desc = "Quit all!" })
keymap.set("n", "<Leader>wq", ":wq!<CR>", { desc = "Write and quit!" })

-- Easier cursor movement on wrapped line
keymap.set("n", "k", "gk")
keymap.set("n", "j", "gj")
keymap.set("v", "k", "gk")
keymap.set("v", "j", "gj")
keymap.set("n", "<Up>", "gk")
keymap.set("n", "<Down>", "gj")
keymap.set("v", "<Up>", "gk")
keymap.set("v", "<Down>", "gj")
keymap.set("i", "<Up>", "<C-o>gk")
keymap.set("i", "<Down>", "<C-o>gj")

-- Move cursors in Insert mode
keymap.set("i", "<C-k>", "<Up>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")

-- Move paragraph
keymap.set("", "K", "{", { desc = "Go up a paragraph" })
keymap.set("", "J", "}", { desc = "Go down a paragraph" })

-- Move to first and last char in current line
keymap.set("", "H", "^", { desc = "Move cursor to first char" })
keymap.set("", "L", "$", { desc = "Move cursor to last char" })

-- Indent or de-indent
keymap.set("n", "<Tab>", ">>", { desc = "Add indentation" })
keymap.set("n", "<S-Tab>", "<<", { desc = "De-indentation" })
keymap.set("v", "<Tab>", ">gv", { desc = "Add indentation" })
keymap.set("v", "<S-Tab>", "<gv", { desc = "De-indentation" })

