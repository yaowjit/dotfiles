---@type LazySpec
return {
    "NeogitOrg/neogit",
    version = "*",
    event = { "VeryLazy" },
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional - Diff integration
        -- Only one of these is needed, not both.
        -- "nvim-telescope/telescope.nvim", -- optional
        "ibhagwan/fzf-lua", -- optional
    },
    opts = {
        integrations = {
            diffview = true,
            fzf_lua = true,
        },
    },
}
