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
      -- motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      -- windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      -- z = true, -- bindings for folds, spelling and others prefixed with z
      -- g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  -- key_labels = {
  -- override the label used to display some keys. It doesn't effect WK in any other way.
  -- For example:
  -- ["<space>"] = "SPC",
  -- ["<cr>"] = "RET",
  -- ["<tab>"] = "TAB",
  -- },
  -- motions = {
  --   count = true,
  -- },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  -- popup_mappings = {
  --   scroll_down = "<c-d>", -- binding to scroll down inside the popup
  --   scroll_up = "<c-u>", -- binding to scroll up inside the popup
  -- },
  -- window = {
  --   border = "rounded", -- none, single, double, shadow
  --   position = "bottom", -- bottom, top
  --   margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
  --   padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
  --   winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
  -- },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  -- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
  show_help = true, -- show a help message in the command line for using WhichKey
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  -- triggers = "auto", -- automatically setup triggers
  triggers = {"<leader>"} -- or specifiy a list manually
  -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
  -- triggers_nowait = {
  --   -- marks
  --   "`",
  --   "'",
  --   "g`",
  --   "g'",
  --   -- registers
  --   '"',
  --   "<c-r>",
  --   -- spelling
  --   "z=",
  -- },
  -- triggers_blacklist = {
  --   -- list of mode / prefixes that should never be hooked by WhichKey
  --   -- this is mostly relevant for keymaps that start with a native binding
  --   i = { "j", "k" },
  --   v = { "j", "k" },
  -- },
  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by deafult for Telescope
  -- disable = {
  --   buftypes = {},
  --   filetypes = {},
  -- },
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
    prompt_title = "Fuzzy Live Grep",
    use_regex = true, -- 启用正则表达式模式
    search = "\\w+\\s+\\w+", -- 使用正则表达式模式进行匹配
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

