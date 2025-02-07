local utils = require("utils.utils")
local function typescript_attach(client, bufnr)
	if not client.config.root_dir or client.config.root_dir == "" then
		vim.notify("LSP stopped: No root directory found for buffer", vim.log.levels.WARN)
		vim.lsp.stop_client(client.id)
	end
	utils.rm_conflicted_client(client, bufnr, "denols", "ts_ls")
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
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
			asm_lsp = {},
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
			denols = {},
			svelte = {},
			ts_ls = {},
		},
	},
	config = function(_, opts)
		local lspconfig = require('lspconfig')
		for server, server_opts in pairs(opts.servers) do
			if (server == 'ts_ls') then
				lspconfig[server].setup({
					root_dir = lspconfig.util.root_pattern("tsconfig.json"),
					on_attach = typescript_attach,
					single_file_support = false,
				})
			elseif (server == "denols") then
				lspconfig[server].setup({
					root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
					on_attach = typescript_attach,
					settings = {
						deno = {
							enable = true,
							lint = true,
							unstable = true,
							maxTsServerMemory = 8192,
							documentPreloadLimit = 0,
						},
					},
				})
			else
				lspconfig[server].setup(server_opts)
			end
		end
		require('mason').setup()
	end
}
