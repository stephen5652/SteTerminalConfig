-- import lspconfig plugin safely

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
  return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  vim.notify("lspconfig on_attach client: " .. client.name)
  -- keybind options
  local opts = { noremap = true, silent = false, buffer = bufnr }

  -- set keybinds
  keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)                     -- show definition, referenceslspco
  keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)          -- got to declaration
  keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)                -- see definition and make edits in window
  keymap.set("n", "gbb", "<c-o>", opts)                                          -- see definition and make edits in window
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)       -- go to implementation
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)                 -- smart rename
  keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)   -- show  diagnostics for line
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)           -- jump to previous diagnostic in buffer
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)           -- jump to next diagnostic in buffer
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)                       -- show documentation for what is under cursor
  -- keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

  -- if client.name == "jdtls" then
  --   require("ste.plugins.lsp.ste_jdtls_config").ste_jdtls_setup()
  -- end
end

-- mason_lspconfig
require("mason-lspconfig").setup({
  -- list of servers for mason to install
  ensure_installed = {
    "ts_ls",
    "html",
    "cssls",
    "tailwindcss",
    "lua_ls",
    "clangd",
    "cssls",
    "emmet_ls",
    "jsonls",
    "jdtls",
    "marksman",
    "pyright",
    "solargraph",
    "sqlls",
    "vuels",
    "custom_elements_ls",
    "wgsl_analyzer",
    "lemminx",
    "yamlls",
    -- "standardrb",
  },
  -- auto-install configured servers (with lspconfig)
  automatic_installation = true, -- not the same as ensure_installed
})
-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure typescript server with plugin
-- typescript.setup({
--   server = {
--     capabilities = capabilities,
--     on_attach = on_attach,
--   },
-- })

-- configure css server
lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "classList", "ngClass" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = { -- custom settings for lua
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- lspconfig.jdtls.setup({
--   -- capabilities = capabilities,
--   -- on_attach = on_attach,
-- })

lspconfig.marksman.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- solargraph
lspconfig.solargraph.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
  settings = {
    solargraph = {
      diagnostics = true,
    },
  },
})

lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- lspconfig.standardrb.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

-- sqlls
lspconfig.sqlls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

--veture
lspconfig.vuels.setup({
  cmd = {
    "vls",
  },
  init_options = {
    config = {
      css = {},
      emmet = {},
      html = {
        suggest = {},
      },
      javascript = {
        format = {},
      },
      stylusSupremacy = {},
      typescript = {
        format = {},
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
  root_dir = lspconfig.util.root_pattern("package.json", "vue.config.js"),
})

require("lspconfig").custom_elements_ls.setup({

  filetypes = {
    -- "javascript",
    -- "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "html",
    "vue",
  },
})

-- wgsl_analyzer
lspconfig.wgsl_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- lemminx
lspconfig.lemminx.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- yamlls
lspconfig.yamlls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.dartls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

local M = {}
M.on_attach = on_attach

return M
