vim.cmd([[
	filetype plugin indent on
]])

vim.opt.fillchars:append { eob = " " }
vim.opt.backspace = { 'eol', 'start', 'indent' } -- allow backspacing over everything in insert mode
vim.opt.clipboard = 'unnamedplus'                -- allow neovim to access the system clipboard
vim.opt.fileencoding = 'utf-8'                   -- the encoding written to a file
vim.opt.encoding = 'utf-8'
vim.opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }
vim.opt.syntax = 'enable'

-- indention
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildmenu = true

-- ui
vim.opt.laststatus = 3
vim.opt.lazyredraw = true

-- Hide cmd line
vim.opt.cmdheight = 0

vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.sidescrolloff = 3
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.wrap = false

-- backups
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

-- autocomplete
vim.opt.shortmess = vim.opt.shortmess + {
	c = true
}

-- By the way, -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline.
vim.opt.showmode = false

-- perfomance
-- remember N lines in history
vim.opt.history = 100    -- keep 100 lines of history
vim.opt.redrawtime = 1500
vim.opt.timeoutlen = 250 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 100 -- signify default updatetime 4000ms is not good for async update

-- theme
vim.opt.termguicolors = true

-- persistent undo
-- Don"t forget to create folder $HOME/.local/share/nvim/undo
local undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true
vim.opt.undodir = undodir
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- fold
vim.opt.foldmethod = "marker"
vim.opt.foldlevel = 99

-- Disable builtin plugins
local disabled_built_ins = { "2html_plugin", "getscript", "getscriptPlugin", "gzip", "logipat", "netrw", "netrwPlugin",
	"netrwSettings", "netrwFileHandlers", "matchit", "tar", "tarPlugin", "rrhelper",
	"spellfile_plugin", "vimball", "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin",
	"synmenu", "compiler", "bugreport", "ftplugin" }

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

-- Colorscheme
-- By default, use rose-pine
vim.cmd.colorscheme("rose-pine")

vim.api.nvim_create_user_command("LspClients", function()
	local clients = vim.lsp.get_active_clients()
	if not clients or vim.tbl_isempty(clients) then
		print("No active LSP clients")
		return
	end

	print("Active LSP clients:")
	for _, client in ipairs(clients) do
		print(" - Name: " .. client.name .. " | ID: " .. client.id)
	end
end, {})
