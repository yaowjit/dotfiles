_G.inspect = function(...)
    Snacks.debug.inspect(...)
end
vim.print = _G.inspect
_G.log = function(...)
    Snacks.debug.log(...)
end

---@type LazySpec
return {
    "folke/snacks.nvim",
    version = "*",
    priority = 999, -- after than colorscheme plugin
    lazy = false,
    opts = {
        dashboard = {
            enabled = true,
            width = 50,
            preset = {
                keys = {
                    -- stylua: ignore start
                    { icon = " ", key = "f", desc = "Find File",    action = function() Snacks.picker.files() end },
                    { icon = " ", key = "e", desc = "New File",     action = ":ene | startinsert" },
                    { icon = " ", key = "l", desc = "Find Text",    action = function() Snacks.picker.grep() end },
                    { icon = " ", key = "m", desc = "Recent Files", action = function() Snacks.picker.recent() end,                              },
                    { icon = " ", key = "c", desc = "Config",       action = function() Snacks.picker.files({cwd=vim.fn.stdpath("config")}) end, },
                    { icon = " ", key = "q", desc = "Quit",         action = ":qa" },
                    -- stylua: ignore end
                },
            },
            sections = {
                { section = "header" },
                { section = "keys", indent = 2, padding = 1, gap = 1 },
                { section = "startup" },
            },
        },
        notifier = {
            enabled = true,
            style = "minimal",
        },
        bigfile = {
            enabled = true,
            size = 2 * 1024 * 1024, -- 2MiB
        },
        quickfile = {
            enabled = true,
            exclude = { "latex" },
        },
        indent = {
            enabled = true,
            animate = {
                enabled = false,
            },
            scope = {
                enabled = true,
                underline = false,
            },
            chunk = {
                enabled = false,
            },
        },
        input = {
            enabled = true,
            win = {
                style = {
                    relative = "cursor",
                    title_pos = "left",
                },
            },
        },
        statuscolumn = {
            enabled = true,
        },
    },
    keys = {
        -- stylua: ignore start
        { "<leader>q", function() Snacks.bufdelete() end, desc = "buf delete" },
        -- stylua: ignore end
    },
}
