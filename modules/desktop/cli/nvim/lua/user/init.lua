-- disable netrw for file tree plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Bootstrap lazy.nvim into a writable location.
-- Cannot use a nix-store-installed lazy here: lazy regenerates its own helptags
-- and self-updates, both of which require write access to its install path.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup("user.plugins")

-- ensure nvim-tree is properly loaded
require("nvim-tree").setup({
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
})

-- https://github.com/HiPhish/rainbow-delimiters.nvim
vim.g.rainbow_delimiters = {
	strategy = {
		[""] = "rainbow-delimiters.strategy.global",
	},
	query = {
		[""] = "rainbow-delimiters",
	},
}
