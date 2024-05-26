return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	opts = function()
            --[=====[ local logo = [[
 _______    ___       ______ .___________.    _______. _______ .___________.
|   ____|  /   \     /      ||           |   /       ||   ____||           |
|  |__    /  ^  \   |  ,----'`---|  |----`  |   (----`|  |__   `---|  |----`
|   __|  /  /_\  \  |  |         |  |        \   \    |   __|      |  |     
|  |    /  _____  \ |  `----.    |  |    .----)   |   |  |____     |  |     
|__|   /__/     \__\ \______|    |__|    |_______/    |_______|    |__|     
                                                                            
    ]] --]=====]
            local logo = [[  
    ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          
    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       
          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     
           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    
          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   
   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  
  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   
 ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  
 ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ 
      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     
       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     
]]



		logo = string.rep("\n", 5) .. logo .. "\n\n"

		local opts = {
			theme = "doom",
			hide = {
				-- this is taken care of by lualine
				-- enabling this messes up the actual laststatus setting after loading a file
				statusline = false,
			},
			config = {
				header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = "ene | startinsert",                                        desc = " new file",        icon = " ", key = "e" },
          { action = "Telescope find_files",                                     desc = " find file",       icon = " ", key = "<space>f" },
          { action = "Telescope oldfiles",                                       desc = " recent files",    icon = " ", key = "<space>r" },
          { action = "Telescope live_grep",                                      desc = " find text",       icon = " ", key = "<space>g" },
          { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " config",          icon = " ", key = "<space>c" },
          { action = 'lua require("persistence").load()',                        desc = " restore session", icon = " ", key = "<space>s" },
          -- { action = "LazyExtras",                                               desc = " lazy extras",     icon = " ", key = "<space>x" },
          -- { action = "Lazy",                                                     desc = " lazy",            icon = "󰒲 ", key = "<space>l" },
          { action = "qa",                                                       desc = " quit",            icon = " ", key = "q" },
        },
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return { "⚡ neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
				end,
			},
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			button.key_format = "  %s"
			button.key_format = string.gsub(button.key, "<space>", "   SPC ")
		end

		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "DashboardLoaded",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		return opts
	end,
}
