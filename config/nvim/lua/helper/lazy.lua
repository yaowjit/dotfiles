local M = {}

---@type LazyConfig
local lazy_defaults = {
    change_detection = {
        enabled = false,
        notify = false,
    },
    dev = {
        path = vim.fn.stdpath("config") .. "/dev", -- ~/.config/nvim/dev
        fallback = true, -- 如果本地没有就用github 上的
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
}

---@generic T
---@param key string
---@param val T
---@return T
_G.OPT = function(key, val)
    return vim.g[key] and vim.g[key] or val
end

---@param ... LazyConfig
M.setup = function(...)
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.uv.fs_stat(lazypath) then
        vim.fn.system(
            "git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git " .. lazypath
        )
    end
    vim.opt.rtp:prepend(lazypath)

    local opts = ... or {}
    opts = vim.tbl_deep_extend("force", lazy_defaults, opts)

    _G.pathlib = require("helper.path")

    vim.keymap.set("n", "<leader>L", ":Lazy<CR>", {})
    require("lazy").setup(opts)
end

return M
