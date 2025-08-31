local servers = {}

for fname, t in vim.fs.dir("~/.config/nvim/after/lsp/") do
    local server_name = fname:match("(.*)%.lua$")
    table.insert(servers, server_name)
end

---@type LazySpec
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        {
            "<C-LeftMouse>",
            function()
                vim.lsp.buf.definition({ reuse_win = true })
            end,
            desc = "goto definition",
        },
        {
            "gd",
            function()
                vim.lsp.buf.definition({ reuse_win = true })
            end,
            desc = "goto definition",
        },
        {
            "gi",
            function()
                vim.lsp.buf.implementation({ reuse_win = true })
            end,
            desc = "goto implementation",
        },
        {
            "gt",
            function()
                vim.lsp.buf.type_definition({ reuse_win = true })
            end,
            desc = "goto type definition",
        },
        { "gh", "<cmd>Trouble lsp<CR>", desc = "preview definition/references/..." },
        { "K", vim.lsp.buf.hover, desc = "show document" },

        { "gr", vim.lsp.buf.rename, desc = "reanme symbol" },
        {
            "[d",
            function()
                vim.diagnostic.jump({ count = -1, float = true })
            end,
            desc = "diagnostics prev",
        },
        {
            "]d",
            function()
                vim.diagnostic.jump({ count = 1, float = true })
            end,
            desc = "diagnostics next",
        },
        { "ga", vim.lsp.buf.code_action, desc = "code action" },
    },
    config = function()
        vim.lsp.config("*", {
            capabilities = require("blink-cmp").get_lsp_capabilities({
                -- 有些lsp会忽略 snippetSupport 需要在lsp server中单独设置
                textDocument = { completion = { completionItem = { snippetSupport = false } } },
            }),
        })
        for _, server_name in ipairs(servers) do
            vim.lsp.config(server_name, {})
            vim.lsp.enable(server_name)
        end
    end,
}
