vim.cmd.source(vim.fn.stdpath("config") .. "/vimrc")

if vim.fn.has("nvim-0.11") ~= 1 then
    vim.notify("user config requires neovim >= 0.11")
    return
end

require("helper.lazy").setup({
    spec = {
        { import = "plugins" },
        { import = "lang" },
    },
})
