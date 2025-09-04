---@type LazySpec
return {
    "folke/snacks.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
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
                    { icon = " ", key = "s", desc = "Session",      action = function() require("persistence").load({ last = true }) end, },
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
        scope = {
            enabled = true,
        },
        words = {
            enabled = true,
        },
    },
    keys = {
        -- stylua: ignore start
        { "<leader>q", function() Snacks.bufdelete() end, desc = "buf delete" },
        -- stylua: ignore end
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                vim.print = Snacks.debug.inspect
                _G.log = Snacks.debug.log

                local cmdparse = require("mega.cmdparse")
                local picker_parser = cmdparse.ParameterParser.new({ name = "Snacks", help = "" })
                local top_subparsers = picker_parser:add_subparsers({ destination = "commands" })
                for picker, picker_func in pairs(Snacks.picker) do
                    local subparser = top_subparsers:add_parser({ name = picker, help = "" })
                    subparser:set_execute(function(data)
                        picker_func()
                    end)
                end
                cmdparse.create_user_command(picker_parser)
            end,
        })
    end,
}
