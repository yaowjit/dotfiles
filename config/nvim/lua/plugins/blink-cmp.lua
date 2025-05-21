---@type LazySpec
return {
    "Saghen/blink.cmp",
    version = "*",
    dependencies = {
        "L3MON4D3/LuaSnip",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
        keymap = {
            preset = "enter",
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            -- ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "accept_and_enter", "fallback" },
            --
            ["<C-j>"] = { "snippet_forward", "fallback" },
            ["<C-k>"] = { "snippet_backward", "fallback" },
            --
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            -- custom
            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            ["<C-f>"] = {},
            ["<C-b>"] = {},
        },
        snippets = {
            preset = "luasnip",
            expand = function(snippet)
                require("luasnip").lsp_expand(snippet)
            end,
            active = function(filter)
                if filter and filter.direction then
                    return require("luasnip").jumpable(filter.direction)
                end
                return require("luasnip").in_snippet()
            end,
            jump = function(direction)
                require("luasnip").jump(direction)
            end,
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            min_keyword_length = 0,
            providers = {
                lsp = {
                    score_offset = 3,
                    fallbacks = {}, -- defaults to `{ 'buffer' }`
                },
                buffer = {
                    opts = {
                        get_bufnrs = function()
                            return vim.tbl_filter(function(bufnr)
                                return vim.bo[bufnr].buftype == ""
                            end, vim.api.nvim_list_bufs())
                        end,
                    },
                    async = false,
                    min_keyword_length = 1,
                },
            },
        },
        fuzzy = {
            implementation = "prefer_rust_with_warning",
            sorts = {
                "score",
                "label",
                "sort_text",
            },
        },
        completion = {
            trigger = {
                show_in_snippet = false,
            },
            accept = {
                auto_brackets = {
                    enabled = true,
                    override_brackets_for_filetypes = {
                        tex = { "{", "}" },
                    },
                },
            },
            menu = {
                draw = {
                    treesitter = { "lsp" },
                    columns = {
                        -- { "kind_icon" },
                        { "label", "label_description", gap = 1 },
                        { "source_name" },
                    },
                },
            },
            documentation = {
                auto_show = true,
            },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = true,
                },
            },
            ghost_text = {
                enabled = false,
            },
        },
        signature = {
            enabled = true,
        },
    },
}
