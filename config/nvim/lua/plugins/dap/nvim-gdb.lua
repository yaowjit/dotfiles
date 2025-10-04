---@type LazySpec
return {
    -- TODO
    "sakhnik/nvim-gdb",
    config = function()
        vim.g.nvimgdb_disable_start_keymaps = true
        vim.keymap.set("c", "<C-e>", "<End>", { noremap = true }) -- override
    end,
}
