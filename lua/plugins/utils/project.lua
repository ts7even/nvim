local function activate_venv(project_path)
    local venv_path = project_path .. "/.venv"
    local activate_script = venv_path .. "/bin/activate"
    if vim.fn.isdirectory(venv_path) == 1 and vim.fn.filereadable(activate_script) == 1 then
        vim.env.VIRTUAL_ENV = venv_path
        vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
        vim.notify("Activated venv: " .. venv_path, vim.log.levels.INFO)
    end
end

return {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>fpa",
            function()
                local cwd = vim.fn.getcwd()
                require("project_nvim.project").set_pwd(cwd, "manual")
                vim.notify("Added project: " .. cwd, vim.log.levels.INFO)
            end,
            desc = "Add current dir as project",
        },
        {
            "<leader>fp",
            function()
                local projects = require("project_nvim").get_recent_projects()
                Snacks.picker.pick({
                    title = "Projects",
                    items = vim.tbl_map(function(path)
                        return { text = path, file = path }
                    end, projects),
                    format = function(item)
                        return { { vim.fn.fnamemodify(item.text, ":~") } }
                    end,
                    confirm = function(picker, item)
                        picker:close()
                        if item then
                            vim.cmd("cd " .. item.file)
                            activate_venv(item.file)
                            Snacks.picker.files()
                        end
                    end,
                })
            end,
            desc = "Projects",
        },
    },
    opts = {
        manual_mode = true,
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git", "Makefile", "package.json", "Cargo.toml", "pyproject.toml", "go.mod" },
        show_hidden = true,
        silent_chdir = true,
        scope_chdir = "global",
    },
    config = function(_, opts)
        require("project_nvim").setup(opts)
    end,
}
