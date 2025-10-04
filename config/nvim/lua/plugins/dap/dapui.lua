local dapui_opts = {
    controls = {
        element = "scopes",
        -- element = "console",
        -- element = "repl",
    },
    mappings = {
        expand = { "o", "<2-LeftMouse>", "<CR>" },
        open = "O",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    force_buffers = true,
    layouts = {
        {
            elements = {
                -- Can be float or integer > 1
                -- 从下往上排列的
                { id = "stacks", size = 0.4 },
                { id = "watches", size = 0.3 },
                { id = "breakpoints", size = 0.3 },
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                { id = "scopes", size = 0.5 },
                { id = "console", size = 0.5 },
                -- { id = "repl", size = 0.2 },
            },
            size = 20,
            position = "bottom",
        },
    },
    render = {
        indent = 2,
    },
}

---@type LazySpec
return {
    "rcarriga/nvim-dap-ui",
    version = "*",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
    },
    event = { "VeryLazy" },
    opts = dapui_opts,
}
