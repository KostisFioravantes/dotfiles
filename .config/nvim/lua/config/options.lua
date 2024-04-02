local cmd = vim.cmd
-- Set options (global/buffer/windows-scoped)
local opt = vim.opt
-- Global variables
local g = vim.g
local s = vim.s
local indent = 4

cmd([[
	filetype plugin indent on
]])

opt.fillchars:append { eob = " " }
opt.backspace = {'eol', 'start', 'indent'} -- allow backspacing over everything in insert mode
opt.clipboard = 'unnamedplus' -- allow neovim to access the system clipboard
vim.opt.fileencoding = 'utf-8' -- the encoding written to a file
opt.encoding = 'utf-8'
opt.matchpairs = {'(:)', '{:}', '[:]', '<:>'}
opt.syntax = 'enable'

-- indention
opt.tabstop = 4
opt.shiftwidth = 4

-- search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + {"*/node_modules/*", "*/.git/*", "*/vendor/*"}
opt.wildmenu = true -- make tab completion for files/buffers act like bash

-- ui
opt.laststatus = 3
opt.lazyredraw = true

-- Hide cmd line
opt.cmdheight = 0

opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.sidescrolloff = 3
opt.signcolumn = "yes"
opt.splitright = true
opt.wrap = false

-- backups
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- autocomplete
opt.shortmess = opt.shortmess + {
    c = true
} -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"

-- By the way, -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline.
opt.showmode = false

-- perfomance
-- remember N lines in history
opt.history = 100 -- keep 100 lines of history
opt.redrawtime = 1500
opt.timeoutlen = 250 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.ttimeoutlen = 10
opt.updatetime = 100 -- signify default updatetime 4000ms is not good for async update

-- theme
opt.termguicolors = true

-- persistent undo
-- Don"t forget to create folder $HOME/.local/share/nvim/undo
local undodir = vim.fn.stdpath("data") .. "/undo"
opt.undofile = true -- enable persistent undo
opt.undodir = undodir
opt.undolevels = 1000
opt.undoreload = 10000

-- fold
opt.foldmethod = "marker"
opt.foldlevel = 99

-- Disable builtin plugins
local disabled_built_ins = {"2html_plugin", "getscript", "getscriptPlugin", "gzip", "logipat", "netrw", "netrwPlugin",
                            "netrwSettings", "netrwFileHandlers", "matchit", "tar", "tarPlugin", "rrhelper",
                            "spellfile_plugin", "vimball", "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin",
                            "synmenu", "optwin", "compiler", "bugreport", "ftplugin"}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

-- Colorscheme
-- By default, use rose-pine
cmd.colorscheme("rose-pine")
