--- Path store shared with Emacs.
---
--- Projects and bookmarks live in two plain files in $HOME:
---
---     ~/.projects     one `name<TAB>path` per line
---     ~/.bookmarks    likewise
---
--- They sit in $HOME rather than under stdpath("data") or inside this repo on
--- purpose. Emacs reads the same two files (see "Shared paths" in
--- ~/.config/emacs/config.org), and so can any shell: `cut -f2 ~/.projects`
--- needs neither jq nor fish. A file owned by neither editor cannot go stale
--- when one of them changes its mind, which is exactly how the previous
--- arrangement broke -- Emacs went on reading a paths.toml under ~/.config/nvim
--- that this side had already replaced with a JSON cache.
---
--- The files stay out of the dotfiles repo, so they can differ between
--- home/work machines. Add entries on the fly with M.add(); the format is
--- there for hand-editing but nothing requires it.
---
--- Paths are stored ~-relative so the same file survives an rsync to a box
--- with a different $HOME (see su-nvim); every reader expands them itself.
---
--- Adding is the only write, and it appends a single line -- nothing here ever
--- rewrites the file, so an add from here and an add from Emacs cannot clobber
--- one another. Removing and renaming are done by editing the file (<leader>fP
--- and <leader>fM), which is why neither has code of its own.

local M = {}

local FILES = {
    projects = vim.fn.expand("~/.projects"),
    bookmarks = vim.fn.expand("~/.bookmarks"),
}

-- Hardcoded, machine-agnostic. Mirrors org-directory in config.org.
local ORGFILES = {
    { name = "Notes", path = "~/Notes/orgfiles" },
}

local function file_for(section)
    return assert(FILES[section], "unknown path section: " .. tostring(section))
end

--- Read the `name<TAB>path` lines of a section. Blank lines, `#` comments and
--- any line without a tab are skipped, so notes left in the file by hand are
--- harmless rather than fatal.
---@param section string
---@return { name: string, path: string }[]
local function read(section)
    local entries = {}
    local f = io.open(file_for(section), "r")
    if not f then return entries end
    for line in f:lines() do
        if not line:match("^%s*#") then
            local name, path = line:match("^([^\t]+)\t+(.+)$")
            if name then
                name, path = vim.trim(name), vim.trim(path)
                if name ~= "" and path ~= "" then
                    table.insert(entries, { name = name, path = path })
                end
            end
        end
    end
    f:close()
    return entries
end

--- True when the file ends mid-line, so an append would splice the new entry
--- onto the last one. Only reachable after a hand-edit: write() and append()
--- both terminate every line they produce.
local function needs_newline(path)
    local f = io.open(path, "r")
    if not f then return false end
    local size = f:seek("end")
    local last
    if size > 0 then
        f:seek("set", size - 1)
        last = f:read(1)
    end
    f:close()
    return last ~= nil and last ~= "\n"
end

local function append(section, entry)
    local path = file_for(section)
    local prefix = needs_newline(path) and "\n" or ""
    local f = io.open(path, "a")
    if not f then
        vim.notify("Could not write " .. path, vim.log.levels.ERROR)
        return false
    end
    f:write(prefix, entry.name, "\t", entry.path, "\n")
    f:close()
    return true
end

--- One-time migration from the old machine-local JSON cache. The JSON is
--- renamed rather than deleted, so a bad parse costs nothing and the entries
--- are still there to look at.
local function migrate_json()
    local old = vim.fn.stdpath("data") .. "/paths.json"
    if vim.fn.filereadable(old) == 0 then return end
    local f = io.open(old, "r")
    if not f then return end
    local ok, data = pcall(vim.json.decode, f:read("*a"))
    f:close()
    if ok and type(data) == "table" then
        for section in pairs(FILES) do
            local seen = {}
            for _, e in ipairs(read(section)) do
                seen[e.path] = true
            end
            for _, e in ipairs(data[section] or {}) do
                if type(e) == "table" and e.name and e.path and not seen[e.path] then
                    append(section, { name = e.name, path = e.path })
                    seen[e.path] = true
                end
            end
        end
    end
    os.rename(old, old .. ".migrated")
end

migrate_json()

function M.projects() return read("projects") end
function M.bookmarks() return read("bookmarks") end
function M.orgfiles() return ORGFILES end

--- Append an entry. section is "projects" or "bookmarks".
--- Paths are stored ~-relative so they read nicely; de-duped by path.
---@param section string
---@param name string
---@param path string
---@return boolean added false when the path is already listed
function M.add(section, name, path)
    path = vim.fn.fnamemodify(path, ":~")
    -- A tab or newline in the name would corrupt the line it is written on.
    name = name:gsub("[\t\n]", " ")
    for _, e in ipairs(read(section)) do
        if e.path == path then
            vim.notify(("Already listed as %q"):format(e.name), vim.log.levels.WARN)
            return false
        end
    end
    return append(section, { name = name, path = path })
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
        if M.add(section, name, path) then
            vim.notify(("Added %s: %s"):format(label, name), vim.log.levels.INFO)
        end
    end)
end

--- The file backing a section, for editing it by hand.
---@param section string
---@return string
function M.file(section) return file_for(section) end

return M
