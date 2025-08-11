---@type LazySpec
return {
    -- TODO
    "sakhnik/nvim-gdb",
    event = { "VeryLazy" },
    config = function()
        vim.g.nvimgdb_disable_start_keymaps = true
    end,
}
