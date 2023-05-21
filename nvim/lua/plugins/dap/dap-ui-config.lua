local dap_breakpoint_color = {
	breakpoint = {
		ctermbg = 0,
		fg = "#993939",
		bg = "#31353f",
	},
	logpoing = {
		ctermbg = 0,
		fg = "#61afef",
		bg = "#31353f",
	},
	stopped = {
		ctermbg = 0,
		fg = "#98c379",
		bg = "#31353f",
	},
}

vim.api.nvim_set_hl(0, "DapBreakpoint", dap_breakpoint_color.breakpoint)
vim.api.nvim_set_hl(0, "DapLogPoint", dap_breakpoint_color.logpoing)
vim.api.nvim_set_hl(0, "DapStopped", dap_breakpoint_color.stopped)

local dap_breakpoint = {
	error = {
		text = "",
		texthl = "DapBreakpoint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	},
	condition = {
		text = "ﳁ",
		texthl = "DapBreakpoint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	},
	rejected = {
		text = "",
		texthl = "DapBreakpint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	},
	logpoint = {
		text = "",
		texthl = "DapLogPoint",
		linehl = "DapLogPoint",
		numhl = "DapLogPoint",
	},
	stopped = {
		text = "",
		texthl = "DapStopped",
		linehl = "DapStopped",
		numhl = "DapStopped",
	},
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)

-- 定义 dapui 窗口的位置和大小
vim.g.dapui_winnr_scopes = "vertical"
vim.g.dapui_winnr_variables = "vertical"
vim.g.dapui_winnr_breakpoints = "vertical botright"
vim.g.dapui_winnr_stack = "vertical botright"
vim.g.dapui_winnr_watches = "vertical botright"

-- 隐藏 dapui 插件的边框
vim.g.dapui_border_style = "none"

-- 禁用 dapui 的自动布局
vim.g.dapui_auto_reposition = false

require("dapui").setup({
	layouts = {
		{
			elements = {
				{
					id = "scopes",
					size = 0.25,
				},
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.25 },
				{ id = "breakpoints", size = 0.25 },
			},
			size = 40,
			position = "right",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 5,
			position = "bottom",
		},
	},
})
