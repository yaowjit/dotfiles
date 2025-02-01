-- vim:foldmethod=marker:

vim.g.autoformat = true

vim.cmd([[
    command! -nargs=0 BufEnableAutoFormat  let b:autoformat=v:true
    command! -nargs=0 BufDisableAutoFormat let b:autoformat=v:false
    command! -nargs=0 EnableAutoFormat     let g:autoformat=v:true
    command! -nargs=0 DisableAutoFormat    let g:autoformat=v:false
]])

---@type LazySpec
return {
    "stevearc/conform.nvim",
    version = "*",
    opts = {
        ---@type table<string, conform.FormatterConfigOverride|fun(bufnr:integer):nil|conform.FormatterConfigOverride>
        formatters = { --{{{
            latexindent = {
                append_args = { "-g", "/dev/null" },
            },
            ruff_isort = {
                command = vim.fn.exepath("ruff"),
                args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME" },
            },
        }, --}}}
        ---@type table<string, conform.FiletypeFormatter>
        formatters_by_ft = { --{{{
            ["_"] = { "trim_whitespace", "trim_newlines" },
            python = { "ruff_isort", "ruff_format" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            lua = { "stylua" },
            rust = { "rustfmt" },
            sh = { "shfmt" },
            bash = { "shfmt" },
            tex = { "latexindent" },
            json5 = { "prettierd", "jq", stop_after_first = true },
            json = { "prettierd", "jq", stop_after_first = true },
            -- prettierd
            markdown = { "prettierd" },
            yaml = { "prettierd" },
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            jsx = { "prettierd" },
            vue = { "prettierd" },
            html = { "prettierd" },
            css = { "prettierd" },
        }, --}}}
        format_on_save = function(bufnr)
            ---------- g:true  g:valse
            -- nil                 x
            --b:true
            --b:false    x         x
            if
                vim.bo.readonly --
                or vim.b.autoformat == false
                or (vim.g.autoformat == false and vim.b.autoformat == nil)
            then
                return
            end

            local cbopts = { timeout_ms = 1000, lsp_fallback = false }
            if _G.pathlib.is_hugefile("1m", bufnr) or vim.fn.line("$") > 1000 then
                cbopts.timeout_ms = 2000
            end

            return cbopts
        end,
    },
    config = function(_, opts)
        require("conform").setup(opts)
        vim.api.nvim_create_user_command("Format", require("conform").format, { desc = "Format with conform" })
    end,
}
