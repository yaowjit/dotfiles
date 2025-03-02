---@type LazySpec
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    -- lazy = false,
    keys = {
        { "gr", vim.lsp.buf.rename, desc = "reanme symbol" },
        { "[d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "diagnostics prev" },
        { "]d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "diagnostics next" },
        { "ga", vim.lsp.buf.code_action, desc = "code action" },
        -- { "K", vim.lsp.buf.hover, desc = "show document" },
        -- { "<C-LeftMouse>", vim.lsp.buf.definition, desc = "definition" },
        -- { "gd", vim.lsp.buf.definition, desc = "definition" },
    },
    config = function()
        local servers = require("plugins.lsp.config.servers")
        local lspconfig = require("lspconfig")
        local cmp_capabilities = require("blink.cmp").get_lsp_capabilities()
        for server, config in pairs(servers) do
            -- capabilities
            if config.capabilities ~= nil then
                config.capabilities = vim.tbl_deep_extend("force", config.capabilities, cmp_capabilities)
            else
                config.capabilities = cmp_capabilities
            end

            lspconfig[server].setup(config)
        end
    end,
}
