local dap = require("dap")
dap.set_log_level("DEBUG")

-- dap.adapters.java = function(on_adapter)
--   -- This asks the system for a free port
--   local tcp = vim.loop.new_tcp()
--   tcp:bind("127.0.0.1", 0)
--   local port = tcp:getsockname().port
--   tcp:shutdown()
--   tcp:close()
--
--   local adapter = {
--     type = "server",
--     host = "127.0.0.1",
--     port = 5005,
--   }
--   -- 💀
--   -- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
--   -- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
--   on_adapter(adapter)
-- end

local home = os.getenv("HOME")
local java_home = home .. "/jdk_17/Contents/Home"
local jdtls_home = os.getenv("HOMEBREW_PREFIX") .. "/Cellar/jdtls/1.23.0"
local root_markers = { "gradlew", "pom.xml" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local workspace_folder = home .. "/.workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local jdtls = require("jdtls")
local java_debug = home .. "/.local/share/nvim/jdtls/java-debug_17"

dap.configurations.java = {
  {
    type = "java",
    request = "attach",
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  },
}
