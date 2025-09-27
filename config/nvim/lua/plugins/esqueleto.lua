---@type LazySpec
return {
    "cvigilv/esqueleto.nvim",
    opts = {
        directories = {
            vim.fn.stdpath("config") .. "/templates",
        },
        patterns = function(dir)
            return vim.fn.readdir(dir)
        end,
    },
    config = function(_, opts)
        require("esqueleto").setup(opts)
        vim.cmd("command TemplateInsert EsqueletoInsert") -- create cmd alias
        vim.cmd("command TemplateNew EsqueletoNew")
    end,
}
