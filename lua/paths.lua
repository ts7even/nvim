--- Minimal TOML parser (array-of-tables + string key/values only)
--- and helpers for reading paths.toml

local M = {}

local toml_path = vim.fn.stdpath("config") .. "/static/paths.toml"

--- Parse a simple TOML file supporting [[array]] headers and key = "value" pairs.
---@param filepath string
---@return table<string, table[]>
local function parse_toml(filepath)
    local result = {}
    local current_key = nil

    for line in io.lines(filepath) do
        line = line:match("^%s*(.-)%s*$") -- trim
        if line == "" or line:match("^#") then
            goto continue
        end

        local array_key = line:match("^%[%[(.+)%]%]$")
        if array_key then
            current_key = array_key
            result[current_key] = result[current_key] or {}
            table.insert(result[current_key], {})
            goto continue
        end

        if current_key then
            local k, v = line:match('^(%w+)%s*=%s*"(.-)"$')
            if k and v then
                result[current_key][#result[current_key]][k] = v
            end
        end

        ::continue::
    end
    return result
end

--- Read and cache parsed paths. Cache is invalidated when the file changes.
local _cache = { mtime = 0, data = nil }

function M.load()
    local stat = vim.uv.fs_stat(toml_path)
    if not stat then
        vim.notify("paths.toml not found: " .. toml_path, vim.log.levels.WARN)
        return { projects = {}, bookmarks = {}, orgfiles = {} }
    end
    local mtime = stat.mtime.sec
    if _cache.data and _cache.mtime == mtime then
        return _cache.data
    end
    _cache.data = parse_toml(toml_path)
    _cache.mtime = mtime
    return _cache.data
end

function M.projects() return M.load().projects or {} end
function M.bookmarks() return M.load().bookmarks or {} end
function M.orgfiles() return M.load().orgfiles or {} end

return M
