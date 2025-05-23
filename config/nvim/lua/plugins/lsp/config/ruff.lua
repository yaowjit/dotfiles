---@see https://github.com/astral-sh/ruff-lsp
---@type vim.lsp.Config
return {
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        },
    },
}
