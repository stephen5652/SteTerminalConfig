-- require("bufferline").setup({
--   options = {
--     mode = "buffer",
--     -- 显示id
--     number = "ordinal",
--     -- 使用 nvim 内置lsp
--     diagnostics = "nvim_lsp",
--     -- 左侧让出 nvim-tree 的位置
--     offsets = {
--       {
--         filetype = "NvimTree",
--         text = "File Explorer",
--         highlight = "Directory",
--         text_align = "left",
--       },
--     },
--   },
-- })

vim.opt.termguicolors = true
require("bufferline").setup({
  options = {
    mode = "buffer",
    themable = true,
    -- 显示id
    numbers = function(opts)
      return string.format("%s", opts.lower(opts.ordinal))
    end,

    -- 左侧让出 nvim-tree 的位置
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
})

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
vim.api.nvim_set_keymap("n", "<leader>bg", ":BufferLinePick", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bc", ":bdelete %<CR>", { noremap = true, silent = true })
