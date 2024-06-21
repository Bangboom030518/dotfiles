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
		"nvimtools/none-ls.nvim",
		cond = not vim.g.vscode,
		config = function() end,
	},
}
