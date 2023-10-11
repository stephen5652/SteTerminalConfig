hs.loadSpoon("RecursiveBinder")
require("utilities.st_utilities")

spoon.RecursiveBinder.escapeKey = { {}, "escape" } -- Press escape to abort

applicationMaps = require("config.applicationsDomainKeyMap")
windowKeyMap = require("config.stWindowKeyMap")

local singleKey = spoon.RecursiveBinder.singleKey

local keyMap = {
	[singleKey("a", "applications+")] = applicationMaps.applicationsKeyMap,
	[singleKey("d", "domain+")] = applicationMaps.domainsKeyMap,
	[singleKey("w", "windows+")] = windowKeyMap.keyMap,
	[singleKey("h", "hammerspoon+")] = {
		[singleKey("r", "reload")] = function()
			hs.reload()
			hs.console.clearConsole()
		end,
		[singleKey("c", "config")] = function()
			hs.execute("/usr/local/bin/code ~/.hammerspoon")
		end,
	},
}

hs.hotkey.bind({ "cmd", "option", "ctrl" }, "a", spoon.RecursiveBinder.recursiveBind(keyMap))

spoon.RecursiveBinder.helperFormat = {
	atScreenEdge = 2, -- Bottom edge (default value)
	textStyle = { -- An hs.styledtext object
		font = {
			name = "Mononoki Nerd Font",
			size = 16,
		},
	},
}
