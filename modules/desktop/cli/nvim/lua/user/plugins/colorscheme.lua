return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				default_integrations = true,
				integrations = {
					-- Enable non-default integrations for plugins we use.
					diffview = true,
					lsp_trouble = true,
					aerial = true,
				},
			})
			-- Catppuccin v2 renamed the colorscheme from `catppuccin` to
			-- `catppuccin-nvim` to avoid colliding with the built-in
			-- `catppuccin` shipped with Neovim 0.12.
			vim.cmd.colorscheme("catppuccin-nvim")
		end,
	},
}
