local path = require("lspconfig/util").path

M = {}

-- workaround until https://github.com/neovim/neovim/issues/28777 fixed
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/util.lua#L265
local function path_join(...)
    return table.concat(vim.tbl_flatten { ... }, '/')
end

local function get_python_venv(workspace)
    -- use activated venv
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV)
    end

    -- find and use venv
    local match = vim.fs.find("pyvenv.cfg", { type = "file", path = workspace })
    if #match == 1 and match[1] ~= "" then
        return path.dirname(match[1])
    end
end

M.get_python_relative_bin = function(workspace)
    -- want only relative path
    return path_join(vim.fs.basename(get_python_venv(workspace)), "bin")
end

M.get_python_path = function(workspace)
    local venv = get_python_venv(workspace)
    if venv ~= nil and venv ~= "" then
        vim.api.nvim_notify("set venv to" .. path.join(venv, "bin", "python"), 1, {})
        return path.join(venv, "bin", "python")
    end

    -- default to global python
    return vim.fn.exepath("python3") or vim.fn.exepath("python")
end

return M
