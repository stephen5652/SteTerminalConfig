-- Show Wi-Fi notifications
local wifiwatcher = hs.wifi.watcher.new(function()
	local net = hs.wifi.currentNetwork()
	if net == nil then
		hs.notify.show("You lost Wi-Fi connection", "", "", "")
	else
		hs.notify.show("Connected to Wi-Fi network", "", net, "")
	end
end)
wifiwatcher:start()
