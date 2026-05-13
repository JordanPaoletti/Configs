return {

    {
        "Olical/conjure",
        ft = { "clojure", "fennel" },
        init = function()
            -- Restrict conjure to clojure/fennel only. Without this, conjure
            -- may attach clients (e.g. javascript) to buffers opened by other
            -- plugins like diffview, triggering errors.
            vim.g["conjure#filetypes"] = { "clojure", "fennel" }
        end,
        -- dependencies = { "PaterJason/cmp-conjure" },
    },
    -- {
    --     "PaterJason/cmp-conjure",
    --     lazy = true,
    --     config = function()
    --         local cmp = require("cmp")
    --         local config = cmp.get_config()
    --         table.insert(config.sources, { name = "conjure" })
    --         return cmp.setup(config)
    --     end
    -- },
}
