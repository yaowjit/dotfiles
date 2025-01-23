---@type LazySpec
return {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    -- version = "*",
    opts = {
        current_line_blame = true,
        -- yadm = { enable = true },
        -- worktrees = {},
        -- keymapping
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local keymap = function(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end
            -- open lazygit and gitui with toggleterm
            -- <leader>gl LazyGit
            -- <leader>gg GitUI

            -- stylua: ignore start
            keymap("n", "gj", function() gitsigns.nav_hunk("next") end)
            keymap("n", "gk", function () gitsigns.nav_hunk("prev") end)
            keymap("n", "<leader>gj", function() gitsigns.nav_hunk("next") end)
            keymap("n", "<leader>gk", function () gitsigns.nav_hunk("prev") end)
            keymap("n", "<leader>gp", gitsigns.preview_hunk)

            keymap("n", "<leader>gd", gitsigns.diffthis)
            keymap("n", "<leader>gs", gitsigns.stage_hunk)
            keymap("n", "<leader>gr", gitsigns.reset_hunk)
            keymap("n", "<leader>gS", gitsigns.stage_buffer)
            keymap("n", "<leader>gR", gitsigns.reset_buffer)

            keymap({ "o", "x" }, "ih", gitsigns.select_hunk)
            keymap({ "o", "x" }, "ah", gitsigns.select_hunk)
            -- stylua: ignore end
        end,
    },
}
