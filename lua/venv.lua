--- Session-global Python virtualenv activation, shared by the project picker
--- and :VenvActivate.
---
--- VIRTUAL_ENV and PATH belong to the whole Neovim session, not to a buffer,
--- so switching projects has to *deactivate* the previous venv rather than
--- just activate the new one. Without that, a project with no .venv of its own
--- silently inherits the last project's interpreter, and PATH grows another
--- stale bin/ entry on every switch.

local M = {}

-- The bin/ directory this module last put on PATH, so it can take it back off.
-- Tracked here rather than derived from VIRTUAL_ENV so a venv activated by the
-- parent shell (which we never added) is never removed.
local active_bin = nil

--- Drop the venv this module activated, if any, from PATH and the environment.
function M.deactivate()
    if active_bin then
        local kept = {}
        for _, dir in ipairs(vim.split(vim.env.PATH, ":", { plain = true })) do
            if dir ~= active_bin then
                table.insert(kept, dir)
            end
        end
        vim.env.PATH = table.concat(kept, ":")
        active_bin = nil
    end
    vim.env.VIRTUAL_ENV = nil
end

--- Activate `venv` (a virtualenv directory) for this session, replacing
--- whichever one was active. Returns false when `venv` is not a directory --
--- the previous venv is deactivated either way, which is the point.
---@param venv string
---@return boolean
function M.activate(venv)
    M.deactivate()
    venv = vim.fn.fnamemodify(venv, ":p"):gsub("/$", "")
    if vim.fn.isdirectory(venv) == 0 then
        return false
    end
    active_bin = venv .. "/bin"
    vim.env.VIRTUAL_ENV = venv
    vim.env.PATH = active_bin .. ":" .. vim.env.PATH
    return true
end

--- Restart the Python servers so they pick up the new interpreter. Pyright
--- resolves it in before_init, which only runs when a client starts, so a
--- server already up keeps pointing at the old venv until it is restarted.
---
--- :LspRestart is deliberately not used: it only relaunches servers registered
--- through lspconfig's own framework, and these are configured with
--- vim.lsp.config/enable, so it would stop them without bringing them back.
function M.restart_python_lsp()
    local names = { "pyright", "ruff" }
    local clients = {}
    for _, name in ipairs(names) do
        vim.list_extend(clients, vim.lsp.get_clients({ name = name }))
    end
    if #clients == 0 then
        return
    end

    vim.lsp.enable(names, false)

    -- enable(false) calls client:stop(), which is asynchronous. Re-enabling
    -- before the old clients are gone makes vim.lsp's enable callback see them
    -- as still attached and skip the restart, so wait them out first. The
    -- re-enable fires `doautoall FileType`, which re-attaches every open
    -- buffer, not just the current one.
    local timer = assert(vim.uv.new_timer())
    local waited = 0
    timer:start(50, 50, vim.schedule_wrap(function()
        -- schedule_wrap defers each tick to the main loop, so several can be
        -- queued before the first one runs and stops the timer. Without this
        -- guard the second one closes an already-closed handle (an error) and
        -- re-enables the servers a second time.
        if timer:is_closing() then
            return
        end
        waited = waited + 50
        local stopped = true
        for _, c in ipairs(clients) do
            if not c:is_stopped() then
                stopped = false
            end
        end
        if stopped or waited >= 2000 then
            timer:stop()
            timer:close()
            vim.lsp.enable(names)
        end
    end))
end

return M
