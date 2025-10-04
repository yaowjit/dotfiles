---@type LazySpec
return {
    "ColinKennedy/mega.cmdparse",
    dependencies = { "ColinKennedy/mega.logging" },
    config = function(_, otps)
        vim.g.cmdparse_configuration = {
            cmdparse = {
                auto_complete = {
                    display = {
                        help_flag = false,
                    },
                },
            },
        }
    end,
}
