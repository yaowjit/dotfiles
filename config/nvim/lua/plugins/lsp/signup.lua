---@type LazySpec
return {
    "Dan7h3x/signup.nvim",
    branch = "main",
    event = { "LspAttach" },
    opts = {
        floating_window_above_cur_line = false,
        max_height = 10,
        max_width = 100,
        dock_toggle_key = "<Leader>sd",
        dock_mode = {
            enabled = true,
            position = "top",
            height = 20,
        },
    },
}
