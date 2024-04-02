return {
	"numToStr/Comment.nvim",
	opts = {
		active = true,
		on_config_done = nil,
		padding = true,
		sticky = true,
		ignore = "^$",

		mappings = {
			basic = true,
			extra = false,
		},

		toggler = {
			line = "<leader>cc",
			block = "<leader>ccb"
		},
		opleader = {
			block = "<leader>c"
		},
	},
	config = function(_, opts)
		require("Comment").setup(opts)
	end
}
