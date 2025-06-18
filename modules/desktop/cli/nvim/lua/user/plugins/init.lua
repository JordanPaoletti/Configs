return {
	{
		-- file navigation/editing
		{
			"nvim-tree/nvim-tree.lua",
			lazy = false,
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
			keys = {
				{
					"<leader>t",
					"<cmd>NvimTreeToggle<cr>",
					desc = "Toggle File Tree",
				},
			},
		},
		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			keys = {
				{
					"<leader>ff",
					"<cmd>Telescope find_files<cr>",
					desc = "Telescope find files",
				},
				{
					"<leader>fg",
					"<cmd>Telescope live_grep<cr>",
					desc = "Telescope live grep",
				},
				{
					"<leader>fb",
					"<cmd>Telescope buffers<cr>",
					desc = "Telescope buffers",
				},
				{
					"<leader>fh",
					"<cmd>Telescope help_tags<cr>",
					desc = "Telescope help tags",
				},
			},
		},
		-- movement
		{
			"easymotion/vim-easymotion",
			lazy = false,
		},
		-- orgmode
		{
			"nvim-orgmode/orgmode",
			event = "VeryLazy",
			ft = { "org" },
			config = function()
				require("orgmode").setup({
					org_agenda_files = "~/orgfiles/**/*",
					org_default_notes_file = "~/orgfiles/refile.org",
				})
			end,
		},
	},
}
