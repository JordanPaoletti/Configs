local pluginLists = {
	require("user.lazy.lsps"),
	require("user.lazy.treesitter"),
	{
		-- movement
		{
			"easymotion/vim-easymotion",
			lazy = false,
		},
		-- Formatting
		{
			"stevearc/conform.nvim",
			keys = {
				{
					"<leader>f",
					function()
						require("conform").format({ async = true })
					end,
					mode = "",
					desc = "Format Buffer",
				},
			},
			config = function()
				require("user.lazy.conform")
			end,
		},
	},
}

-- flatten plugin lists
local plugins = {}
local idx = 1
for i = 1, #pluginLists do
	local list = pluginLists[i]
	for j = 1, #list do
		plugins[idx] = list[j]
		idx = idx + 1
	end
end

-- https://github.com/folke/lazy.nvim#-plugin-spec
require("lazy").setup(plugins)
