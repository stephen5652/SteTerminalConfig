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
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
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
        {
          id = "repl",
          size = 0.25,
        },

        {
          id = "console",
          size = 0.75,
        },
      },
      size = 20,
      position = "bottom",
    },
  },
  -- Use this to override mappings for specific elements
  element_mappings = {
    -- Example:
    -- stacks = {
    --   open = "<CR>",
    --   expand = "o",
    -- }
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  },
})
