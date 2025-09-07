vim.g.autoformat = true
vim.g.editorconfig = true
vim.g.enable_endhints = true

-- cpp projects
vim.g.dap_cpp_exec_filter = nil
vim.g.dap_cpp_exec_dir = "build"

vim.g.clangd_flags = {
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
    "--all-scopes-completion=true", -- true/false
    "--completion-style=detailed", -- detailed/bundled
    "--header-insertion=iwyu", -- iwyu/never
    "--header-insertion-decorators=true", -- true/false
    "--function-arg-placeholders",
    -- log and output
    "--log=info", -- error/info/verbose
    "--pretty",
}
vim.g.clangd_fallback_flags = {
    "-std=c++17",
}

return {}
