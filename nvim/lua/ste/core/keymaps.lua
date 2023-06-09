-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to enter normal mode
keymap.set({ "i", "v", "c" }, "<leader>jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "<leader>aa", "ggVG")

-- bufferline 左右Tab切换
keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>")
keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- keymap.set("i", "<C-h>", "<Left>", { silent = true })
-- keymap.set("i", "<C-j>", "<Down>", { silent = true })
-- keymap.set("i", "<C-k>", "<Up>", { silent = true })
-- keymap.set("i", "<C-l>", "<Right>", { silent = true })
--
-- keymap.set("i", "<C-b>", "<PageUp>", { silent = true })
-- keymap.set("i", "<C-f>", "PageDown>", { silent = true })

-- window management
keymap.set("n", "<leader>kk", "<c-w>k") -- focus the top window
keymap.set("n", "<leader>jj", "<c-w>j") -- focus the bottom window
keymap.set("n", "<leader>hh", "<c-w>h") -- focus the left window
keymap.set("n", "<leader>ll", "<c-w>l") -- focus the right window

-- tab manager
keymap.set("n", "<S-Up>", ":resize -2<CR>", { silent = true })
keymap.set("n", "<S-Down>", ":resize +2<CR>", { silent = true })
keymap.set("n", "<S-Left>", ":vertical resize -2<CR>", { silent = true })
keymap.set("n", "<S-Right>", ":vertical resize +2<CR>", { silent = true })
keymap.set("t", "<S-Up>", "<cmd>:resize +2<CR>", { silent = true })
keymap.set("t", "<S-Down>", "<cmd>:resize -2<CR>", { silent = true })

keymap.set("n", "<leader>ss", "<cmd>w<CR>")

-- terminal
keymap.set("t", "<ESC>", "<c-\\><c-n>")

-- 快速在buffer间跳转
vim.api.nvim_set_keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })
