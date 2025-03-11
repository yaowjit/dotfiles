---@type LazySpec
return {
    "folke/snacks.nvim",
    opts = function(_, opts)
        opts.picker = {
            enabled = true,
            sources = {},
        }
        return opts
    end,
    keys = function(_, keys)
        vim.list_extend(keys, {
            -- stylua: ignore start
            { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
            { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>f/", function() Snacks.picker() end, desc = "Snacks pickers" },

            { "<leader>ff", function() Snacks.picker.files() end, desc = "files" },
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "buffers" },
            { "<leader>fl", function() Snacks.picker.grep_buffers() end, desc = "grep buffers" },
            { "<C-f>",      function() Snacks.picker.lines() end, desc = "current buffer lines" },
            { "<leader>fL", function() Snacks.picker.grep() end, desc = "grep" },
            { "<leader>fj", function() Snacks.picker.jumps() end, desc = "jumps" },
            { "<leader>fh", function() Snacks.picker.help() end, desc = "help" },
            { "<leader>fH", function() Snacks.picker.highlights() end, desc = "highlights" },
            { "<leader>fm", function() Snacks.picker.recent() end, desc = "recent" },
            { "<leader>fc", function() Snacks.picker.commands() end, desc = "commands" },
            { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "keymaps" },
            { "<leader>fq", function() Snacks.picker.qflist() end, desc = "qflist" },
            { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "cword" },

            -- git
            { "<leader>fg", function() Snacks.picker.git_status() end, desc = "git status" },

            -- lsp
            { "<leader>fd", function() Snacks.picker.lsp_definitions() end, desc = "lsp_definitions" },
            { "<leader>fD", function() Snacks.picker.lsp_type_definitions() end, desc = "lsp_type_definitions" },
            { "<leader>fr", function() Snacks.picker.lsp_references() end, desc = "lsp_references" },
            { "<leader>fi", function() Snacks.picker.lsp_implementations() end, desc = "lsp_implementations" },
            { "<leader>fF", function() Snacks.picker.lsp_symbols({
                filter = {
                    default = { "Class", "Constructor", "Function", "Method" }
                },
                workspace = true,
            }) end, desc = "Class/Function like symbols" },
            { "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "lsp_symbols" },
            { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "lsp_workspace_symbols" },
            -- stylua: ignore end
        })
        return keys
    end,
}
