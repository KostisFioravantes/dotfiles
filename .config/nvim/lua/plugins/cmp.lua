return {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		{
			'L3MON4D3/LuaSnip',
			dependencies = 'rafamadriz/friendly-snippets',
			opts = {
				history = true,
				updateevents = 'TextChanged,TextChangedI'
			},
			config = function(_, opts)
				require('luasnip').config.set_config(opts)
				require('luasnip.loaders.from_vscode').lazy_load()
				require('luasnip.loaders.from_vscode').lazy_load {
					paths = vim.g.vscode_snippets_path or ''
				}

				vim.api.nvim_create_autocmd('InsertLeave', {
					callback = function()
						if require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()] and
						not require('luasnip').session.jump_active then
							require('luasnip').unlink_current()
						end
					end
				})
			end
		},
		{
			"zbirenbaum/copilot-cmp",
			config = function()
				require("copilot_cmp").setup()
			end
		},
		{
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
		}
	},
	opts = function()
		local cmp = require('cmp')
		local snip_status_ok, luasnip = pcall(require, 'luasnip')
		local lspkind_status_ok, lspkind = pcall(require, "lspkind")

		if not snip_status_ok  then
				return
		end

		local border_opts = {
				scrollbar = false,
				border = "rounded",
				winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
		}

		local function has_words_before()
			local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
		end

		local options = {
			window = {
				completion = cmp.config.window.bordered(border_opts),
				documentation = cmp.config.window.bordered(border_opts)
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end
			},
			mapping = {
				['<C-u>'] = cmp.mapping.scroll_docs(-4),
				['<C-d>'] = cmp.mapping.scroll_docs(4),
				['<CR>'] = cmp.mapping.confirm({
					select = false,
					behavior =  cmp.ConfirmBehavior.Replace
				}),
				['<Tab>'] = function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
					elseif has_words_before() then
							cmp.complete()
					else
						fallback()
					end
				end,
				['<S-Tab>'] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end
			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{
					name = 'buffer',
					option = {
						-- Avoid accidentally running on big files
						get_bufnrs = function()
							local buf = vim.api.nvim_get_current_buf()
							local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
							if byte_size > 1048576 then
								return {}
							end
							return {buf}
						end
					}
				},
				{ name = 'copilot' },
				{ name = 'path' }
			}
		}

		if lspkind_status_ok then
			options.formatting = {
				format = lspkind.cmp_format({
					mode = 'symbol',
					with_width = 50,
					symbol_map = { Copilot = '' }
				})
			}
		end

		return options
	end,
	config = function(_, opts)
		require('cmp').setup(opts)
	end
}
