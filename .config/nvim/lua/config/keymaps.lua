--[[
Modes:
	Normal (n)
	Insert (i)
	Visual (v)
	Select (s)
	Terminal (t)
	Lsp-args (l)
	Coomand-line (c)
	Visual-Block (x)
	Operator-Pending (o)
]]
--

-- Move
vim.keymap.set('n', '<C-w>h', '<Nop>')
vim.keymap.set('n', '<C-w>j', '<Nop>')
vim.keymap.set('n', '<C-w>k', '<Nop>')
vim.keymap.set('n', '<C-w>l', '<Nop>')

vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')

-- Reload configuration without restart nvim
vim.keymap.set('n', '<leader>r', ':so %<CR>')

-- NvimTree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>nr', ':NvimTreeRefresh<CR>')
vim.keymap.set('n', '<leader>nf', ':NvimTreeFindFile<CR>')

-- Diagnostics
-- <leader> is a space now
vim.keymap.set('n', '<leader>do', ':lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '<leader>d[', ':lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', '<leader>d]', ':lua vim.diagnostic.goto_next()<CR>')

-- Telescope
-- <leader> is a space now
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fd', builtin.diagnostics)
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
