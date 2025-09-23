---@type LazySpec
return {
    "Saghen/blink.cmp",
    version = "*",
    dependencies = {
        "L3MON4D3/LuaSnip",
        { "Kaiser-Yang/blink-cmp-dictionary", dependencies = { "nvim-lua/plenary.nvim" } },
        { "mikavilpas/blink-ripgrep.nvim", version = "*" },
    },
    event = { "InsertEnter", "CmdlineEnter" },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "enter",
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "select_and_accept", "fallback" },
            --
            ["<Tab>"] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.accept()
                    else
                        return cmp.select_and_accept()
                    end
                end,
                "snippet_forward",
                "fallback",
            },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
            --
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            -- custom
            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            ["<C-f>"] = false,
            ["<C-b>"] = false,
        },
        cmdline = {
            keymap = {
                preset = "cmdline",
                ["<CR>"] = { "accept", "fallback" },
            },
            completion = {
                menu = {
                    auto_show = true,
                },
            },
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
            default = {
                "lsp",
                "path",
                "snippets",
                "buffer",
                "dictionary",
                "ripgrep",
            },
            min_keyword_length = 0,
            providers = {
                lsp = {
                    score_offset = 3,
                    fallbacks = {}, -- defaults to `{ 'buffer' }`
                },
                buffer = {
                    -- opts = {}, default to all visible buffers
                    async = false,
                    min_keyword_length = 1,
                },
                dictionary = {
                    module = "blink-cmp-dictionary",
                    name = "Dict",
                    max_items = 10,
                    min_keyword_length = 3,
                    score_offset = -3,
                    async = true,
                    opts = {
                        dictionary_directories = { vim.fn.expand("~/.config/nvim/dicts/") },
                    },
                },
                ripgrep = {
                    module = "blink-ripgrep",
                    name = "Rg",
                    ---@module "blink-ripgrep"
                    ---@type blink-ripgrep.Options
                    opts = {
                        max_items = 10,
                        min_keyword_length = 3,
                        prefix_min_len = 3,
                        score_offset = -1,
                        project_root_marker = vim.g.ROOT_MARKERS,
                        backend = {
                            use = "gitgrep-or-ripgrep",
                            ripgrep = {
                                search_casing = "--smart-case",
                                additional_rg_options = {
                                    "-d",
                                    "2",
                                },
                                ignore_paths = { "build/" },
                            },
                            gitgrep = {},
                        },
                    },
                },
            },
        },
        fuzzy = {
            sorts = {
                "exact",
                "score",
                "sort_text",
            },
        },
        completion = {
            trigger = {
                show_in_snippet = true,
                show_on_trigger_character = true,
                show_on_blocked_trigger_characters = function()
                    if vim.api.nvim_get_mode().mode == "c" then
                        return {}
                    end
                    return { " ", "\n", "\t" }
                end,
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
