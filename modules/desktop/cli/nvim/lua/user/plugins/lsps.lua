-- LSP lazyvim config
return {
	-- LSPs
    -- see: https://github.com/neovim/nvim-lspconfig
	-- servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
	{
		"neovim/nvim-lspconfig",
		config = function()
			local server_settings = {
				lua_ls = {},
				nil_ls = {},
				nixd = {},
				jedi_language_server = {},
			}

			for server, settings in pairs(server_settings) do
				vim.lsp.enable(server)
			end
		end,
	},

	-- Navigation
	{
		"stevearc/aerial.nvim",
		opts = {
			backends = { "lsp", "treesitter", "markdown" },
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{
				"<leader><leader>a",
				"<cmd>AerialToggle!<CR>",
				desc = "Toggle Aerial Navigation Window",
			},
		},
	},

	-- Diagnostics
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
