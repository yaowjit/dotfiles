---@type LazySpec
return {
    "stevearc/overseer.nvim",
    -- version = "*",
    dependencies = { "ColinKennedy/mega.cmdparse" },
    event = { "VeryLazy" },
    opts = {
        strategy = "terminal",
        -- strategy = "toggleterm",
        template_dirs = { "overseer.template" },
        templates = { "builtin" },
        task_list = {
            min_width = { 50, 0.3 },
            bindings = {
                ["<C-l>"] = false,
                ["<C-h>"] = false,
                ["<C-k>"] = false,
                ["<C-j>"] = false,
                ["["] = "PrevTask",
                ["]"] = "NextTask",
                ["{"] = false,
                ["}"] = false,

                ["<C-s>"] = false,
                ["<C-x>"] = "OpenSplit",
                ["<C-v>"] = "OpenVsplit",
            },
        },
    },
    keys = {
        { "<C-b>", "<cmd>OverseerRun<CR>", desc = "OverseerRun" },
    },
}
