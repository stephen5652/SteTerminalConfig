-- pulgin for debuging java: https://github.com/mfussenegger/nvim-jdtls
-- also should istall eclipse.jdt.ls  see the url above
local lsp_path = os.getenv("HOME") .. "/.local/share/nvim/lsp"
local jdtls_path = lsp_path .. "/jdt-language-server/bin/jdtls"

local config = {
  cmd = {
    -- "java",
    "/Users/imac24inch/java/Contents/Home/bin/java",
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
    "-jar",
    lsp_path .. "/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
    "-configuration",
    lsp_path .. "/jdt-language-server/config_mac",
    "-data",
    lsp_path .. "/jdt-language-server/workspace/folder",
  },
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
  settings = {
    java = {},
  },
  init_options = {
    bundles = {},
  },
}
require("jdtls").start_or_attach(config)
