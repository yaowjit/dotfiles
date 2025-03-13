---@param no string
local function lcode_submit(no)
    vim.system({ "lcode", "submit", no }, { text = true }, function(ret)
        Snacks.notify(ret.stdout)
    end)
end

---@param no string
local function lcode_test(no)
    vim.system({ "lcode", "test", no }, { text = true }, function(ret)
        Snacks.notify(ret.stdout)
    end)
end

vim.api.nvim_create_autocmd({ "BufRead" }, {
    pattern = vim.env.HOME .. "/.config/lcode/code/*",
    callback = function(args)
        local ft = vim.fn.fnamemodify(args.file, ":t:e")
        local no = vim.fn.fnamemodify(args.file, ":t:r")
        if ft == "py" or ft == "cpp" then
            local opts = { buffer = args.buf }
            vim.keymap.set("n", "<leader>ls", function()
                lcode_submit(no)
            end, opts)
            vim.keymap.set("n", "<leader>lt", function()
                lcode_test(no)
            end, opts)
            vim.api.nvim_buf_create_user_command(args.buf, "LcodeSubmit", function()
                lcode_submit(no)
            end, {})
            vim.api.nvim_buf_create_user_command(args.buf, "LcodeTest", function()
                lcode_test(no)
            end, {})
        end
    end,
})
