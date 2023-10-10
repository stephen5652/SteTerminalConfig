local singleKey = spoon.RecursiveBinder.singleKey

-- 当前窗口 2分屏 宽度1/2 左分屏
local left_2 = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h
	win:setFrame(f)
end

-- 当前窗口 2分屏 宽度1/2 右分屏
local right_2 = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + max.w / 2
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h
	win:setFrame(f)
end

-- 当前窗口 4分屏 宽度1/2 高度1/2 左上分屏
local left_top_4 = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h / 2
	win:setFrame(f)
end

-- 当前窗口 4分屏 宽度1/2 高度1/2 左下分屏
local left_bottom_4 = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y + max.h / 2
	f.w = max.w / 2
	f.h = max.h / 2
	win:setFrame(f)
end

-- 当前窗口 4分屏 宽度1/2 高度1/2 右上分屏
local right_top_4 = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + max.w / 2
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h / 2
	win:setFrame(f)
end

-- 当前窗口 4分屏 宽度1/2 高度1/2 右下分屏
local right_bottom_4 = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + max.w / 2
	f.y = max.y + max.h / 2
	f.w = max.w / 2
	f.h = max.h / 2
	win:setFrame(f)
end

local full_screen = function()
	hs.window.focusedWindow():toggleFullScreen()
end

local to_right = function()
	local w = hs.window.focusedWindow()
	if not w then
		return
	end
	local s = w:screen():toEast()
	if s then
		w:moveToScreen(s)
	end
end

local to_left = function()
	local w = hs.window.focusedWindow()
	if not w then
		return
	end
	local s = w:screen():toWest()
	if s then
		w:moveToScreen(s)
	end
end

local keyMap = {
	[singleKey("f", "Full screen")] = full_screen,
	[singleKey("g", "to Right")] = to_right,
	[singleKey("s", "to Left")] = to_left,

	[singleKey("y", "Left top")] = left_top_4,
	[singleKey("u", "Right top")] = right_top_4,
	[singleKey("n", "Left bottom")] = left_bottom_4,
	[singleKey("m", "Right bottom")] = right_bottom_4,

	[singleKey("h", "Left")] = left_2,
	[singleKey("l", "Right")] = right_2,
}

local M = {}
M.keyMap = keyMap

return M
