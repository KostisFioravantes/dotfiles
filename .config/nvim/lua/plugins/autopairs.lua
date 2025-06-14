return { {
	"windwp/nvim-autopairs",
	opts = {
		check_ts = true,
		ts_config = {
			lua = { "string" },
			javascript = { "template_string" },
			java = false
		},

		enable_check_bracket_line = false,
		ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
		fast_wrap = {},
		disable_filetype = { "TelescopePrompt", "vim" }
	},
	config = function(_, opts)
		local npairs = require("nvim-autopairs")
		npairs.setup(opts)
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({
			map_char = {
				tex = ""
			}
		}))
	end
} }
