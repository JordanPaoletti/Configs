return {

    {
        "Olical/conjure",
        ft = { "clojure", "fennel" },
        lazy = false,
        init = function()
            -- set config options here
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
