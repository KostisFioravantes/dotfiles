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

local function wrap_cmd(cmd)
	return function() vim.cmd(cmd) end
end

-- Move
vim.keymap.set('n', '<C-w>h', '<Nop>')
vim.keymap.set('n', '<C-w>j', '<Nop>')
vim.keymap.set('n', '<C-w>k', '<Nop>')
vim.keymap.set('n', '<C-w>l', '<Nop>')

vim.keymap.set('n', '<C-h>', wrap_cmd('wincmd h'))
vim.keymap.set('n', '<C-j>', wrap_cmd('wincmd j'))
vim.keymap.set('n', '<C-k>', wrap_cmd('wincmd k'))
vim.keymap.set('n', '<C-l>', wrap_cmd('wincmd l'))

-- nvim-tree
vim.keymap.set('n', '<C-n>', wrap_cmd('NvimTreeToggle'))

-- Diagnostics
-- <leader> is a space now
vim.keymap.set('n', '<leader>do', wrap_cmd('lua vim.diagnostic.open_float()'))
vim.keymap.set('n', '<leader>d[', wrap_cmd(':lua vim.diagnostic.goto_prev()'))
vim.keymap.set('n', '<leader>d]', wrap_cmd(':lua vim.diagnostic.goto_next()'))

-- Telescope
-- <leader> is a space now
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fd', builtin.diagnostics)
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
