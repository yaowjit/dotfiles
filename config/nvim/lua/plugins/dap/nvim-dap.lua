---@type LazySpec
return {
    "mfussenegger/nvim-dap",
    -- version = "*",
    -- lazy = false,
    event = { "VeryLazy" },
    config = function()
        local dap = require("dap")
        dap.adapters = require("plugins.dap.config.adapters")
        for ft, ft_config in pairs(require("plugins.dap.config.configurations")) do
            dap.configurations[ft] = ft_config
        end

        -- active dap session keymap
        DAP_IS_OPEN = false
        ---@param session Session
        local debug_open = function(session)
            DAP_IS_OPEN = true
            require("dapui").open()
            vim.keymap.set("n", "<leader><Down>", dap.continue, {})
            vim.keymap.set("n", "<Down>", dap.step_over, {})
            vim.keymap.set("n", "<Right>", dap.step_into, {})
            vim.keymap.set("n", "<Left>", dap.step_out, {})
            vim.keymap.set("n", "<Up>", dap.terminate, {})
        end
        ---@param session Session
        local debug_close = function(session)
            if DAP_IS_OPEN then
                require("dapui").close()
                vim.keymap.del("n", "<leader><Down>", {})
                vim.keymap.del("n", "<Down>", {})
                vim.keymap.del("n", "<Right>", {})
                vim.keymap.del("n", "<Left>", {})
                vim.keymap.del("n", "<Up>", {})
                if session.config.type == "codelldb" then -- 删除汇编buffer
                    local bufids = vim.api.nvim_list_bufs()
                    for _, bufnr in ipairs(bufids) do
                        if vim.bo[bufnr].filetype == "" and vim.bo[bufnr].buftype == "nofile" then
                            vim.api.nvim_buf_delete(bufnr, {})
                        end
                    end
                end
                DAP_IS_OPEN = false
            end
        end

        dap.listeners.after.event_initialized["dap_config"] = debug_open
        dap.listeners.after.event_terminated["dap_config"] = debug_close
        dap.listeners.after.event_exited["dap_config"] = debug_close
        dap.listeners.after.disconnect["dap_config"] = debug_close
    end,
    keys = {
        { "<F8>", "<cmd>DapContinue<CR>", desc = "start debug" },
        -- Shift-F8
        { "<F20>", "<cmd>DapTerminate<CR>", desc = "terminate debug" },
        { "<S-F8>", "<cmd>DapTerminate<CR>", desc = "terminate debug" },
    },
}
