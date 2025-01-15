return {
    cmd = {
        "clangd",
        "--enable-config", -- load .clangd or ~/.config/clangd/config.yaml
        "-j=" .. OPT("clangd_jobs", 8),
        "--background-index",
        "--clang-tidy",
        "--function-arg-placeholders",
        "--offset-encoding=utf-8",
        unpack(OPT("clangd_extra_flags", {
            "--pch-storage=memory", -- memory/disk
            "--all-scopes-completion=true", -- true/false
            "--header-insertion=iwyu", -- iwyu/never
            "--completion-style=detailed", -- detailed/bundled
            "--header-insertion-decorators=true", -- true/false
        })),
    },
    capabilities = {
        offsetEncoding = { "utf-8" },
    },
    -- on_attach = function(client, bufnr)
    --     -- require("clangd_extensions.inlay_hints").setup_autocmd()
    --     -- require("clangd_extensions.inlay_hints").set_inlay_hints()
    -- end,
    init_options = {
        compilationDatabasePath = OPT("clangd_db_path", ".vscode"),
        fallbackFlags = {
            "-std=c++17",
        },
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },
    settings = {
        clangd = {
            -- compilationDatabaseChanges = {},
            checkUpdates = false,
            detectExtensionConflicts = true,
            enable = true,
            enableCodeCompletion = true,
            enableHover = true,
            inactiveRegions = {
                opacity = 0.55,
                useBackgroundHighlight = false,
            },
            onConfigChanged = "prompt",
            path = "clangd",
            restartAfterCrash = true,
            semanticHighlighting = true,
            serverCompletionRanking = true,
            -- trace
            InlayHints = {
                Enabled = true,
                Designators = true,
                ParameterNames = true,
                DeducedTypes = true,
            },
        },
    },
}
