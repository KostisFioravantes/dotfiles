local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return {
			desc = "nvim-tree: " .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true
		}
	end

	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3e4451" })

	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.del("n", "<C-]>", { buffer = bufnr })
	vim.keymap.set("n", "<C-e>", api.tree.reload, opts("Refresh"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		opt = true
	},
	opts = {
		on_attach = on_attach,
		filters = {
			dotfiles = false
		},
		disable_netrw = true,
		hijack_netrw = true,
		hijack_cursor = true,
		hijack_unnamed_buffer_when_opening = false,
		sync_root_with_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = false
		},
		view = {
			adaptive_size = true,
			signcolumn = "auto",
			cursorline = true,
			debounce_delay = 30,
			float = {
				enable = true,
				quit_on_focus_loss = true,
				open_win_config = {
					relative = "editor",
					border = { "", "", "", "│", "", "", "", "", },
					height = 100,
					width = 30,
					row = 0,
					col = 0,
				}
			}
			-- preserve_window_proportions = true
		},
		git = {
			enable = true,
			ignore = false
		},
		sort = {
			sorter = "extension"
		},
		filesystem_watchers = {
			enable = true
		},
		actions = {
			open_file = {
				resize_window = true
			}
		},
		renderer = {
			root_folder_label = false,
			highlight_git = false,
			highlight_opened_files = "none",

			indent_markers = {
				enable = false
			},

			icons = {
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = false
				},

				glyphs = {
					default = "󰈚",
					symlink = "",
					folder = {
						default = "",
						empty = " ",
						empty_open = "",
						open = "",
						symlink = "",
						symlink_open = "",
						arrow_open = " ",
						arrow_closed = "❯"
					},
					git = {
						unstaged = "✗",
						staged = "✓",
						unmerged = "",
						renamed = "➜",
						untracked = "★",
						deleted = "",
						ignored = "◌"
					}
				}
			}
		}
	},
	config = function(_, opts)
		require("nvim-tree").setup(opts)
	end
}
