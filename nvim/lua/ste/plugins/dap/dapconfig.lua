-- define which debug adaptor shoud install
-- avalied adaptors  https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
require("mason-nvim-dap").setup({
  ensure_installed = {
    -- defing the adaptor should install, then create an language adaptor config file etc. dap_python
    "stylua",
    "jq",
    "python",
    "lldb-vscode",
    "javadbg",
  },
  automatic_setup = true,
  automatic_installation = true,
})

require("ste.plugins.dap.dap-ui")
require("ste.plugins.dap.dap_python")
require("ste.plugins.dap.clangd")
require("ste.plugins.dap.dap_java")
