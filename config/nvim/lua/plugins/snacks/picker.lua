local pickers_config = {
    lsp_symbols = {
        filter = {
            default = { "Class", "Constructor", "Function", "Method" },
        },
        workspace = false,
    },
}

vim.api.nvim_create_user_command("Snacks", function(args)
    local snacks_pickers = vim.tbl_keys(Snacks.picker)
    local picker = args.args:match("[%w_]+")

    if vim.tbl_contains(snacks_pickers, picker, {}) then
        Snacks.picker[picker](pickers_config[picker] or {})
    else
        vim.notify("unsupported Snacks picker")
    end
end, {
    nargs = 1,
    complete = function(argLead, cmdline, cursorPos)
        local args = vim.split(cmdline, " ", { trimempty = true })
        return (#args == 1) and vim.tbl_keys(Snacks.picker) or {}
    end,
})

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
            { "<leader>fs", function() Snacks.picker.lsp_symbols(pickers_config.lsp_symbols) end, desc = "lsp_symbols" },
            { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "lsp_workspace_symbols" },
            -- stylua: ignore end
        })
        return keys
    end,
}
