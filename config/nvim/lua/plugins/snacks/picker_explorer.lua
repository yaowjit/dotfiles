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
                        --
                    },
                },
            },
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
            { "<leader>e", function() Snacks.picker.explorer() end, desc = "Snacks explorer" },
            -- stylua: ignore end
        })
        return keys
    end,
}
