-- Reload config
hsreload_keys = hsreload_keys or { { "cmd", "alt", "ctrl" }, "h" }
if string.len(hsreload_keys[2]) > 0 then
	hs.hotkey.bind(hsreload_keys[1], hsreload_keys[2], "Reload Configuration", function()
		hs.reload()
		hs.console.clearConsole()
	end)
end

-- ModalMgr Spoon must be loaded explicitly, because this repository heavily relies upon it.

hs.loadSpoon("ModalMgr")

-- Define default Spoons which will be loaded later
if not hspoon_list then
	hspoon_list = {
		"AClock",
		-- 每日桌面，自己不需要这个插件
		-- "BingDaily",
		"CircleClock",
		-- "ClipShow",
		-- "CountDown",
		"HCalendar",
		-- "HSaria2",
		-- "HSearch",
		-- "SpeedMenu",
		"WinWin",
		-- "FnMate",
	}
end

-- Load those Spoons
for _, v in pairs(hspoon_list) do
	hs.loadSpoon(v)
end

require("config.stRecursiveBinder")
require("config.stModalMgr")
require("config.stWifi")

local function reloadConfig(paths)
	doReload = false
	for _, file in pairs(paths) do
		if file:sub(-4) == ".lua" then
			print("A lua config file changed, reload")
			doReload = true
		end
	end
	if not doReload then
		print("No lua file changed, skipping reload")
		return
	end

	hs.reload()
end

configFileWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig)
configFileWatcher:start()
