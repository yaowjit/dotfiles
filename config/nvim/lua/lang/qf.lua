---@type LazySpec
return {
    {
        "kevinhwang91/nvim-bqf",
        ft = { "qf" },
        init = function()
            vim.cmd([[
                hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
                hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
                hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
                hi link BqfPreviewRange Search
            ]])
            -- cfilter is very powerfull
            vim.cmd("packadd cfilter")
        end,
        opts = {
            show_title = true,
            filter = {
                fzf = {
                    extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
                },
            },
        },
    },
    {
        "stevearc/quicker.nvim",
        ft = { "qf" },
        opts = {
            opts = {},
        },
    },
}
