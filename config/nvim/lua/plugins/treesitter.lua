---@type LazySpec
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            vim.api.nvim_create_user_command("TSEnsureInstall", function()
                require("nvim-treesitter").install({
                    "c",
                    "cpp",
                    "python",
                    "bash",
                    "lua",
                    "vim",
                    "vimdoc",
                    "markdown",
                    "markdown_inline",
                })
            end, {})

            vim.api.nvim_create_autocmd("FileType", {
                pattern = require("nvim-treesitter").get_installed(),
                callback = function()
                    vim.treesitter.start()
                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        lazy = false,
        opts = {},
        config = function(_, opts)
            require("nvim-treesitter-textobjects").setup(opts)
            local ts_select = require("nvim-treesitter-textobjects.select")
            local ts_swap = require("nvim-treesitter-textobjects.swap")
            local ts_move = require("nvim-treesitter-textobjects.move")
            local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
            local keymap = vim.keymap.set
            -- stylua: ignore start
            keymap({ "x", "o" }, "af", function() ts_select.select_textobject("@function.outer", "textobjects") end)
            keymap({ "x", "o" }, "if", function() ts_select.select_textobject("@function.inner", "textobjects") end)
            keymap({ "x", "o" }, "ac", function() ts_select.select_textobject("@class.outer", "textobjects") end)
            keymap({ "x", "o" }, "ic", function() ts_select.select_textobject("@class.inner", "textobjects") end)

            keymap("n", "<leader>,", function() ts_swap.swap_previous("@parameter.inner") end)
            keymap("n", "<leader>.", function() ts_swap.swap_next("@parameter.inner") end)

            keymap({ "n", "x", "o" }, "[f", function() ts_move.goto_previous_start("@function.outer", "textobjects") end)
            keymap({ "n", "x", "o" }, "]f", function() ts_move.goto_next_start("@function.outer", "textobjects") end)
            keymap({ "n", "x", "o" }, "[c", function() ts_move.goto_previous_start("@class.outer", "textobjects") end)
            keymap({ "n", "x", "o" }, "]c", function() ts_move.goto_next_start("@class.outer", "textobjects") end)
            -- stylua: ignore end
        end,
    },
}
