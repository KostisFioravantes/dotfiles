return {
	'neovim/nvim-lspconfig',
	lazy = true,
	event = {
		'BufReadPre',
		'BufNewFile'
	},
	dependencies = {
		{ 'williamboman/mason.nvim' },
		{ 'williamboman/mason-lspconfig.nvim' },
		{
			'hrsh7th/nvim-cmp',
			dependencies = {
				'L3MON4D3/LuaSnip',
				'hrsh7th/cmp-path',
				'hrsh7th/cmp-buffer',
				'hrsh7th/cmp-nvim-lsp',
				'saadparwaiz1/cmp_luasnip'
			}
		}
	},
	opts = {
		format = {
			formatting_options = nil,
			timeout_ms = nil
		},
		servers = {
			bashls = {},
			clangd = {},
			cssls = {
				init_options = {
					provideFormatter = false
				}
			},
			dockerls = {},
			gopls = {},
			html = {},
			jsonls = {},
			docker_compose_language_service = {},
			marksman = {},
			pyright = {},
			tsserver = {},
			rust_analyzer = {},
			svelte = {
				settings = {
					format = false,
				}
			},
			lua_ls = {},
			asm_lsp = {},
			eslint = {
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll"
					})
				end,
				settings = {
					codeAction = {
						disableRuleComment = {
							enable = true,
							location = "separateLine"
						},
						showDocumentation = {
							enable = true
						}
					},
					codeActionOnSave = {
						enable = true,
						mode = "problems"
					},
					experimental = {
						useFlatConfig = true
					},
					format = false,
					nodePath = "",
					onIgnoredFiles = "off",
					problems = {
						shortenToSingleLine = false
					},
					quiet = false,
					rulesCustomizations = {},
					run = "onType",
					useESLintClass = false,
					validate = "on",
					workingDirectory = {
						mode = "location"
					}
				}
			},
		},
	},
	config = function(_, opts)
		for server, server_opts in pairs(opts.servers) do
			require('lspconfig')[server].setup(server_opts)
		end
		require('mason').setup()
	end
}
