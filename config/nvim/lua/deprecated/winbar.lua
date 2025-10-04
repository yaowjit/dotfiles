---@type LazySpec
return {
    "fgheng/winbar.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = {
        enabled = true,
        show_file_path = true,
        show_symbols = true,
    },
}
