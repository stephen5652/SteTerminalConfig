local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  plugins = {
    marks = true, -- shows a list of your marks on ' and `

    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {

      operators = true, -- adds help for operators like d, y, ...
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      -- z = true, -- bindings for folds, spelling and others prefixed with z
      -- g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  motions = {
    count = true,
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
  show_help = true, -- show a help message in the command line for using WhichKey
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specifiy a list manually
  -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
  triggers_nowait = {
    -- marks
    "`",
    "'",
    "g`",
    "g'",
    -- registers
    '"',
    "<c-r>",
    -- spelling
    "z=",
  },
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for keymaps that start with a native binding
    i = { "j", "k" },
    v = { "j", "k" },
  },
  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by deafult for Telescope
  -- disable = {
  --   buftypes = {},
  --   filetypes = {},
  -- },
}

local opts = {
  mode = "n", -- NORMAL mode
  -- prefix = "W",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

-- 搜索(telescope)
function _G.grep_string_the_file()
  require("telescope.builtin").grep_string({
    grep_open_files = true,
  })
end

function _G.live_grep_the_file()
  require("telescope.builtin").live_grep({
    grep_open_files = true,
  })
end

-- terminal begin
local Terminal = require("toggleterm.terminal").Terminal

-- python terminal
local pyterm = Terminal:new({
  cmd = "python3",
  direction = "horizontal",
})

function _G.python_toggle() -- python terminal
  pyterm:toggle()
end

-- common terminal
local cuterm = Terminal:new()
function _G.st_custome_toogle()
  cuterm:toggle()
end

-- float terminal
local float_term = Terminal:new({
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
})

function _G.st_custome_float_term()
  float_term:toggle()
end

local mappings = {
  ["<leader>"] = {
    b = {
      name = "Buffer management",
      c = { ":bdelete %<CR>", "Delete current buffer" },
      p = { "<cmd>BufferLineCyclePrev<CR>", "Move cursor to pre tab" },
      n = { "<cmd>BufferLineCycleNext<CR>", "Move cursor to next tab" },
    },
    c = {
      name = "Code actions",
      a = {
        name = "Aerial Symbols window",
        o = { "<cmd>AerialOpen right<cr>", "Open" },
        c = { "<cmd>AerialClose<cr>", "Close" },
      },
      s = { "<cmd>SymbolsOutline<cr>", "Show code symbols" },
    },
    d = {
      name = "Debug functions",
      w = { "<cmd>lua require('dapui').toggle()<cr>", "Toogle debug window" },
      b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>j", "(<Leader>db)断点" },
      d = {
        "<cmd>lua require'dap'.close()<CR><cmd>lua require'dap.repl'.close()<CR><cmd>lua require'dapui'.close()<CR>",
        "结束",
      },
      e = { "<cmd>lua require'dapui'.eval()<CR>", "(<Leader>de)查看变量信息" },
      g = { "<cmd>lua require'dap'.continue()<CR>", "(<Leader>dg)开始/下一个断点" },
      i = { "<cmd>lua require'dap'.step_into()<CR>", "(<Leader>di)进入" },
      n = { "<cmd>lua require'dap'.step_over()<CR>", "(<Leader>dn)下一行" },
      o = { "<cmd>lua require'dap'.step_out()<CR>", "(<Leader>do)退出" },
      p = { "<cmd>lua require'dap'.step_back()<CR>", "(<Leader>dp)上一行" },
      r = { "<cmd>lua require'dap'.run_last()<CR>", "(<Leader>dr)重新运行" },
      c = { "<cmd>lua require'dap'.run_to_cursor()<CR>", "(<Leader>rc)运行到当前光标处" },
    },
    e = {
      name = "File explorer",
      e = { ":NvimTreeToggle<cr>", "Show file explorer" },
      f = { ":NvimTreeFindFile<cr>", "Foucus opened file in explorer" },
      s = { "<cmd>w<cr>", "Svae current opened file, same as <c-s>" },
      q = { "<cmd>q<cr>", "Quit current opened file" },
    },
    f = {
      name = "Find",
      f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap = false }, -- additional options for creating the keymap
      s = { "<cmd>lua _G.live_grep_the_file()<cr>", "Find string in current file" },
      S = { "<cmd>Telescope live_grep<cr>", "Find string in workspace" },
      -- C = { "<cmd>Telescope grep_string<cr>", "Find cursor charactor in workspace" },
      -- c = { "<cmd>lua _G.grep_string_the_file()<cr>", "Find cursor charactor in cur file" },
      b = { "<cmd>Telescope buffers<cr>", "Show opened buffers" },
      k = { "<cmd>Telescope keymaps<cr>", "Show all Keymaps" },
      ["1"] = "which_key_ignore", -- special label to hide it in the popup
      -- b = {
      --   function()
      --     print("bar")
      --   end,
      --   "Foobar",
      -- }, -- you can also pass functions!
    },
    g = {
      name = "Git action",
      b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Show current line blame" },
      d = { "<cmd>LazyGitFilterCurrentFile<cr>", "Show current file git history" },
      g = { "<cmd>LazyGitCurrentFile<cr>", "Toggle lazygit view" },
      h = {
        name = "Hunk actions",
        n = { "<cmd>Gitsigns next_hunk<CR>", "Next hunk" },
        p = { "<cmd>Gitsigns prev_hunk<cr>", "Pre hunk" },
        v = { "<cmd>Gitsigns preview_hunk<CR>", "Show hunk preview" },
      },
    },
    l = {
      name = "Develop languages info [lsp treesitter mason]",
      l = {
        name = "Lsp management",
        i = { "<cmd>LspInfo<cr>", "Lsp service info" },
        s = { "<cmd>LspRestart<CR>", "Restart lsp if necessary" },
      },
      m = {
        name = "Mason management",
        t = { "<cmd>Mason<cr>", "Toggle Mason" },
      },
      t = {
        name = "Treesitter management",
        l = { "<cmd>TSInstallInfo<cr>", "Treesitter list supported languages" },
        m = { "<cmd>TSModuleInfo<cr>", "Treesitter show installed info" },
      },
    },
    s = {
      name = "service",
      l = { "<cmd>LiveServer<cr>", "Open / Close live server" },
    },
    t = {
      name = "Terminal",
      p = { "<Cmd>lua _G.python_toggle()<CR>", "Open one python terminal" },
      c = { "<Cmd>lua _G.st_custome_toogle()<CR>", "Open one python terminal" },
      f = { "<cmd>lua _G.st_custome_float_term()<CR>", "Open one float terminal" },
    },
    w = {
      name = "window management",
      a = { "<cmd>lua require'telescope.builtin'.colorscheme()<cr>", "Appearance colorscheme list" },
      v = { "<c-w>v", "Vertically split window" },
      b = { "<c-w>s", "Horizontally split window" },
      e = { "<c-w>=", "Make split windows equal width & height" },
      c = { "<cmd>close<cr>", "Close current split window" },
      h = { "<C-w><c-h>", "Foucus the left split window" },
      l = { "<C-w><c-l>", "Foucus the right split window" },
      k = { "<C-w><c-k>", "Foucus the top split window" },
      j = { "<C-w><c-j>", "Foucus the bottom split window" },
      o = { "<C-w><c-o>", "Close other split windows" },
      m = { "<cmd>MaximizerToggle<cr>", "Make split window maximization" },
      q = { "<cmd>FineCmdline<CR>", "Enter cmd mode" },
    },
  },
  {
    prefix = "<leader>",
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
