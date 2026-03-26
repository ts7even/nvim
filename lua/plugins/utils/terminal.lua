return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        { "<C-\\>",     function() require("toggleterm").toggle(0, nil, nil, "horizontal") end, mode = { "n", "t" }, desc = "Toggle Terminal" },
        { "<leader>tt", function() require("toggleterm").toggle(0, nil, nil, "horizontal") end, desc = "Toggle Terminal" },
        { "<leader>tn", function()
            local Terminal = require("toggleterm.terminal")
            local terms = Terminal.get_all()
            -- Find direction of currently open terminal, close it first
            local dir = "horizontal"
            for _, t in ipairs(terms) do
                if t:is_open() then
                    dir = t.direction or "horizontal"
                    t:close()
                    break
                end
            end
            -- Create next terminal (find highest number + 1)
            local next_id = 1
            for _, t in ipairs(terms) do
                if t.id >= next_id then next_id = t.id + 1 end
            end
            require("toggleterm").toggle(next_id, nil, nil, dir)
        end, desc = "New Terminal" },
        { "<leader>tl", function()
            local Terminal = require("toggleterm.terminal")
            local terms = Terminal.get_all()
            if #terms == 0 then
                vim.notify("No terminals open", vim.log.levels.INFO)
                return
            end
            local items = {}
            for _, t in ipairs(terms) do
                local dir = t.direction or "horizontal"
                table.insert(items, {
                    text = (t.display_name or ("Terminal " .. t.id)) .. " [" .. dir .. "]",
                    id = t.id,
                    dir = dir,
                    name = t.display_name or ("Terminal " .. t.id),
                })
            end
            Snacks.picker.pick({
                title = "Terminals",
                items = items,
                format = function(item)
                    return {
                        { item.name .. "  ", "SnacksPickerLabel" },
                        { "[" .. item.dir .. "]", "SnacksPickerComment" },
                    }
                end,
                confirm = function(picker, item)
                    picker:close()
                    if item then
                        -- Close any currently open terminal first
                        for _, t in ipairs(Terminal.get_all()) do
                            if t:is_open() then t:close() end
                        end
                        local term = Terminal.get(item.id)
                        if term then term:open() end
                    end
                end,
            })
        end, desc = "List Terminals" },
        { "<leader>tr", function()
            vim.ui.input({ prompt = "Rename terminal: " }, function(name)
                if not name or name == "" then return end
                -- Find the currently visible terminal
                local terms = require("toggleterm.terminal").get_all()
                for _, t in ipairs(terms) do
                    if t:is_open() then
                        t.display_name = name
                        vim.notify("Terminal renamed to: " .. name, vim.log.levels.INFO)
                        return
                    end
                end
            end)
        end, desc = "Rename Terminal" },
        -- Directional terminal toggles: remembers last-used terminal per direction
        { "<leader>tv", function()
            local terms = require("toggleterm.terminal").get_all()
            for _, t in ipairs(terms) do
                if t:is_open() then
                    vim.g._last_vertical_term = t.id
                    t:close()
                    return
                end
            end
            local last = vim.g._last_vertical_term or 98
            local term = require("toggleterm.terminal").get(last)
            if term then
                term:open()
            else
                require("toggleterm").toggle(98, nil, nil, "vertical")
            end
        end, desc = "Terminal (vertical)" },
        { "<leader>th", function()
            local terms = require("toggleterm.terminal").get_all()
            for _, t in ipairs(terms) do
                if t:is_open() then
                    vim.g._last_horizontal_term = t.id
                    t:close()
                    return
                end
            end
            local last = vim.g._last_horizontal_term or 99
            local term = require("toggleterm.terminal").get(last)
            if term then
                term:open()
            else
                require("toggleterm").toggle(99, nil, nil, "horizontal")
            end
        end, desc = "Terminal (horizontal)" },
        -- Cycle terminals
        { "<leader>t]", function()
            local terms = require("toggleterm.terminal").get_all()
            if #terms <= 1 then return end
            -- Find current open terminal
            local current_idx = nil
            for i, t in ipairs(terms) do
                if t:is_open() then current_idx = i break end
            end
            if not current_idx then return end
            local next_idx = (current_idx % #terms) + 1
            terms[current_idx]:close()
            terms[next_idx]:open()
        end, desc = "Next Terminal" },
        { "<leader>t[", function()
            local terms = require("toggleterm.terminal").get_all()
            if #terms <= 1 then return end
            local current_idx = nil
            for i, t in ipairs(terms) do
                if t:is_open() then current_idx = i break end
            end
            if not current_idx then return end
            local prev_idx = ((current_idx - 2) % #terms) + 1
            terms[current_idx]:close()
            terms[prev_idx]:open()
        end, desc = "Prev Terminal" },
    },
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return math.floor(vim.o.lines * 0.3)
            elseif term.direction == "vertical" then
                return math.floor(vim.o.columns * 0.4)
            end
        end,
        shade_terminals = false,
        start_in_insert = true,
        persist_size = true,
        persist_mode = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "curved",
        },
        winbar = {
            enabled = true,
            name_formatter = function(term)
                return term.display_name or ("Terminal " .. term.id)
            end,
        },
    },
}
