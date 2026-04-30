-- Treesitter config for Neovim 0.12+
-- Highlighting and indent are built-in; nvim-treesitter plugin is no longer needed.
-- We only use the companion plugins (textobjects, context) as standalone.
return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = false,
		config = function()
			require("nvim-treesitter-textobjects").setup()

			-- Textobject keymaps
			local move = require("nvim-treesitter-textobjects.move")
			local select = require("nvim-treesitter-textobjects.select")
			local swap = require("nvim-treesitter-textobjects.swap")

			-- Select
			local select_maps = {
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			}
			for key, query in pairs(select_maps) do
				vim.keymap.set({ "x", "o" }, key, function()
					select.select_textobject(query, "textobjects")
				end)
			end

			-- Move
			local move_maps = {
				["]m"] = { "@function.outer", "goto_next_start" },
				["]]"] = { "@class.outer", "goto_next_start" },
				["]M"] = { "@function.outer", "goto_next_end" },
				["]["] = { "@class.outer", "goto_next_end" },
				["[m"] = { "@function.outer", "goto_previous_start" },
				["[["] = { "@class.outer", "goto_previous_start" },
				["[M"] = { "@function.outer", "goto_previous_end" },
				["[]"] = { "@class.outer", "goto_previous_end" },
			}
			for key, val in pairs(move_maps) do
				vim.keymap.set({ "n", "x", "o" }, key, function()
					move[val[2]](val[1], "textobjects")
				end)
			end

			-- Swap
			vim.keymap.set("n", "<leader>a", function()
				swap.swap_next("@parameter.inner", "textobjects")
			end)
			vim.keymap.set("n", "<leader>A", function()
				swap.swap_previous("@parameter.inner", "textobjects")
			end)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = false,
		opts = {
			max_lines = 10,
			multiline_threshold = 1,
		},
		keys = {
			{
				"[C",
				function()
					require("treesitter-context").go_to_context(vim.v.count1)
				end,
				silent = true,
			},
		},
	},
}
