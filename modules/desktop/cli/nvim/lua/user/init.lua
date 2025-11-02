-- disable netrw for file tree plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- plugins
require("lazy").setup("user.plugins")

-- ensure nvim-tree is properly loaded
require("nvim-tree").setup({})

-- https://github.com/HiPhish/rainbow-delimiters.nvim
vim.g.rainbow_delimiters = {
	strategy = {
		[""] = "rainbow-delimiters.strategy.global",
	},
	query = {
		[""] = "rainbow-delimiters",
	},
}
