local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none", "--branch=stable",
		"https://github.com/folke/lazy.nvim.git", lazypath
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.opt.termguicolors = true

require("lazy").setup({
	root = vim.fn.stdpath("data") .. "/lazy",
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
	spec = { { import = "plugins" } },
	defaults = {
		lazy = false,
		version = "*",
	},
	install = {
		missing = true,
		colorscheme = { "rose-pine", "habamax" }
	},
	checker = {
		enabled = true,
		notify = false,
		frequency = 86400
	},
	change_detection = {
		enabled = true,
		notify = false
	},
	performance = {
		cache = {
			enabled = true
		}
	},
	state = vim.fn.stdpath("state") .. "/lazy/state.json"
})

local modules = {
	"config.options",
	"config.autocmds",
	"config.keymaps",
}

for _, mod in ipairs(modules) do
	local ok, err = pcall(require, mod)
	if not ok then
		error(("Error loading %s...\n\n%s"):format(mod, err))
	end
end
