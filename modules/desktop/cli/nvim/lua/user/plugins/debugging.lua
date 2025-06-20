return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>db",
				"<cmd>lua require('dap').toggle_breakpoint()<CR>",
				desc = "Toggle Breakpoint (nvim-dap)",
			},
			{
				"<leader>dc",
				"<cmd>lua require('dap').continue()<CR>",
				desc = "Launch Debug Session and/or resume execution (nvim-dap)",
			},
			{
				"<leader>ds",
				"<cmd>lua require('dap').step_over()<CR>",
				desc = "Step Over Line (nvim-dap)",
			},
			{
				"<leader>di",
				"<cmd>lua require('dap').step_into()<CR>",
				desc = "Step Into Line (nvim-dap)",
			},
			{
				"<leader>do",
				"<cmd>lua require('dap').repl.open()<CR>",
				desc = "Open State Inspector(nvim-dap)",
			},
		},
		config = function()
			local dap = require("dap")

			-- python
			dap.adapters.python = function(cb, config)
				if config.request == "attach" then
					---@diagnostic disable-next-line: undefined-field
					local port = (config.connect or config).port
					---@diagnostic disable-next-line: undefined-field
					local host = (config.connect or config).host or "127.0.0.1"
					cb({
						type = "server",
						port = assert(port, "`connect.port` is required for a python `attach` configuration"),
						host = host,
						options = {
							source_filetype = "python",
						},
					})
				else
					cb({
						type = "executable",
						command = "python3",
						args = { "-m", "debugpy.adapter" },
						options = {
							source_filetype = "python",
						},
					})
				end
			end

			dap.configurations.python = {
				{
					-- The first three options are required by nvim-dap
					type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
					request = "launch",
					name = "Launch file",

					-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

					program = "${file}", -- This configuration will launch the current file if used.
					pythonPath = function()
						-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
						-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
						-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
						local cwd = vim.fn.getcwd()
						if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
							return cwd .. "/venv/bin/python"
						elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
							return cwd .. "/.venv/bin/python"
						else
							return "/usr/bin/python"
						end
					end,
				},
			}
		end,
	},
}
