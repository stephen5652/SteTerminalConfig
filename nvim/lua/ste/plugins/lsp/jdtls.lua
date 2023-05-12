--  suggetiong documents: https://blog.csdn.net/lxyoucan/article/details/123453802
--  https://github.com/mfussenegger/nvim-jdtls
--
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
function _G.ste_jdtls_setup()
  local home = os.getenv("HOME")
  local java_home = home .. "/jdk_17/Contents/Home"
  local jdtls_home = os.getenv("HOMEBREW_PREFIX") .. "/Cellar/jdtls/1.23.0"
  local root_markers = { "mvnw", "gradlew", "pom.xml" }
  local root_dir = require("jdtls.setup").find_root(root_markers)
  local workspace_folder = home .. "/.workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  local jdtls = require("jdtls")
  local java_debug = home .. "/.local/share/nvim/jdtls/java-debug_17"
  local config = {

    on_attach = function(client, bufnr)
      -- require("me.lsp.conf").on_attach(client, bufnr, {
      --   server_side_fuzzy_completion = true,
      -- })

      local function buf_set_keymap(...)
        vim.keymap.set(...)
      end

      jdtls.setup_dap({ hotcodereplace = "auto" })
      jdtls.setup.add_commands()
      jdtls.setup_dap_main_class_configs()

      local opts = { noremap = true, silent = false, buffer = bufnr }

      buf_set_keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
      buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
      buf_set_keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
      buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
      buf_set_keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
      buf_set_keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename

      buf_set_keymap("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
      buf_set_keymap("n", "gl", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
      buf_set_keymap("n", "gp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
      buf_set_keymap("n", "gn", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer

      buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
      buf_set_keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

      buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
      -- buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      -- buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      buf_set_keymap("n", "<leader>pa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
      buf_set_keymap("n", "<leader>pr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
      buf_set_keymap("n", "<leader>pl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
      -- buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
      buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      buf_set_keymap("n", "gr", '<cmd>lua vim.lsp.buf.references()  vim.cmd("copen")<CR>', opts)
      buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

      -- Java specific
      buf_set_keymap("n", "<leader>cdi", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
      buf_set_keymap("n", "<leader>cdt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
      buf_set_keymap("n", "<leader>cdn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
      buf_set_keymap("v", "<leader>cde", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
      buf_set_keymap("v", "<leader>cdm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

      buf_set_keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end,

    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

      -- 💀
      java_home .. "/bin/java",
      -- 'java', -- or '/path/to/java17_or_newer/bin/java'
      -- depends on if `java` is in your $PATH env variable and if it points to the right version.

      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",

      -- 💀
      "-jar",
      vim.fn.glob(jdtls_home .. "/libexec/plugins/org.eclipse.equinox.launcher_*.jar"),
      -- '-jar', '/path/to/jdtls_install_location/plugins/org.eclipse.equinox.launcher_VERSION_NUMBER.jar',
      -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
      -- Must point to the                                                     Change this to
      -- eclipse.jdt.ls installation

      -- 💀
      "-configuration",
      jdtls_home .. "/libexec/config_mac",
      -- '-configuration', '/path/to/jdtls_install_location/config_SYSTEM',
      -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
      -- Must point to the                      Change to one of `linux`, `win` or `mac`
      -- eclipse.jdt.ls installation

      -- 💀
      "-data",
      workspace_folder,
      -- See `data directory configuration` section in the README
      -- '-data', '/path/to/unique/per/project/workspace/folder'
    },

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = root_dir,

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
      java = {},
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
      bundles = {
        java_debug .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.45.0.jar",
      },
    },
  }
  -- This starts a new client & server,
  -- or attaches to an existing client & server depending on the `root_dir`.
  require("jdtls").start_or_attach(config)
end

vim.cmd([[
augroup jdtls_lsp
    autocmd!
    autocmd FileType java lua _G.ste_jdtls_setup()

augroup end
]])
