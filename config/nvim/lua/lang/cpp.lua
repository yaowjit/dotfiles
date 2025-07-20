vim.g.dap_cpp_exec_filter = nil
vim.g.dap_cpp_exec_dir = "build"

vim.g.clangd_jobs = 8
vim.g.clangd_db_path = ".vscode"
vim.g.clangd_extra_flags = {
    "--pch-storage=memory", -- memory/disk
    "--all-scopes-completion=true", -- true/false
    "--header-insertion=iwyu", -- iwyu/never
    "--completion-style=detailed", -- detailed/bundled
    "--header-insertion-decorators=true", -- true/false
}

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "cpp", "c" },
    callback = function(file)
        vim.keymap.set("n", "<leader>R", "<cmd>ClangdSwitchSourceHeader<CR>", { noremap = true, buffer = file.buf })
    end,
})

---@type LazySpec
return {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    opts = {
        inline = true,
        show_parameter_hints = true,
    },
}
