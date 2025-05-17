local fn = vim.fn

function _G.qftf(info)
    local items
    local ret = {}
    -- The name of item in list is based on the directory of quickfix window.
    -- Change the directory for quickfix window make the name of item shorter.
    -- It's a good opportunity to change current directory in quickfixtextfunc :)
    --
    -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
    -- local root = getRootByAlterBufnr(alterBufnr)
    -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
    --
    if info.quickfix == 1 then
        items = fn.getqflist({ id = info.id, items = 0 }).items
    else
        items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
    end
    local limit = 40
    local validFmt = "%s|%4d:%-3d|%s"
    local cwd = vim.uv.cwd()

    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ""
        local str, text, level
        if e.valid == 1 then
            text = e.text:gsub("^[%s]*", "")
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == "" then
                    fname = "[No Name]"
                else
                    fname = fname:gsub("^" .. cwd .. "/", "")
                    fname = fname:gsub("^" .. vim.env.HOME, "~")
                end

                if #fname > limit + 1 then
                    fname = fname:sub(1, limit)
                else
                    fname = ("%-" .. limit .. "s"):format(fname)
                end
            end

            local lnum = e.lnum
            local col = e.col
            -- local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()

            text = text
                :gsub("^(error)", "ERROR") --
                :gsub("^(warning)", "WARN")
                :gsub("^(info)", "INFO")
                :gsub("^(note)", "NOTE")

            str = validFmt:format(fname, lnum, col, text)
        else
            fname = ("%-" .. limit .. "s"):format("")
            str = validFmt:format(fname, 0, 0, e.text)
        end
        table.insert(ret, str)
    end
    return ret
end

vim.o.quickfixtextfunc = "{info -> v:lua._G.qftf(info)}"
