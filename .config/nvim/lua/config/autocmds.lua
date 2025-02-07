local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Auto format on save using the attached (optionally filtered) language servere clients
-- https://neovim.io/doc/user/lsp.html#vim.lsp.buf.format()
autocmd("BufWritePre", {
	pattern = "",
	command = ":silent lua vim.lsp.buf.format()"
})

autocmd("Filetype", {
	pattern = { "gitcommit", "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end
})

autocmd("BufEnter", {
	pattern = "*NvimTree*",
	callback = function()
		vim.cmd("highlight Cursor blend=100")
		vim.cmd("set guicursor+=a:Cursor/lCursor")
	end

})

autocmd("BufLeave", {
	pattern = "*NvimTree*",
	callback = function()
		vim.cmd("highlight Cursor blend=0")
		vim.cmd("set guicursor-=a:Cursor/lCursor")
	end
})
