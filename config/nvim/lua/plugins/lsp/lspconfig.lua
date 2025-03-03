---@type LazySpec
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        -- stylua: ignore start
        { "<C-LeftMouse>", "<cmd>Lspsaga finder<CR>", desc = "preview definition" },
        { "gd", "<cmd>Lspsaga peek_definition<CR>", desc = "preview definition" },
        { "gh", "<cmd>Lspsaga finder<CR>", desc = "preview definition" },
        { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "show document" },

        { "gr", vim.lsp.buf.rename, desc = "reanme symbol" },
        -- { "gr", "<cmd>Lspsaga rename<CR>", desc = "reanme symbol" },
        { "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "diagnostics prev" },
        { "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "diagnostics next" },
        { "ga", vim.lsp.buf.code_action, desc = "code action" },
        -- stylua: ignore end
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
