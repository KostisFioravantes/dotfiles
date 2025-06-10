local function typescript_attach(client, bufnr)
end

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
			docker_compose_language_service = {},
			dockerls = {},
			eslint = {
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll"
					})
				end,
				settings = {
					experimental = {
						useFlatConfig = true
					},
					format = true
				}
			},
			html = {},
			jsonls = {},
			lua_ls = {},
			marksman = {},
			pyright = {},
			rust_analyzer = {},
			svelte = {},
			ts_ls = {
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end
			},
		},
	},
	config = function(_, opts)
		local lspconfig = require('lspconfig')
		for server, server_opts in pairs(opts.servers) do
			lspconfig[server].setup(server_opts)
		end
		require('mason').setup()
	end
}
