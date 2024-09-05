return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"folke/neodev.nvim",
		},
		cond = not vim.g.vscode,
		config = function() end,
	},
	{
		"mrcjkb/rustaceanvim",
		cond = not vim.g.vscode,
		version = "^3",
		ft = { "rust" },
	},
	{
		"mrcjkb/haskell-tools.nvim",
		version = "^4",
		dependencies = {},
		lazy = false,
		cond = not vim.g.vscode,
	},
	{
		"nvimtools/none-ls.nvim",
		cond = not vim.g.vscode,
		config = function() end,
	},
}
