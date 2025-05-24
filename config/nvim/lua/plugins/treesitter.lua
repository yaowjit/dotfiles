local opts = {
    ensure_installed = {
        "vim",
        "vimdoc",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "comment",
        "c",
        "cpp",
        "python",
    },
    ignore_install = { "latex" },
    highlight = { enable = true }, -- conditionally disabled by snacks.nvim
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = false,
            node_decremental = "<BS>",
        },
    },

    indent = { enable = true },

    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    textobjects = {
        swap = {
            enable = true,
            swap_next = {
                ["<leader>."] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>,"] = "@parameter.inner",
            },
        },
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_previous_start = {
                ["[f"] = { query = "@function.outer", desc = "prev func start" },
                ["[c"] = { query = "@class.outer", desc = "prev class start" },
            },
            goto_previous_end = {
                ["[F"] = { query = "@function.outer", desc = "prev func end" },
                ["[C"] = { query = "@class.outer", desc = "prev class end" },
            },
            goto_next_start = {
                ["]f"] = { query = "@function.outer", desc = "next func start" },
                ["]c"] = { query = "@class.outer", desc = "next class start" },
            },
            goto_next_end = {
                ["]F"] = { query = "@function.outer", desc = "next func end" },
                ["]C"] = { query = "@class.outer", desc = "next class end" },
            },
        },
        lsp_interop = { enable = false },
    },
}

---@type LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup(opts)
    end,
}
