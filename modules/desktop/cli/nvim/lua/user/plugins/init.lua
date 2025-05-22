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
		-- movement
		{
			"easymotion/vim-easymotion",
			lazy = false,
		},
	},
}
