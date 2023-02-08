local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- stylua: ignore
local plugins = {
    -- NOTE: plugin dependencies
    { "folke/lazy.nvim" },
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "kyazdani42/nvim-web-devicons" },
    { "onsails/lspkind.nvim" },
    { "MunifTanjim/nui.nvim" },

    -- NOTE: core plugins
    -- load color scheme plugins before other
    { -- colorschemes
        "folke/tokyonight.nvim",
        dependencies = { -- other themes
            "EdenEast/nightfox.nvim",
        },
        priority = 1000,
        config = function() require("user.core.themes") end,
    },
    { "rcarriga/nvim-notify",
        priority = 900,
        config = function() require('user.core.nvim-notify') end
    },
    { -- which key
        "folke/which-key.nvim",
        priority = 800,
        config = function() require("user.core.whichkey") end,
    },
    { -- syntax parser
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "HiPhish/nvim-ts-rainbow2",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "RRethy/nvim-treesitter-endwise",
        },
        build = ":TSUpdate",
        config = function() require("user.core.treesitter") end,
    },
    { -- auto complete
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "rcarriga/cmp-dap",
            { dir="~/Projects/cmp-luarime" },
            -- "Ninlives/cmp-rime",
            "saadparwaiz1/cmp_luasnip",

            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "honza/vim-snippets",
        },
        event = { "InsertEnter" },
        config = function() require("user.core.cmp") end,
    },
    { --fuzzy search
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
        },
        priority = 100,
        event = { "VeryLazy" },
        config = function() require("user.core.telescope") end,
    },
    { --fuzzy search
        "Yggdroot/LeaderF",
        event = { "VeryLazy" },
        priority = 99,
        -- need to pip install pynvim
        build = ":LeaderfInstallCExtension",
        cond = function() return vim.fn.has("python3") == 1 end,
        init = function()
            vim.g.Lf_ShortcutF = ""
            vim.g.Lf_ShortcutB = ""
        end,
        config = function() require("user.core.leaderf") end,
    },
    { -- file manager
        "kyazdani42/nvim-tree.lua",
        event = { "VeryLazy" },
        config = function() require("user.core.nvim-tree") end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        event = { "VeryLazy" },
        config = function() require("user.core.neo-tree") end,
    },
    { -- build and run
        "skywind3000/asynctasks.vim",
        dependencies = { "skywind3000/asyncrun.vim" },
        event = { "VeryLazy" },
        config = function() require("user.core.asynctasks") end,
    },
    { -- unit test
        "nvim-neotest/neotest",
        dependencies = {
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
        },
        event = { "VeryLazy" },
        config = function() require("user.core.neotest") end,
    },

    { -- NOTE: lsp
        "neovim/nvim-lspconfig",
        dependencies = {
            "tamago324/nlsp-settings.nvim",
            "glepnir/lspsaga.nvim",
            "folke/trouble.nvim",
            "ray-x/lsp_signature.nvim",
            "jose-elias-alvarez/null-ls.nvim",

            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "jay-babu/mason-null-ls.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function() require("user.lsp") end,
    },

    { -- NOTE: dap
        "mfussenegger/nvim-dap",
        dependencies = {
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "Weissle/persistent-breakpoints.nvim",

            "williamboman/mason.nvim",
            "jayp0521/mason-nvim-dap.nvim",
        },
        ft = { "python", "c", "cpp" },
        config = function()
            require("user.dap")
            require("user.dap.keymap").setup({ "*.py", "*.c", "*.cc", "*.cpp" })
        end,
    },

    -- the rest plugin configuratoins are placed in lua/user/conf/
    -- NOTE: UI
    "goolord/alpha-nvim",
    "stevearc/dressing.nvim",
    "lukas-reineke/indent-blankline.nvim",
    { "akinsho/bufferline.nvim", version = "v3.*" },
    "nvim-lualine/lualine.nvim",
    "stevearc/aerial.nvim",

    -- NOTE: edit enhanced
    "echasnovski/mini.nvim",
    "numToStr/Comment.nvim",
    "windwp/nvim-autopairs",
    "meain/vim-printer",
    "theniceboy/antovim",
    "nvim-pack/nvim-spectre",
    "tpope/vim-repeat",
    "ThePrimeagen/refactoring.nvim",
    { -- fast jump
        "ggandor/leap.nvim",
        dependencies = { "ggandor/flit.nvim" },
    },

    -- NOTE: other tools
    "lewis6991/gitsigns.nvim",
    "sindrets/diffview.nvim",
    "skywind3000/vim-quickui",
    -- "junegunn/fzf",
    { "voldikss/vim-translator", cmd = { "TranslateW" } },
    { "karb94/neoscroll.nvim" },
    { "akinsho/toggleterm.nvim", version = "*" },
    "aserowy/tmux.nvim",
    -- leetcode
    -- {
    --     dir = "~/Projects/leetcode-cli.nvim",
    --     config = true,
    --     ft = "python",
    -- },
    -- filetype specified plugins configured in user/lang/<ft>.lua
    { "kevinhwang91/nvim-bqf", ft = "qf" },
    -- { -- generate python docstring
        -- "heavenshell/vim-pydocstring", build = "make install",
        -- { dir = "~/.config/nvim/py-env.nvim" },
        -- ft = "python",
    -- },
    { "lervag/vimtex", version = "*", ft = "tex" },
}

require("lazy").setup(plugins)
