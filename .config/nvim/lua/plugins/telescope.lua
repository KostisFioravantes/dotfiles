return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make"
		}
	},
	config = function(_, opts)
		local telescope = require("telescope")
		local telescopeConfig = require("telescope.config")
		local vimgrep_args = { unpack(telescopeConfig.values.vimgrep_arguments) }

		table.insert(vimgrep_args, "-g")
		table.insert(vimgrep_args, ".*")

		telescope.setup({
			defaults = {
				vimgrep_arguments = vimgrep_args,
			},
			pickers = {
				hidden = true
			}
		})
		telescope.load_extension("fzf")
	end
}
