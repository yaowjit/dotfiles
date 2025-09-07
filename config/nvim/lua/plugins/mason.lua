---@type LazySpec
return {
    "williamboman/mason.nvim",
    build = function()
        local plugin_path = vim.fn.stdpath("data") .. "/lazy/mason.nvim/"
        vim.opt.runtimepath:prepend(plugin_path)
        require("mason").setup()
        local registry = require("mason-registry")
        local ensure_installed = {
            "clangd",
            "clang-format",
            "basedpyright",
            "ruff",
            "gitui",
        }
        for _, pkg in ipairs(ensure_installed) do
            if not registry.is_installed(pkg) then
                vim.cmd("MasonInstall " .. pkg)
            end
        end
    end,
    config = true,
}
