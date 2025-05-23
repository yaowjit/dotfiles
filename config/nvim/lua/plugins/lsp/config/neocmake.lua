---@see https://github.com/neocmakelsp/neocmakelsp
---@type vim.lsp.Config
return {
    init_options = {
        format = {
            enable = true,
        },
        lint = {
            enable = true,
        },
        scan_cmake_in_package = true, -- default is true
    },
}
