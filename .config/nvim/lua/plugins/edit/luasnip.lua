return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "honza/vim-snippets",
        "saadparwaiz1/cmp_luasnip",
    },
    event = { "InsertEnter" },
    config = function()
        require("luasnip").setup()
        -- load snippet folders in runtimeapth
        vim.opt.runtimepath:append(vim.fn.stdpath("config") .. "/my-snippets")
        -- snippets/<ft>.snippets and snippets/<ft>/*.snippets
        require("luasnip.loaders.from_snipmate").lazy_load()
        -- luasnippets/<ft>.lua and luasnippets/<ft>/*.lua
        require("luasnip.loaders.from_lua").lazy_load()
    end,
}