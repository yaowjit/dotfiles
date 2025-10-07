---@type LazySpec
return {
    "weissle/persistent-breakpoints.nvim",
    opts = {
        load_breakpoints_event = { "BufReadPost" },
        always_reload = true,
    },
    lazy = false,
    config = function(_, opts)
        require("persistent-breakpoints").setup(opts)
        -- dap configured filetypes
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "python", "c", "cpp" },
            callback = function(event)
                local keymap_opt = { buffer = event.buf }
                -- stylua: ignore start
                vim.keymap.set("n", "<2-LeftMouse>", function() require("persistent-breakpoints.api").toggle_breakpoint() end, keymap_opt)
                vim.api.nvim_buf_create_user_command(event.buf, "DapRunToCursor", function() require("dap").run_to_cursor() end, {})
                -- stylua: ignore end
            end,
        })
    end,
}
