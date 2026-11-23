-- Easy diff opener
vim.keymap.set("n", "<leader>dv",
    "<cmd>DiffviewOpen HEAD~1<cr>",
    { desc = "Open diffview with previous commit" })

vim.keymap.set("n", "<leader>df",
    "<cmd>DiffviewOpen<cr>",
    { desc = "Open diffview" })
