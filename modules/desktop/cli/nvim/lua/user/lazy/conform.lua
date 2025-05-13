require("conform").setup({
    formatters_by_ft = {
        bash = { "shfmt" },
        zsh = { "shfmt" },
        lua = { "stylua" },
        nix = { "nixfmt" },
    },
});
