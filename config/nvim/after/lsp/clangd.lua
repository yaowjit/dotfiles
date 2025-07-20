---@see http://www.lazyvim.org/extras/lang/clangd
---@see https://clangd.llvm.org/config
---@type vim.lsp.Config
return {
    cmd = {
        "clangd",
        -- unpack(vim.g.clangd_flags or {}),
        unpack(OPT("clangd_flags", {
            "-j=8",
            "--background-index",
            "--background-index-priority=low", -- background/low/normal
            "--pch-storage=memory", -- memory/disk
            -- "--malloc-trim",
            --
            "--query-driver=/usr/bin/**/clang++*,/usr/bin/**/g++*",
            "--compile-commands-dir=.vscode", -- fallback to ./ and parent paths of each source file
            --
            -- "--experimental-modules-suppor", -- Experimental support for standard c++ module
            "--enable-config", -- load .clangd or ~/.config/clangd/config.yaml
            "--clang-tidy",
            -- lsp service
            "--offset-encoding=utf-16", -- utf-8/utf-16/utf-32
            "--all-scopes-completion=true", -- true/false
            "--completion-style=detailed", -- detailed/bundled
            "--header-insertion=iwyu", -- iwyu/never
            "--header-insertion-decorators=true", -- true/false
            "--function-arg-placeholders",
            -- log and output
            "--log=info", -- error/info/verbose
            "--pretty",
        })),
    },
    capabilities = {
        offsetEncoding = { "utf-16" },
    },
    init_options = {
        fallbackFlags = OPT("clangd_fallback_flags", {
            "-std=c++17",
        }),
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
