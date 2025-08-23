---@type LazySpec
return {
    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach",
    cond = function()
        return OPT("enable_endhints", true)
    end,
    opts = {}, -- required, even if empty
    config = function(_, opts)
        require("lsp-endhints").setup(opts)
        vim.api.nvim_create_user_command("LspEnableHints", require("lsp-endhints").enable, {})
        vim.api.nvim_create_user_command("LspDisableHints", require("lsp-endhints").disable, {})
        vim.api.nvim_create_user_command("LspToggleHints", require("lsp-endhints").toggle, {})
    end,
}
