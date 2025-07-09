---@see https://docs.basedpyright.com/latest/configuration/language-server-settings
---@type vim.lsp.Config
return {
    settings = {
        basedpyright = {
            analysis = {
                logLevel = "Information", ---@type 'Trace'|'Information'|'Warning'|'Error'
                diagnosticMode = "openFilesOnly", ---@type 'openFilesOnly'|'workspace'
                typeCheckingMode = "basic", ---@type 'off'|'basic'|'standard'|'strict'|'recommended'|'all'
                autoImportCompletions = false,
                inlayHints = {
                    callArgumentNames = true,
                    functionReturnTypes = true,
                    genericTypes = false,
                    variableTypes = true,
                },
            },
        },
    },
}
