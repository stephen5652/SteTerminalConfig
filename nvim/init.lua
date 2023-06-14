require("ste.plugins-setup")
require("ste.core.options")
require("ste.core.colorscheme")
require("colorizer").setup()
require("ste.plugins.comment")
require("ste.plugins.nvim-tree")
require("ste.plugins.lualine")
require("ste.plugins.telescope")
require("ste.plugins.nvim-cmp").setup()
require("ste.plugins.lsp.mason")
require("ste.plugins.lsp.lspsaga")
require("ste.plugins.lsp.lspconfig")
require("ste.plugins.formatter.null-ls")
require("ste.plugins.autopairs")
require("ste.plugins.treesitter")
require("ste.plugins.gitsigns")
require("ste.core.keymaps")

-- dap
require("ste.plugins.dap.dapconfig")

require("ste.plugins.nvim-notify")
require("ste.which-key")
require("ste.plugins.toggleterm")
require("ste.plugins.bufferline")
require("ste.plugins.symbols-outline")
require("ste.plugins.stevearc-aerial")
require("ste.plugins.indent-blankline")
require("ste.plugins.live-server")
require("ste.plugins.nvim-hlslens")

require("ste.plugins.lsp.ste_jdtls_config")
require("ste.plugins.nvim-hop")

-- chat gpt
require("ste.plugins.nvm-chatgpt").setup()

vim.cmd([[ 
  augroup swift_auto_formatter 
    autocmd!

    autocmd BufWritePost  "!swiftformat %"
    " autocddmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])
