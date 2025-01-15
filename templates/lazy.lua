vim.g.autoformat = true
vim.g.editorconfig = true
vim.g.enable_endhints = true

-- cpp projects
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

return {}
