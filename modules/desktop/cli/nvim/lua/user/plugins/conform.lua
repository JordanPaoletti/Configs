return {
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
        opts = {
            formatters_by_ft = {
                bash = { "shfmt" },
                zsh = { "shfmt" },
                lua = { "stylua" },
                nix = { "nixfmt" },
                css = { "prettierd" },
                graphql = { "prettierd" },
                html = { "prettierd" },
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                vue = { "prettierd" },
                json = { "prettierd" },
                jsonc = { "prettierd" },
                yaml = { "prettierd" },
                go = { "gofmt" },
                python = { "black" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        }
    },
};
