-- https://github.com/folke/lazy.nvim#-plugin-spec
require("lazy").setup({
    -- movement
    {
        "easymotion/vim-easymotion",
        lazy = false
    },

    -- treesitter
    {
        -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nushell/tree-sitter-nu",
        },
        build = ":TSUpdate",
        keys = {
            {
                "[C",
                function()
                    require("treesitter-context").go_to_context(vim.v.count1)
                end,
                silent = true,
            },
        },
        lazy = false,
        opts = {
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    node_incremental = "v",
                    node_decremental = "V",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>a"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>A"] = "@parameter.inner",
                    },
                },
            },
        },
        config = function(_, opts)
            local configs = require("nvim-treesitter.configs").setup(opts)
            require("treesitter-context").setup({
                max_lines = 10,
                multiline_threshold = 1,
                -- mode = "topline",
            })

            -- There are additional nvim-treesitter modules that you can use to interact
            -- with nvim-treesitter. You should go explore a few and see what interests you:
            --
            --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
            --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
            --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        end,
    },

    -- LSPs
    -- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
    {
        "neovim/nvim-lspconfig",
        name = "lspconfig.lua_ls",
        ft = { "lua" },
        opts = {},
        config = function(_, opts)
            require("lspconfig").lua_ls.setup(opts)
        end,
    },
    {
        "neovim/nvim-lspconfig",
        name = "lspconfig.nil_ls",
        ft = { "nix" },
        opts = {},
        config = function(_, opts)
            require("lspconfig").nil_ls.setup(opts)
        end,
    },
    {
        "neovim/nvim-lspconfig",
        name = "lspconfig.nixd",
        ft = { "nix" },
        opts = {},
        config = function(_, opts)
            require("lspconfig").nixd.setup(opts)
        end,
    },

    -- Diagnostics
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
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
        config = function() require("user.lazy.conform") end,
    },
})

