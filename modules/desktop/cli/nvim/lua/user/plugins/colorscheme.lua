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
				custom_highlights = function(colors)
					-- Default LineNr is surface1, which is barely visible
					-- against the base background. Bump to overlay1 for
					-- legibility without being distracting.
					return {
						LineNr = { fg = colors.overlay1 },
						LineNrAbove = { fg = colors.overlay1 },
						LineNrBelow = { fg = colors.overlay1 },
					}
				end,
			})
			-- Catppuccin v2 renamed the colorscheme from `catppuccin` to
			-- `catppuccin-nvim` to avoid colliding with the built-in
			-- `catppuccin` shipped with Neovim 0.12.
			vim.cmd.colorscheme("catppuccin-nvim")
		end,
	},
}
