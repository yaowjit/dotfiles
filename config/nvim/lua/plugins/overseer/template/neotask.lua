local overseer = require("overseer")
local constants = require("overseer.constants")
local TAG = constants.TAG
local fn, uv = vim.fn, vim.uv

local MACROS = require("plugins.overseer.macro")

vim.g.neotask_config = {
    profile = "release",
    output = "quickfix",
    config_file_path = {
        fn.expand("~/.config/nvim/tasks.ini"),
    },
    save = 1,
}

local neotask_keys = {
    "cmd",
    "cwd",
    "strategy",
    "components",

    "output",
    "out_dir",
    "save",
}
--- {{{ load and parse neotask ini file
---@param key string
---@return boolean
local function valid_key(key)
    return vim.tbl_contains(neotask_keys, key)
end

---@param s string
---@return string
local function replace_with_macros(s)
    local MACROS = require("plugins.overseer.macro")
    for m in s:gmatch("%$%(([%u_]+)%)") do -- all macros are upper case such as VIM_FILEPATH
        if MACROS[m] ~= nil then
            s = s:gsub("%$%(" .. m .. "%)", MACROS[m]())
        end
    end
    return s
end

---@param lines string[] file lines
local function parse_ini(lines)
    local sections, curr_section = {}, nil
    for _, line in ipairs(lines) do
        -- trim tail # and ; comments
        line = vim.trim(line):gsub("[%s]*;.*$", ""):gsub("[%s]*#.*$", "")
        if line ~= "" then
            if line:match("^%[.*%]$") then -- [section_name]
                curr_section = line:match("^%[(.*)%]$")
                sections[curr_section] = {}
                if curr_section ~= "+" then
                    sections[curr_section]["cmd"] = {}
                end
            else
                local k, v, ft, cmd

                if line:match("^cmd([%w:]*)=") then -- ^cmd:ft=xxx args
                    ft, cmd = line:match("^cmd:?([%w]*)=(.*)")
                    ft = (ft == "") and "*" or ft
                    sections[curr_section]["cmd"][ft] = replace_with_macros(cmd)
                else
                    k, v = line:match("^([%w_]+)=(.*)")

                    if curr_section == "+" then -- [+] section
                        sections[curr_section][k] = v
                    else
                        if valid_key(k) then
                            sections[curr_section][k] = v
                        end
                    end
                end
            end
        end
    end
    return sections
end

---@param fpath string
---@return table<string, any>
local function load_neotask_file(fpath)
    fpath = vim.fn.expand(fpath)
    if vim.fn.filereadable(fpath) == 0 then
        return {}
    end
    local lines = vim.fn.readfile(fpath) ---@type string[]
    return parse_ini(lines)
end
--- }}}

vim.g.neotask_profile = "release" ---@alias neotaskProfile 'release'|'debug'
--- {{{
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        local cmdparse = require("mega.cmdparse")
        local available_profiles = { "release", "debug" }
        local parser = cmdparse.ParameterParser.new({ name = "neotaskProfile", help = "neotask runner profile" })
        parser:add_parameter({ name = "profile", choices = available_profiles, help = "" })
        parser:set_execute(function(data)
            vim.g.neotask_profile = data.namespace.profile
        end)
        cmdparse.create_user_command(parser)

        local task_parser = cmdparse.ParameterParser.new({ name = "neotask", help = "neotask runner" })
        -- local top_subparsers = task_parser:add_subparsers({ destination = "commands" })
        -- for subtask_key, subtask_opts in pairs(tasks) do
        --     if subtask_key ~= "+" then
        --         -- for _, cmd in subtask_opts.cmd do
        --         local subparser = top_subparsers:add_parser({ name = subtask_key, help = "" })

        --         subparser:add_parameter({ name = "--cwd", default = ".", help = "" })
        --         subparser:add_parameter({ name = "--save", default = "1", choices = { "0", "1", "2" }, help = "" })
        --         subparser:add_parameter({ name = "--focus", default = "1", choices = { "0", "1", "2" }, help = "" })
        --         subparser:add_parameter({
        --             name = "--output",
        --             default = "quickfix",
        --             choices = { "quickfix", "terminal" },
        --             help = "",
        --         })

        --         subparser:set_execute(function(data)
        --             vim.print(data.namespace)
        --         end)
        --         -- end
        --     end
        -- end
        cmdparse.create_user_command(task_parser)
    end,
})
--- }}}

local global_task_file = "~/.config/nvim/task.ini"
local tasks = load_neotask_file(global_task_file)

local function generate_overseer_tasks(tasks)
    ---@type overseer.TemplateFileDefinition
    local tmpl = {
        name = "neotask",
        desc = "an overseer wrap over vim plugin https://github.com/skywind3000/asynctask.vim",
        params = {
            name = { type = "string" },
            cmd = { type = "string" },
            cwd = { type = "string" },
        },
        condition = {
            -- filetype = {},
            -- dir = {},
            ---@class overseer.SearchParams
            ---@field filetype? string
            ---@field tags? string[]
            ---@field dir string
            fallback = function(search_params)
                --
            end,
        },
        builder = function(params)
            ---@type overseer.TaskDefinition
            local task_def = {
                name = params.name,
                cmd = params.cmd,
                cwd = params.cwd,
                -- args = {},
                -- env = {},
                strategy = { "terminal" },
                components = { { "on_output_quickfix", open = true }, "default" },
            }
            return task_def
        end,
    }
    local ret = {}
    for section, opts in pairs(tasks) do
        if section:match(":") then
            vim.print(section)
        else
        end
        -- vim.print(opts)
        table.insert(ret, {})
    end

    return ret
end

-- vim.print(tasks)
generate_overseer_tasks(tasks)

return {
    name = "neotask",
    generator = function(opts, cb)
        local tasks = load_neotask_file(global_task_file)
        -- local task_file_info = load_neotask_file(global_task_file)
        -- local tasks = get_task_opts(task_file_info)
        -- for _, opts_override in ipairs(tasks) do
        --     table.insert(ret, overseer.wrap_template(tmpl, opts_override))
        -- end
        cb(tasks)
    end,
}

-- vim:foldmethod=marker:
