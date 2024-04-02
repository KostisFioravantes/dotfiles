return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			delete = {
				hl = "GitSignsDelete",
			},
			topdelete = {
				hl = "GitSignsDelete",
			},
			changedelete = {
				hl = "GitSignsChange",
				numhl = "GitSignsChangeNr",
			},
		},
		watch_gitdir = {
			enable = true,
			interval = 1000,
			follow_files = true
		},
		max_file_length = 100000,
		attach_to_untracked = true,
		current_line_blame_opts = {
			virt_text_pos = "right_align",
			delay = 50,
		},

		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			local function map(mode, lhs, rhs, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, lhs, rhs, opts)
			end

			-- Navigation
			map('n', '<space>h', function()
				if vim.wo.diff then return '<space>h' end
				vim.schedule(function() gs.next_hunk() end)
				return '<Ignore>'
			end, { expr = true })

			map('n', '<space>H', function()
				if vim.wo.diff then return '<space>H' end
				vim.schedule(function() gs.prev_hunk() end)
				return '<Ignore>'
			end, { expr = true })

			-- Actions
			map('n', '<space>rh', gs.reset_hunk)
			map('v', '<space>rh', function()
				gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
			end)

			map('n', '<space>sh', gs.stage_hunk)
			map('v', '<space>sh', function()
				gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
			end)

			map('n', '<space>ph', gs.preview_hunk)
			map('n', '<space>ush', gs.undo_stage_hunk)
			map('n', '<space>tb', gs.toggle_current_line_blame)
			map('n', '<space>td', gs.toggle_deleted)
		end
	},
	config = function(_, opts)
		require("gitsigns").setup(opts)
	end
}
