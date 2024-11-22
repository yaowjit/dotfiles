_G.setup_dap({ "c", "cpp" }, {
    {
        type = "codelldb",
        name = "LLDB: Launch file",
        request = "launch",
        -- 编译输出目录在 cwd/build/,和asynctask中定义的一致
        program = "${workspaceFolder}/build/${fileBasenameNoExtension}",
        console = "integratedTerminal",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        runInTerminal = true,
    },
})

---@type LazySpec
return {
    -- "p00f/clangd_extensions.nvim",
    -- ft = { "c", "cpp" },
    -- opts = {
    --     inlay_hints = {
    --         inline = true,
    --         only_current_line = false,
    --     },
    -- },
}