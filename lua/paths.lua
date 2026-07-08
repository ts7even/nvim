--- Path store for the snacks pickers.
---
--- Projects and bookmarks live in a machine-local JSON cache under
--- stdpath("data") (i.e. ~/.local/share/nvim) so they are NOT tracked in the
--- dotfiles repo and can differ between home/work machines. Add them on the fly
--- with M.add(); no TOML editing required.
---
--- Notes are hardcoded here since they're identical on every machine.

local M = {}

local cache_path = vim.fn.stdpath("data") .. "/paths.json"

-- Hardcoded, machine-agnostic.
local ORGFILES = {
    { name = "Notes", path = "~/org" },
}

local function read_cache()
    local f = io.open(cache_path, "r")
    if not f then return { projects = {}, bookmarks = {} } end
    local content = f:read("*a")
    f:close()
    local ok, data = pcall(vim.json.decode, content)
    if not ok or type(data) ~= "table" then
        return { projects = {}, bookmarks = {} }
    end
    data.projects = data.projects or {}
    data.bookmarks = data.bookmarks or {}
    return data
end

local function write_cache(data)
    local f = io.open(cache_path, "w")
    if not f then
        vim.notify("Could not write " .. cache_path, vim.log.levels.ERROR)
        return false
    end
    f:write(vim.json.encode(data))
    f:close()
    return true
end

function M.projects() return read_cache().projects end
function M.bookmarks() return read_cache().bookmarks end
function M.orgfiles() return ORGFILES end

--- Add (or rename) an entry. section is "projects" or "bookmarks".
--- Paths are stored ~-relative so they read nicely; de-duped by path.
---@param section string
---@param name string
---@param path string
function M.add(section, name, path)
    path = vim.fn.fnamemodify(path, ":~")
    local data = read_cache()
    data[section] = data[section] or {}
    for _, e in ipairs(data[section]) do
        if e.path == path then
            e.name = name
            write_cache(data)
            return
        end
    end
    table.insert(data[section], { name = name, path = path })
    write_cache(data)
end

--- Prompt for a name, then add `path` to `section` ("projects"|"bookmarks").
---@param section string
---@param path string
function M.add_interactive(section, path)
    if not path or path == "" then
        vim.notify("No path to add", vim.log.levels.WARN)
        return
    end
    local label = section:gsub("s$", "")
    local default = vim.fn.fnamemodify(path:gsub("/$", ""), ":t")
    vim.ui.input({ prompt = label .. " name: ", default = default }, function(name)
        if not name or name == "" then return end
        M.add(section, name, path)
        vim.notify(("Added %s: %s"):format(label, name), vim.log.levels.INFO)
    end)
end

--- Remove an entry from a section by path.
---@param section string
---@param path string
function M.remove(section, path)
    local data = read_cache()
    local list = data[section] or {}
    for i, e in ipairs(list) do
        if e.path == path then
            table.remove(list, i)
            break
        end
    end
    write_cache(data)
end

return M
