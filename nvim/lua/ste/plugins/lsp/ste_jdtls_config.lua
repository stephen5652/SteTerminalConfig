local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify("JDTLS not found, install with `:LspInstall jdtls`")
  return
end

local VIM_PLUGINS_PACKAGE_PATH = vim.fn.stdpath("data")
-- Installation location of jdtls by nvim-lsp-installer
local home = os.getenv("HOME")
local java_home = home .. "/jdk_17/Contents/Home"
local JDTLS_LOCATION = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local JAVA_DEBUG_TOOLS_DIR = vim.fn.stdpath("data") .. "/jdtls"

local java_jdtls_file = vim.fn.glob(JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local java_debug_file = vim.fn.glob(
  JAVA_DEBUG_TOOLS_DIR .. "/java-debug_17/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
)
local java_lombok_file = JAVA_DEBUG_TOOLS_DIR .. "/lombok.jar"

-- Data directory - change it to your liking
local HOME = os.getenv("HOME")
local WORKSPACE_PATH = HOME .. "/workspace/java/"

-- Only for Linux and Mac
local SYSTEM = "linux"
if vim.fn.has("mac") == 1 then
  SYSTEM = "mac"
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Debugging
local bundles = {
  java_debug_file,
}

-- vim.list_extend(bundles, vim.split(vim.fn.glob(DEBUGGER_LOCATION .. "/vscode-java-test/server/*.jar"), "\n"))

local on_attach_function = function(client, bufnr)
  -- require("ste.plugins.lsp.lspconfig").on_attach(client, bufnr)

  local function buf_set_keymap(...)
    vim.keymap.set(...)
  end

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

  -- buf_set_keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  local java_key_map = {

    ["<leader>"] = {
      j = {
        name = "Java debug action",
        c = {
          name = "Code action",
          i = { "<Cmd>lua require'jdtls'.organize_imports()<CR>", "Organize imports", opts },
          t = { "<Cmd>lua require'jdtls'.test_class()<CR>", "Test current class", opts },
          n = { "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", "Test nearest method", opts },
          e = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract variable", opts },
          m = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract method", opts },
        },
      },
    },

    {
      prefix = "<leader>",
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    -- prefix = "W",
    buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }
  require("which-key").register(java_key_map, opts)

  -- this function takes alot of time, should run lastly
  if require("dap").adapters.java then
    return
  end

  require("jdtls").setup_dap({ hotcodereplace = "auto" })
  vim.notify("Start find main class")
  require("jdtls.dap").setup_dap_main_class_configs()
  vim.lsp.codelens.refresh()
  vim.notify("Find main class finish")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- for nvim-cmp

local function on_attach_jdtls_func(client, bufnr)
  print("jdtls on_attach_jdtls_func running")
  vim.notify("jdtls on_attach_jdtls_func running:" .. client.name)
  require("config.lsp").on_attach(client, bufnr)
end

local config = {
  cmd = {
    java_home .. "/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    -- lombok
    "-javaagent:" .. java_lombok_file,

    "-jar",
    java_jdtls_file,
    "-configuration",
    JDTLS_LOCATION .. "/config_" .. SYSTEM,
    "-data",
    workspace_dir,
  },

  on_attach = on_attach_function,
  capabilities = capabilities,
  root_dir = root_dir,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      -- format = {
      --   enabled = true,
      --   settings = {
      --     url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
      --     profile = "GoogleStyle",
      --   },
      -- },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      hashCodeEquals = {
        useJava7Objects = true,
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = bundles,
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
--

function _G.ste_jdtls_setup()
  require("jdtls").start_or_attach(config)
  require("jdtls.setup").add_commands()
end

vim.cmd([[
augroup jdtls_lsp
    autocmd!
    autocmd FileType java lua _G.ste_jdtls_setup()

augroup end
]])
