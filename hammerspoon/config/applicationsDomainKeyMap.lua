function script_path()
	local str = debug.getinfo(1, "S").source:sub(2)
	return str:match("(.*[/ \\])") --删除后面的文件，只保留路径
end

local config_path = script_path() .. "config.json"
local config = hs.json.read(config_path)
local singleKey = spoon.RecursiveBinder.singleKey

local applicationsKeyMap = {}
hs.fnutils.each(config.applications, function(app)
	applicationsKeyMap[singleKey(app.key, app.name)] = function()
		hs.application.launchOrFocusByBundleID(app.bundleID)
	end
end)

local domainsKeyMap = {}
hs.fnutils.each(config.domains, function(domain)
	domainsKeyMap[singleKey(domain.key, domain.name)] = function()
		hs.urlevent.openURL("https://" .. domain.url)
	end
end)

local M = {}
M.applicationsKeyMap = applicationsKeyMap
M.domainsKeyMap = domainsKeyMap

return M
