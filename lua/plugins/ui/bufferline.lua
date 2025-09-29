return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	keys = {
		{ "gt", "<cmd>bnext<cr>", desc = "Next Buffer" },
		{ "gT", "<cmd>bprev<cr>", desc = "Prev Buffer" },
	},
	opts = {
		options = {
			mode = "buffers",
			separator_style = "slant",
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