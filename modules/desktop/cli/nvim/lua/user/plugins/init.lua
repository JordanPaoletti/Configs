return {
	{
		-- file navigation/editing
		{
			"nvim-tree/nvim-tree.lua",
			lazy = false,
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
			opts = {
				view = {
					width = {
						min = 30,
						max = 100,
					},
					adaptive_size = true,
				},
				renderer = {
					group_empty = true,
				},
				git = {
					ignore = false,
				},
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
            "sindrets/diffview.nvim"
        },
		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			opts = {
				defaults = {
					layout_config = {
						width = 0.9,
						preview_width = 0.5,
					},
					path_display = { "truncate" },
				},
				pickers = {
					find_files = {
						hidden = true,
						no_ignore = true,
					},
				},
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
		-- other utility
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
			-- use opts = {} for passing setup options
			-- this is equivalent to setup({}) function
		},
		{
			"julienvincent/nvim-paredit",
			config = function()
				require("nvim-paredit").setup()
			end,
		},
	},
}
