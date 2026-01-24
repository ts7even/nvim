return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        {
            "<leader>fa",
            function()
                require("harpoon"):list():add()
            end,
            desc = "Add to harpoon",
        },
        {
            "<leader>fh",
            function()
                local harpoon = require("harpoon")
                local list = harpoon:list()
                local items = {}
                for i, item in ipairs(list.items) do
                    table.insert(items, {
                        text = string.format("[%d] %s", i, item.value),
                        file = item.value,
                        idx = i,
                    })
                end
                Snacks.picker.pick({
                    title = "Harpoon",
                    items = items,
                    format = function(item)
                        return { { item.text } }
                    end,
                    confirm = function(picker, item)
                        picker:close()
                        if item then
                            list:select(item.idx)
                        end
                    end,
                })
            end,
            desc = "Harpoon picker",
        },
        {
            "<leader>fH",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = "Harpoon menu",
        },
        {
            "<leader>fhr",
            function()
                require("harpoon"):list():remove()
            end,
            desc = "Remove from harpoon",
        },
        {
            "<leader>1",
            function()
                require("harpoon"):list():select(1)
            end,
            desc = "Harpoon file 1",
        },
        {
            "<leader>2",
            function()
                require("harpoon"):list():select(2)
            end,
            desc = "Harpoon file 2",
        },
        {
            "<leader>3",
            function()
                require("harpoon"):list():select(3)
            end,
            desc = "Harpoon file 3",
        },
        {
            "<leader>4",
            function()
                require("harpoon"):list():select(4)
            end,
            desc = "Harpoon file 4",
        },
        {
            "<C-S-P>",
            function()
                require("harpoon"):list():prev()
            end,
            desc = "Harpoon prev",
        },
        {
            "<C-S-N>",
            function()
                require("harpoon"):list():next()
            end,
            desc = "Harpoon next",
        },
    },
    opts = {
        settings = {
            save_on_toggle = true,
            sync_on_ui_close = true,
        },
    },
}
