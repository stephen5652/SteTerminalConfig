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
