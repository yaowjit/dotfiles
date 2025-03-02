---@type LazySpec
return {
    "nvimdev/lspsaga.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    event = { "LspAttach" },
    -- keys moved to lspconfig
    opts = {
        symbol_in_winbar = {
            enable = false,
        },
        finder = {
            keys = {
                shuttle = "[w",
                toggle_or_open = "o",
                split = "<C-x>",
                vsplit = "<C-v>",
                tabe = "<C-t>",
                quit = "q",
                close = "<C-c>k",
            },
        },
        definition = {
            keys = {
                edit = "<CR>",
                split = "<C-x>",
                vsplit = "<C-v>",
                tabe = "<C-t>",
                quit = "q",
                close = "<C-c>k",
            },
        },
        callhierarchy = {
            keys = {
                edit = "<CR>",
                shuttle = "[w",
                split = "<C-x>",
                vsplit = "<C-v>",
                tabe = "<C-t>",
                quit = "q",
            },
        },
        lightbulb = {
            enable = false,
        },
        ui = {
            border = "single",
        },
    },
}
