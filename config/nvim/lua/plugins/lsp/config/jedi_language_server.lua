---@source https://github.com/pappasam/jedi-language-server
---@type vim.lsp.Config
return {
    init_options = {
        completion = {
            ignorePatterns = {
                --
            },
        },
        jediSettings = {
            autoImportModules = { "numpy", "torch", "pandas", "matplotlib" },
            caseInsensitiveCompletion = true,
            debug = false,
        },
        semanticTokens = {
            enable = true,
        },
    },
}
