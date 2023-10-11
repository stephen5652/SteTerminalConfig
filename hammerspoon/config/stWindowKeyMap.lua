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

-- 当前窗口 2分屏 高度1/2 上分屏
local top_2 = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = max.h / 2
	win:setFrame(f)
end

-- 当前窗口 2分屏 高度1/2 下分屏
local bottom_2 = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y + max.h / 2
	f.w = max.w
	f.h = max.h / 2
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

local maxsize_screen = function()
	hs.grid.maximizeWindow()
end

local center_screen = function()
	local w = hs.window.focusedWindow()
	if not w then
		return
	end

	w:centerOnScreen()
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
	[singleKey("d", "maxsize screen")] = maxsize_screen,
	[singleKey("c", "center screen")] = center_screen,

	[singleKey("g", "to Right")] = to_right,
	[singleKey("s", "to Left")] = to_left,

	[singleKey("y", "Left top")] = left_top_4,
	[singleKey("u", "Right top")] = right_top_4,
	[singleKey("n", "Left bottom")] = left_bottom_4,
	[singleKey("m", "Right bottom")] = right_bottom_4,

	[singleKey("h", "Left")] = left_2,
	[singleKey("l", "Right")] = right_2,
	[singleKey("j", "Top")] = top_2,
	[singleKey("k", "bottom")] = bottom_2,
}

local M = {}
M.keyMap = keyMap

return M
