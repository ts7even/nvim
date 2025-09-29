return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	keys = {
		{ "gt", "<cmd>tabnext<cr>", desc = "Next Tab" },
		{ "gT", "<cmd>tabprevious<cr>", desc = "Prev Tab" },
	},
	opts = {
		options = {
				mode = "tabs",
			separator_style = "slant",
			-- Only show when there are multiple buffers
			always_show_bufferline = false,
			show_buffer_close_icons = false,
			show_close_icon = false,
			show_buffer_icons = true,
			show_tab_indicators = false,
			numbers = "none",
			color_icons = true,
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "left",
					separator = true,
				},
			},
		},
	},
}