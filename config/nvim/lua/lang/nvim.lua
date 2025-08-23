---@type LazySpec
return {
    "folke/lazydev.nvim",
    dependencies = {
        "Bilal2453/luvit-meta",
        -- "justinsgithub/wezterm-types",
    },
    version = "*",
    ft = { "lua" },
    cond = function()
        if vim.g.lazydev_enabled == true then
            return true
        end
        return vim.fs.root(0, ".luarc.json") ~= nil
    end,
    opts = {
        library = {
            "lazy.nvim",
            "luvit-meta/library",
            -- "nvim-xmake/library",
            -- { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
            { path = "wezterm-types", mods = { "wezterm" } }, -- put such files in local .lazy.lua file
        },
    },
}
