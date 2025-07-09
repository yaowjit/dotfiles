---@see http://www.lazyvim.org/extras/lang/clangd
---@see https://clangd.llvm.org/config
---@type vim.lsp.Config
return {
    cmd = {
        "clangd",
        "--malloc-trim",
        "--enable-config", -- load .clangd or ~/.config/clangd/config.yaml
        "-j=" .. OPT("clangd_jobs", 8),
        "--background-index",
        "--clang-tidy",
        "--function-arg-placeholders",
        "--offset-encoding=utf-16",
        unpack(OPT("clangd_extra_flags", {
            "--pch-storage=memory", -- memory/disk
            "--all-scopes-completion=true", -- true/false
            "--header-insertion=iwyu", -- iwyu/never
            "--completion-style=detailed", -- detailed/bundled
            "--header-insertion-decorators=true", -- true/false
        })),
    },
    capabilities = {
        offsetEncoding = { "utf-16" },
    },
    init_options = {
        compilationDatabasePath = OPT("clangd_db_path", ".vscode"),
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },
    settings = {
        clangd = {
            restartAfterCrash = true,
            onConfigChanged = "restart",
            serverCompletionRanking = true,
            semanticHighlighting = true,
        },
    },
}
