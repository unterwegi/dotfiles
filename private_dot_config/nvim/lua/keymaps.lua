local keymap = vim.keymap

-- Fast save, save quit, buffer unloading, force exit
keymap.set("n", "<Leader>w", ":w!<CR>", { desc = "Write!" })
keymap.set("n", "<Leader>x", ":x<CR>", { desc = "Write and exit" })
keymap.set("n", "<Leader>qq", ":q<CR>", { desc = "Quit" })
keymap.set("n", "<Leader>bd", ":bd<CR>", { desc = "Unload Buffer" })
keymap.set("n", "<Leader>qa", ":qa!<CR>", { desc = "Quit all!" })
keymap.set("n", "<Leader>wq", ":wq!<CR>", { desc = "Write and quit!" })
keymap.set("n", "<Leader>cc", ":close<CR>", { desc = "Close current window" })

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

-- Open new split
keymap.set("n", "<Leader>u", ":split<CR>", { desc = "Open new horizontal split" })
keymap.set("n", "<Leader>i", ":vsplit<CR>", { desc = "Open new vertical split" })

-- Move between splits
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to split above" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to split below" })
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to left split" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to right split" })

-- Telescope
local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions
keymap.set("n", "<Leader>ff", builtin.find_files, { desc = "Find Files" })
keymap.set("n", "<Leader>fF", extensions.file_browser.file_browser, { desc = "File Browser" })
keymap.set("n", "<Leader>fg", builtin.live_grep, { desc = "Grep in Files" })
keymap.set("n", "<Leader>fG", builtin.grep_string, { desc = "Grep word under cursor in Files" })
keymap.set("n", "<Leader>fs", builtin.grep_string, { desc = "Find String in Files" })
keymap.set("n", "<Leader>fb", builtin.buffers, { desc = "Find Buffers" })
keymap.set("n", "<Leader>fh", builtin.help_tags, { desc = "Show Help Tags" })

-- Trouble
keymap.set("n", "<Leader>xx", ":TroubleToggle<CR>")
keymap.set("n", "<Leader>xr", ":TroubleToggle lsp_references<CR>")

-- Formatting
keymap.set("n", "<Leader>pp", function()
    return vim.lsp.buf.format()
end, { desc = "Fix document formatting" })

keymap.set("v", "<Leader>pp", function()
    return vim.lsp.buf.range_formatting()
end, { desc = "Fix document formatting for range" })
