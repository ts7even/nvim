return {
	-- CodeCompanion.nvim - AI coding assistant with multiple LLM and agent support
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{ "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle CodeCompanion Chat", mode = { "n", "v" } },
		},
		opts = {
		-- Adapter configuration
		adapters = {
			http = {
				anthropic = function()
					return require("codecompanion.adapters").extend("anthropic", {
						schema = {
							model = {
								default = "claude-sonnet-4-20250514", -- Claude Sonnet 4.5
							},
						},
					})
				end,
			},
		},
		
		-- Default strategies for different use cases
		strategies = {
			chat = {
				adapter = "anthropic", -- Default to Anthropic for chat
			},
			inline = {
				adapter = "copilot", -- Default to Copilot for inline assistance
			},
		},			-- Display configuration
			display = {
				action_palette = {
					provider = "telescope", -- Options: 'default', 'telescope', 'mini_pick', 'snacks'
				},
				chat = {
					window = {
						layout = "float", -- Options: 'float', 'vertical', 'horizontal'
						width = 0.8, -- Float width (0-1 for percentage, >1 for fixed)
						height = 0.8, -- Float height
						border = "rounded", -- Border style
						title = "🤖 CodeCompanion Chat",
						zindex = 100,
					},
					show_settings = false, -- Show settings in chat buffer
					show_token_count = true, -- Show token count
				},
			},

			-- Options configuration
			opts = {
				log_level = "INFO", -- Options: 'ERROR', 'WARN', 'INFO', 'DEBUG', 'TRACE'
				send_code = true, -- Send code context automatically
				use_default_actions = true, -- Enable default actions in action palette
				use_default_prompts = true, -- Enable default prompts
			},
		},
	},
}
