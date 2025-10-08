---@type LazySpec
return {
    "folke/snacks.nvim",
    opts = function(_, opts)
        opts.explorer = {
            enabled = true,
        }
        opts.picker.sources.explorer = {
            win = {
                list = {
                    keys = {
                        ["o"] = "confirm",
                        ["O"] = "explorer_open", -- open with system application

                        -- fs
                        ["a"] = "explorer_add",
                        ["c"] = "explorer_copy",
                        ["x"] = "explorer_move",
                        ["v"] = "explorer_paste",
                        ["d"] = "explorer_del",
                        ["r"] = "explorer_rename",
                        ["y"] = { "explorer_yank", mode = { "n", "x" } },

                        -- change node
                        ["H"] = "explorer_up",
                        ["[g"] = "explorer_git_prev",
                        ["]g"] = "explorer_git_next",

                        -- view
                        ["."] = "toggle_hidden",
                        ["I"] = "toggle_ignored",
                        ["P"] = "toggle_preview",
                    },
                },
            },
            jump = { close = true },
            layout = { preview = true },
            include = {
                ".vscode",
            },
            exclude = {
                "__pycache__",
                "*.o",
                "*.ko",
            },
        }
        return opts
    end,
    keys = function(_, keys)
        vim.list_extend(keys, {
            -- stylua: ignore start
            { "<leader>E", function() Snacks.picker.explorer() end, desc = "Snacks explorer" },
            -- stylua: ignore end
        })
        return keys
    end,
}
