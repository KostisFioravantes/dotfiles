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
			cssls = {},
			dockerls = {},
			eslint = {},
			gopls = {},
			html = {},
			jsonls = {
				init_options = {
					provideFormatter = false
				}
			},
			marksman = {},
			pyright = {},
			rust_analyzer = {},
			svelte = {},
			tsserver = {},
			yamlls = {},
			lua_ls = {},
			docker_compose_language_service = {},
		},
	},
	config = function(_, opts)
		for server, server_opts in pairs(opts.servers) do
			require('lspconfig')[server].setup(server_opts)
		end
		require('mason').setup()
	end
}
