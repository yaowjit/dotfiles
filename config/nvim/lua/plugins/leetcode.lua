---@type LazySpec
return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    cmd = "Leet",
    opts = {
        lang = "cpp",
        cn = {
            enabled = true,
        },
        storage = {
            home = vim.fn.expand("~/.leetcode/code/"),
        },
        injector = { ---@type table<lc.lang, lc.inject>
            ["cpp"] = {
                imports = function()
                    return { "#include <bits/stdc++.h>", "using namespace std;" }
                end,
                after = { "int main() {", "   Solution solution;", "   return 0;", "}" },
            },
        },
    },
}
