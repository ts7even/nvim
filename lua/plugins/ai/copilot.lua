return {
	-- GitHub Copilot AI code completion
	{
		"https://github.com/github/copilot.vim",
		lazy = false,
		config = function()
			-- GitHub Copilot keymaps
			vim.keymap.set("n", "<leader>cE", ":Copilot enable<CR>", { desc = "Enable Copilot" })
			vim.keymap.set("n", "<leader>cd", ":Copilot disable<CR>", { desc = "Disable Copilot" })
		end,
	},

	-- GitHub Copilot Chat interface
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		event = "VeryLazy",
		config = function()
			require("CopilotChat").setup({
				model = "claude-sonnet-4", -- AI model to use: 'gpt-4o', 'claude-sonnet-4', 'gemini-2.0-flash'
				temperature = 0.1, -- Lower = focused, higher = creative
				debug = false,
				show_help = "yes",
				prompts = {
					Explain = "Please explain how the following code works.",
					Review = "Please review the following code and provide suggestions for improvement.",
					Tests = "Please explain how the selected code works, then generate unit tests for it.",
					Refactor = "Please refactor the following code to improve its clarity and readability.",
					FixCode = "Please fix the following code to make it work as intended.",
				},
				window = {
					layout = "float",
					width = 80, -- Fixed width in columns
					height = 20, -- Fixed height in rows
					border = "rounded", -- 'single', 'double', 'rounded', 'solid'
					title = "🤖 AI Assistant",
					zindex = 100, -- Ensure window stays on top
				},
				headers = {
					user = "👤 You: ",
					assistant = "🤖 Copilot: ",
					tool = "🔧 Tool: ",
				},
				separator = "━━",
				show_folds = false, -- Disable folding for cleaner look
			})

			-- CopilotChat keymaps
			vim.keymap.set("n", "<leader>cc", ":CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
			vim.keymap.set("n", "<leader>cq", ":CopilotChat<CR>", { desc = "Open Copilot Chat" })

			-- CopilotChat visual mode keymaps
			vim.keymap.set("v", "<leader>cq", function()
				require("CopilotChat").ask(
					vim.fn.input("Quick Chat: "),
					{ selection = require("CopilotChat.select").visual }
				)
			end, { desc = "Ask Copilot about selection" })
			vim.keymap.set("v", "<leader>cx", function()
				require("CopilotChat").ask(
					"Please explain how this code works.",
					{ selection = require("CopilotChat.select").visual }
				)
			end, { desc = "CopilotChat - Explain code" })
			vim.keymap.set("v", "<leader>cr", function()
				require("CopilotChat").ask(
					"Please review this code and provide suggestions for improvement.",
					{ selection = require("CopilotChat.select").visual }
				)
			end, { desc = "CopilotChat - Review code" })
			vim.keymap.set("v", "<leader>cf", function()
				require("CopilotChat").ask(
					"Please fix this code to make it work as intended.",
					{ selection = require("CopilotChat.select").visual }
				)
			end, { desc = "CopilotChat - Fix code" })
		end,
	},
}
