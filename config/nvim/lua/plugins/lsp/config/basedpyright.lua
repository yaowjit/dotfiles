return {
    settings = {
        python = {
            pythonPath = "python",
            -- venvPath = "",
        },
        basedpyright = {
            disableLanguageServices = false,
            disableOrganizeImports = true,
            disableTaggedHints = false,
            importStrategy = "fromEnvironment",
            analysis = {
                autoImportCompletions = false,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly", ---@type 'openFilesOnly'|'workspace'
                diagnosticSeverityOverrides = {},
                exclude = {},
                extraPaths = {},
                ignore = {},
                include = {},
                inlayHints = {
                    callArgumentNames = true,
                    functionReturnTypes = true,
                    genericTypes = false,
                    variableTypes = true,
                },
                logLevel = "Information",
                -- stubPath = "typings",
                typeCheckingMode = "basic", ---@type 'off'|'basic'|'standard'|'strict'|'recommended'|'all'
                typeshedPaths = {},
                useLibraryCodeForTypes = true,
            },
        },
    },
}
