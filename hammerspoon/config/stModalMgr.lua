hswhints_keys = hswhints_keys or { "alt", "tab" }
if string.len(hswhints_keys[2]) > 0 then
	spoon.ModalMgr.supervisor:bind(hswhints_keys[1], hswhints_keys[2], "Show Window Hints", function()
		spoon.ModalMgr:deactivateAll()
		hs.hints.windowHints()
	end)
end

spoon.ModalMgr:new("appM")
local cmodal = spoon.ModalMgr.modal_list["appM"]
cmodal:bind("", "escape", "Deactivate appM", function()
	spoon.ModalMgr:deactivate({ "appM" })
end)
cmodal:bind("", "tab", "Toggle Cheatsheet", function()
	spoon.ModalMgr:toggleCheatsheet()
end)

if not hsapp_list then
	hsapp_list = {
		{ key = "f", name = "Finder" },
		{ key = "s", name = "Safari" },
		{ key = "t", name = "Terminal" },
		{ key = "v", id = "com.apple.ActivityMonitor" },
		{ key = "y", id = "com.apple.systempreferences" },
	}
end
for _, v in ipairs(hsapp_list) do
	if v.id then
		local located_name = hs.application.nameForBundleID(v.id)
		if located_name then
			cmodal:bind("", v.key, located_name, function()
				hs.application.launchOrFocusByBundleID(v.id)
				spoon.ModalMgr:deactivate({ "appM" })
			end)
		end
	elseif v.name then
		cmodal:bind("", v.key, v.name, function()
			hs.application.launchOrFocus(v.name)
			spoon.ModalMgr:deactivate({ "appM" })
		end)
	end
end

-- Then we register some keybindings with modal supervisor
hsappM_keys = hsappM_keys or { "alt", "A" }
if string.len(hsappM_keys[2]) > 0 then
	spoon.ModalMgr.supervisor:bind(hsappM_keys[1], hsappM_keys[2], "Enter AppM Environment", function()
		spoon.ModalMgr:deactivateAll()
		-- Show the keybindings cheatsheet once appM is activated
		spoon.ModalMgr:activate({ "appM" }, "#FFBD2E", true)
	end)
end

-- Register AClock
if spoon.AClock then
	hsaclock_keys = hsaclock_keys or { "alt", "T" }
	if string.len(hsaclock_keys[2]) > 0 then
		spoon.ModalMgr.supervisor:bind(hsaclock_keys[1], hsaclock_keys[2], "Toggle Floating Clock", function()
			spoon.AClock:toggleShow()
		end)
	end
end

spoon.ModalMgr.supervisor:enter()
