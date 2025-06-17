-- LSP lazyvim config
return {
	-- LSPs
    -- see: https://github.com/neovim/nvim-lspconfig
	-- servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
	{
		"neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            -- coq: https://github.com/ms-jpq/coq_nvim?tab=readme-ov-file#lazynvim
            { "ms-jpq/coq_nvim", branch = "coq" }, -- main
            { "ms-jpq/coq.artifacts", branch = "artifacts" }, -- snippets
        },
        init = function()
            vim.g.coq_settings = {
                auto_start = 'shut-up',
                keymap = {
                    jump_to_mark = "<c-m>"
                },
            }
        end,
		config = function()
            local coq = require("coq")
			local server_settings = {
				lua_ls = {},
				nil_ls = {},
				nixd = {},
				jedi_language_server = {},
			}

			for server, settings in pairs(server_settings) do
                vim.lsp.config(server, coq)
				vim.lsp.enable(server, coq.lsp_ensure_capabilities(settings))
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
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
		},
	},
}
