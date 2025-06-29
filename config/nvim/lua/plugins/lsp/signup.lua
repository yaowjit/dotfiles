---@type LazySpec
return {
    "Dan7h3x/signup.nvim",
    branch = "main",
    event = { "LspAttach" },
    opts = {
        floating_window_above_cur_line = false,
        dock_mode = {
            enabled = true,
            position = "top",
        },
    },
}
