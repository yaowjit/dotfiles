---@type LazySpec
return {
    "echasnovski/mini.nvim",
    version = "*",
    event = { "VeryLazy" },
    opts = {
        -- sub-plug: opts
        align = {
            mappings = {
                start = "<leader>a",
                start_with_preview = "<leader>A",
            },
        },
        cursorword = { delay = 100 },
        move = {
            mappings = {
                line_left = "", -- disable in normal mode
                line_right = "",
                line_down = "",
                line_up = "",
            },
        }, -- M+hjkl
        splitjoin = {}, -- gS
    },
    config = function(_, opts)
        for plug, opt in pairs(opts) do
            require("mini." .. plug).setup(opt)
        end
        require("mini.icons").get = nil
    end,
}
