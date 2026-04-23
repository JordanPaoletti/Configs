-- Java LSP via jdtls with optional Bemol integration for Brazil workspaces.
-- Usage: install bemol (`toolbox install bemol`), then run `bemol --watch`
-- from your Brazil workspace root before opening nvim.
-- Without bemol, jdtls still works for standard Maven/Gradle projects.
return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		config = function()
			local jdtls = require("jdtls")
			local coq = require("coq")

			local root_dir = require("jdtls.setup").find_root({ "packageInfo", ".git", "pom.xml", "build.gradle" }, "Config")
			local home = os.getenv("HOME")
			local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
			local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

			-- Read Bemol workspace folders for Brazil support
			local ws_folders = {}
			if root_dir then
				local file = io.open(root_dir .. "/.bemol/ws_root_folders")
				if file then
					for line in file:lines() do
						table.insert(ws_folders, "file://" .. line)
					end
					file:close()
				end
			end

			jdtls.start_or_attach(coq.lsp_ensure_capabilities({
				cmd = { "jdtls", "-data", workspace_dir },
				root_dir = root_dir,
				init_options = {
					workspaceFolders = ws_folders,
				},
			}))
		end,
	},
}
