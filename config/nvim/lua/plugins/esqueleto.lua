---@type LazySpec
return {
    "cvigilv/esqueleto.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
        directories = {
            vim.fn.stdpath("config") .. "/templates",
        },
        patterns = function(dir)
            return vim.fn.readdir(dir)
        end,
    },
}
