-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to enter normal mode
keymap.set({ "i", "v", "c" }, "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

keymap.set("i", "<C-h>", "<Left>", { silent = true })
keymap.set("i", "<C-j>", "<Down>", { silent = true })
keymap.set("i", "<C-k>", "<Up>", { silent = true })
keymap.set("i", "<C-l>", "<Right>", { silent = true })

keymap.set("i", "<C-b>", "<PageUp>", { silent = true })
keymap.set("i", "<C-f>", "PageDown>", { silent = true })

-- tab manager
keymap.set("n", "<S-Up>", ":resize -2<CR>", { silent = true })
keymap.set("n", "<S-Down>", ":resize +2<CR>", { silent = true })
keymap.set("n", "<S-Left>", ":vertical resize -2<CR>", { silent = true })
keymap.set("n", "<S-Right>", ":vertical resize +2<CR>", { silent = true })
keymap.set("t", "<S-Up>", "<cmd>:resize +2<CR>", { silent = true })
keymap.set("t", "<S-Down>", "<cmd>:resize -2<CR>", { silent = true })

keymap.set({ "n", "i", "v" }, "<c-s>", "<cmd>w<CR>")

-- terminal
keymap.set("t", "jk", "<c-\\><c-n>")
keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
-- keymap.set("t", "<leader>l", "<Cmd> wincmd l<CR>", { noremap = true, silent = true })
-- keymap.set("t", "<leader>h", "<Cmd> wincmd h<CR>", { noremap = true, silent = true })
-- keymap.set("t", "<leader>j", "<Cmd> wincmd j<CR>", { noremap = true, silent = true })
-- keymap.set("t", "<leader>k", "<Cmd> wincmd k<CR>", { noremap = true, silent = true })
