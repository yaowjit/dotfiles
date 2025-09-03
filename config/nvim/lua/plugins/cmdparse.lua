---@type LazySpec
return {
    "ColinKennedy/mega.cmdparse",
    dependencies = { "ColinKennedy/mega.logging" },
    event = { "VeryLazy" },
    opts = {},
    config = function(_, otps)
        vim.g.cmdparse_configuration = {}
    end,
}
