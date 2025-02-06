local M = {}

local fn, fs, uv = vim.fn, vim.fs, vim.uv

local function get_version(bin)
    -- Python x.xx.x
    local ret = vim.trim(fn.system(bin .. " -V"))
    return ret:match("[%d.]+$")
end

-- CONDA_SHLVL 环境变量标志是否有conda环境激活
-- VIRTUAL_ENV 环境变量标志是否有venv激活
-- CONDA_DEFAULT_ENV 激活后的 conda 环境名称

local default_opts = {
    system = {
        "/usr",
    },
    conda = {
        fn.expand("~/anaconda3/"),
        fn.expand("~/miniconda"),
    },
    venv = {
        ".venv",
        "venv",
    },
}

---@class pyEnv
---@field type "conda"|"system"|"venv"
---@field name string
---@field path string
---@field bin string
---@field version string

local PYTHON_ENVS = {} ---@type pyEnv[]
PY_CURR_ENV = nil ---@type pyEnv

M.detect_env = function(opts)
    -- system
    for _, dir in pairs(opts.system) do
        local bin = _G.pathlib.join(dir, "bin/python")
        if _G.pathlib.executable(bin) then
            local env = {
                type = "system",
                name = dir,
                path = dir,
                bin = bin,
                version = get_version(bin),
            }
            table.insert(PYTHON_ENVS, env)
        end
    end

    -- conda
    for _, root in ipairs(opts.conda) do
        local conda_bin = fs.joinpath(root, "bin/conda")
        if _G.pathlib.executable(conda_bin) then
            local result = fn.system({ conda_bin, "env", "list", "--json" })
            local envs_list = vim.json.decode(result).envs ---@type string[]
            for i, env_path in ipairs(envs_list) do
                local env_name = (i == 1) and "base" or env_path:match("/([%w_-]+)$")
                local bin = env_path .. "/bin/python"

                local env = {
                    type = "conda",
                    name = env_name,
                    path = env_path,
                    bin = bin,
                    version = get_version(bin),
                }
                table.insert(PYTHON_ENVS, env)
            end
        end
    end

    -- venv
    for _, pattern in pairs(opts.venv) do
        local venv_root = _G.pathlib.join(uv.cwd(), pattern)
        local act_bin = _G.pathlib.join(venv_root, "bin/activate")
        local venv_bin = _G.pathlib.join(venv_root, "bin/python")
        if _G.pathlib.dir_exist(venv_root) and _G.pathlib.file_exist(act_bin) then
            local env = {
                type = "venv",
                name = pattern,
                path = venv_root,
                bin = venv_bin,
                version = get_version(venv_bin),
            }
            table.insert(PYTHON_ENVS, env)
        end
    end
end

---@param env pyEnv
M.set_env = function(env)
    if env == nil then
        return
    end
    -- TODO
    PY_CURR_ENV = env
end

M.select_env = function()
    vim.ui.select(PYTHON_ENVS, {
        prompt = "Python Env ❯ ",
        format_item = function(choice)
            return ("%-7s %-15s %-8s %s"):format(
                choice.type,
                choice.name,
                choice.version,
                choice.bin:gsub("^" .. vim.env.HOME, "~")
            )
        end,
    }, M.set_env)
end

M.get_env = function()
    return PY_CURR_ENV
end

M.setup = function(opts)
    opts = vim.tbl_extend("force", default_opts, opts or {})
    vim.schedule(function()
        M.detect_env(opts)

        -- current python
        local current_python_bin = fn.exepath("python")
        for _, env in ipairs(PYTHON_ENVS) do
            if current_python_bin == env.bin then
                PY_CURR_ENV = env
                break
            end
        end
        if PY_CURR_ENV == nil then
            vim.notify("no python found")
        end
    end)

    vim.api.nvim_create_user_command("SetPythonEnv", M.select_env, {})
end

M.setup()
VENV = M
