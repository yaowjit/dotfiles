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
        vim.lsp.config("*", {
            capabilities = require("blink-cmp").get_lsp_capabilities(),
        })
        for _, server_name in ipairs(servers) do
            vim.lsp.config(server_name, {})
            vim.lsp.enable(server_name)
        end
    end,
}
