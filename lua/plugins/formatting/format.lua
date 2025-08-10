return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					-- Lua formatter
					null_ls.builtins.formatting.stylua,

					-- C/C++ formatter
					null_ls.builtins.formatting.clang_format.with({
						extra_args = {
							"--style={IndentWidth: 4, UseTab: Never, TabWidth: 4, BreakBeforeBraces: Allman, ColumnLimit: 100, IndentCaseLabels: true, AlignConsecutiveAssignments: false, AlignConsecutiveDeclarations: false}",
						},
					}),

					-- JavaScript/TypeScript formatter
					null_ls.builtins.formatting.prettier.with({
						filetypes = { "javascript", "typescript", "json" },
					}),

					-- Markdown formatters
					null_ls.builtins.formatting.mdformat.with({
						filetypes = { "markdown" },
						extra_args = { "--wrap", "100" },
					}),
					null_ls.builtins.formatting.markdownlint.with({
						extra_args = {
							"--disable",
							"MD022",
							"--disable",
							"MD012",
							"--disable",
							"MD013",
							"--disable",
							"MD033",
						},
					}),
					null_ls.builtins.diagnostics.markdownlint.with({
						extra_args = {
							"--disable",
							"MD022",
							"--disable",
							"MD012",
							"--disable",
							"MD013",
							"--disable",
							"MD033",
						},
					}),

					-- Other formatters
					null_ls.builtins.formatting.cmake_format, -- CMake
					null_ls.builtins.formatting.sqlfmt, -- SQL
					null_ls.builtins.formatting.yamlfmt, -- YAML

					-- Spell checking
					null_ls.builtins.completion.spell,
				},
			})
		end,
	},
}
