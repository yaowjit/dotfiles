---@type LazySpec
return {
    "weissle/persistent-breakpoints.nvim",
    opts = {
        load_breakpoints_event = { "BufReadPost" },
        always_reload = true,
    },
    lazy = false,
    config = function(_, otps)
        require("persistent-breakpoints").setup(opts)
        -- dap configured filetypes
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "python", "c", "cpp" },
            callback = function(event)
                local opt = { buffer = event.buf }
                -- vim.keymap.set("n", "<leader>b", require("persistent-breakpoints.api").toggle_breakpoint, opt)
                vim.keymap.set("n", "<2-LeftMouse>", require("persistent-breakpoints.api").toggle_breakpoint, opt)
                vim.api.nvim_buf_create_user_command(event.buf, "DapRunToCursor", function()
                    require("dap").run_to_cursor()
                end, {})
            end,
        })
    end,
}