which_key.add({
  {
    {
      "<leader>b",
      group = "Buffer management",
      nowait = true,
      remap = false,
    },
    {
      "<leader>bc",
      ":bdelete %<CR>",
      desc = "Delete current buffer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>bn",
      "<cmd>BufferLineCycleNext<CR>",
      desc = "Move cursor to next tab",
      nowait = true,
      remap = false,
    },
    {
      "<leader>bo",
      "<cmd>%bd|e#<cr>",
      desc = "Close other buffer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>bp",
      "<cmd>BufferLineCyclePrev<CR>",
      desc = "Move cursor to pre tab",
      nowait = true,
      remap = false,
    },
    {
      "<leader>c",
      group = "Code actions",
      nowait = true,
      remap = false,
    },
    {
      "<leader>cS",
      group = "Aerial Symbols window",
      nowait = true,
      remap = false,
    },
    {
      "<leader>cSc",
      "<cmd>AerialClose<cr>",
      desc = "Close",
      nowait = true,
      remap = false,
    },
    {
      "<leader>cSo",
      "<cmd>AerialOpen right<cr>",
      desc = "Open",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ca",
      "<cmd>Lspsaga code_action<CR>",
      desc = "See available code actions",
      nowait = true,
      remap = false,
    },
    {
      "<leader>cf",
      "<cmd>lua vim.lsp.buf.format()<cr>",
      desc = "Formatter current file",
      nowait = true,
      remap = false,
    },
    {
      "<leader>cs",
      "<cmd>SymbolsOutline<cr>",
      desc = "Show code symbols",
      nowait = true,
      remap = false,
    },
    {
      "<leader>d",
      group = "Debug functions",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dC",
      "<cmd>lua require'dapui'.float_element('console', {enter = true, width = 150})<cr>",
      desc = "Float Console",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dE",
      "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",
      desc = "Evaluate Input",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dR",
      "<cmd>lua require'dapui'.float_element('repl', {enter = true})<cr>",
      desc = "Float Repl",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dS",
      "<cmd>lua require'dapui'.float_element('scopes', {enter = true})<cr>",
      desc = "Float Scopes",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dT",
      "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
      desc = "Conditional Breakpoint",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dU",
      "<cmd>lua require'dapui'.toggle()<cr>",
      desc = "Toggle UI",
      nowait = true,
      remap = false,
    },
    {
      "<leader>db",
      "<cmd>lua require'dap'.step_back()<cr>",
      desc = "Step Back",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dc",
      "<cmd>lua require'dap'.continue()<cr>",
      desc = "Continue",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dd",
      "<cmd>lua require'dap'.disconnect()<cr>",
      desc = "Disconnect",
      nowait = true,
      remap = false,
    },
    {
      "<leader>de",
      "<cmd>lua require'dapui'.eval()<cr>",
      desc = "Evaluate",
      nowait = true,
      remap = false,
    },
    {
      "<leader>df",
      "<cmd>lua require'dapui'.float_element('scopes', {enter = true})<cr>",
      desc = "Float scopes",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dg",
      "<cmd>lua require'dap'.session()<cr>",
      desc = "Get Session",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dh",
      "<cmd>lua require'dap.ui.widgets'.hover()<cr>",
      desc = "Hover Variables",
      nowait = true,
      remap = false,
    },
    {
      "<leader>di",
      "<cmd>lua require'dap'.step_into()<cr>",
      desc = "Step Into",
      nowait = true,
      remap = false,
    },
    {
      "<leader>do",
      "<cmd>lua require'dap'.step_over()<cr>",
      desc = "Step Over",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dp",
      "<cmd>lua require'dap'.pause.toggle()<cr>",
      desc = "Pause",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dq",
      "<cmd>lua require'dap'.close()<cr>",
      desc = "Quit",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dr",
      "<cmd>lua require'dap'.run_to_cursor()<cr>",
      desc = "Run to Cursor",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ds",
      "<cmd>lua require'dap'.continue()<cr>",
      desc = "Start",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dt",
      "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
      desc = "Toggle Breakpoint",
      nowait = true,
      remap = false,
    },
    {
      "<leader>du",
      "<cmd>lua require'dap'.step_out()<cr>",
      desc = "Step Out",
      nowait = true,
      remap = false,
    },
    {
      "<leader>dx",
      "<cmd>lua require'dap'.terminate()<cr>",
      desc = "Terminate",
      nowait = true,
      remap = false,
    },
    {
      "<leader>e",
      group = "File explorer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ee",
      ":NvimTreeToggle<cr>",
      desc = "Show file explorer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ef",
      ":NvimTreeFindFile<cr>",
      desc = "Foucus opened file in explorer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>eq",
      "<cmd>q<cr>",
      desc = "Quit current opened file",
      nowait = true,
      remap = false,
    },
    {
      "<leader>es",
      "<cmd>w<cr>",
      desc = "Svae current opened file, same as <c-s>",
      nowait = true,
      remap = false,
    },
    {
      "<leader>f",
      group = "Find",
      nowait = true,
      remap = false,
    },
    {
      "<leader>f1",
      hidden = true,
      nowait = true,
      remap = false,
    },
    {
      "<leader>fF",
      "<cmd>Telescope oldfiles<cr>",
      desc = "Open Recent File",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fa",
      "<cmd>Telescope live_grep<cr>",
      desc = "Find string in workspace",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fb",
      "<cmd>Telescope buffers<cr>",
      desc = "Show opened buffers",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ff",
      "<cmd>Telescope find_files<cr>",
      desc = "Find File",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fk",
      "<cmd>Telescope keymaps<cr>",
      desc = "Show all Keymaps",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fl",
      "<cmd>HopLine<cr>",
      desc = "search charactor in line",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fs",
      "<cmd>lua _G.live_grep_the_file()<cr>",
      desc = "Find string in all opened buffers",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fw",
      "<cmd>HopWord<cr>",
      desc = "search words",
      nowait = true,
      remap = false,
    },
    {
      "<leader>g",
      group = "Git action",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gb",
      "<cmd>Gitsigns toggle_current_line_blame<cr>",
      desc = "Show current line blame",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gd",
      "<cmd>LazyGitFilterCurrentFile<cr>",
      desc = "Show current file git history",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gg",
      "<cmd>HopChar2<cr>",
      desc = "search HopChar2",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gh",
      group = "Hunk actions",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ghn",
      "<cmd>Gitsigns next_hunk<CR>",
      desc = "Next hunk",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ghp",
      "<cmd>Gitsigns prev_hunk<cr>",
      desc = "Pre hunk",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ghv",
      "<cmd>Gitsigns preview_hunk<CR>",
      desc = "Show hunk preview",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gt",
      "<cmd>LazyGitCurrentFile<cr>",
      desc = "Toggle lazygit view",
      nowait = true,
      remap = false,
    },
    {
      "<leader>h",
      group = "Hop functions",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ha",
      "<cmd>HopAnywhere<cr>",
      desc = "search charactor HopAnywhere",
      nowait = true,
      remap = false,
    },
    {
      "<leader>l",
      group = "Develop languages info [lsp treesitter mason]",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lm",
      group = "Mason management",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lmt",
      "<cmd>Mason<cr>",
      desc = "Toggle Mason",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ls",
      group = "Lsp management",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lsi",
      "<cmd>LspInfo<cr>",
      desc = "Lsp service info",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lss",
      "<cmd>LspRestart<CR>",
      desc = "Restart lsp if necessary",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lt",
      group = "Treesitter management",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ltl",
      "<cmd>TSInstallInfo<cr>",
      desc = "Treesitter list supported languages",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ltm",
      "<cmd>TSModuleInfo<cr>",
      desc = "Treesitter show installed info",
      nowait = true,
      remap = false,
    },
    {
      "<leader>o",
      group = "ChatGPT",
      nowait = true,
      remap = false,
    },
    {
      "<leader>oa",
      "<cmd>ChatGPTActAs<cr>",
      desc = "ChatGPTActAs",
      nowait = true,
      remap = false,
    },
    {
      "<leader>oe",
      "<cmd>ChatGPT<cr>",
      desc = "ChatGPT ",
      nowait = true,
      remap = false,
    },
    {
      "<leader>oi",
      "<cmd>ChatGPTEditWithInstructions<cr>",
      desc = "ChatGPTEditWithInstructions",
      nowait = true,
      remap = false,
    },
    {
      "<leader>s",
      group = "service",
      nowait = true,
      remap = false,
    },
    {
      "<leader>sf",
      "<cmd>lua vim.lsp.buf.format()<cr> <cmd>w<cr>",
      desc = "Format and Save current file",
      nowait = true,
      remap = false,
    },
    {
      "<leader>sl",
      "<cmd>LiveServer<cr>",
      desc = "Open / Close live server",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ss",
      "<cmd>w<CR>",
      desc = "Save current file",
      nowait = true,
      remap = false,
    },
    {
      "<leader>t",
      group = "Terminal",
      nowait = true,
      remap = false,
    },
    {
      "<leader>tf",
      "<cmd>lua _G.st_custome_float_term()<CR>",
      desc = "Open one float terminal",
      nowait = true,
      remap = false,
    },
    {
      "<leader>tp",
      "<Cmd>lua _G.python_toggle()<CR>",
      desc = "Open one python terminal",
      nowait = true,
      remap = false,
    },
    {
      "<leader>tt",
      "<Cmd>lua _G.st_custome_toogle()<CR>",
      desc = "Open one pane terminal",
      nowait = true,
      remap = false,
    },
    {
      "<leader>w",
      group = "window management",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wa",
      "<cmd>lua require'telescope.builtin'.colorscheme()<cr>",
      desc = "Appearance colorscheme list",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wb",
      "<c-w>v",
      desc = "Vertically split window",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wc",
      "<cmd>close<cr>",
      desc = "Close current split window",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wd",
      "<c-c>cmd>Startup display<cr>",
      desc = "Show Dashboard",
      nowait = true,
      remap = false,
    },
    {
      "<leader>we",
      "<c-w>=",
      desc = "Make split windows equal width & height",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wh",
      "<C-w><c-h>",
      desc = "Foucus the left split window",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wj",
      "<C-w><c-j>",
      desc = "Foucus the bottom split window",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wk",
      "<C-w><c-k>",
      desc = "Foucus the top split window",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wl",
      "<C-w><c-l>",
      desc = "Foucus the right split window",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wm",
      "<cmd>MaximizerToggle<cr>",
      desc = "Make split window maximization",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wn",
      "<cmd>tabnew %<cr>",
      desc = "Make current cursor tab to new",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wo",
      "<C-w><c-o>",
      desc = "Close other split windows",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wq",
      "<cmd>FineCmdline<CR>",
      desc = "Enter cmd mode",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wv",
      "<c-w>s",
      desc = "Horizontally split window",
      nowait = true,
      remap = false,
    },
    mode = { "n", "v" }, -- NORMAL and VISUAL mode
  },
})

which_key.setup(setup)
