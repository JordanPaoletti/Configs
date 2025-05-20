-- LSP lazyvim config
return {
	-- LSPs
	-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
	{
		"neovim/nvim-lspconfig",
		name = "lspconfig.lua_ls",
		ft = { "lua" },
		opts = {},
		config = function(_, opts)
			require("lspconfig").lua_ls.setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		name = "lspconfig.nil_ls",
		ft = { "nix" },
		opts = {},
		config = function(_, opts)
			require("lspconfig").nil_ls.setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		name = "lspconfig.nixd",
		ft = { "nix" },
		opts = {},
		config = function(_, opts)
			require("lspconfig").nixd.setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		name = "lspconfig.jedi_language_server",
		ft = { "python" },
		opts = {},
		config = function(_, opts)
			require("lspconfig").jedi_language_server.setup(opts)
		end,
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
