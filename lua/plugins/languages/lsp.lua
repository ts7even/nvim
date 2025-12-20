return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- Bridge between mason and lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", -- Lua
					"bashls", -- Bash
					"clangd", -- C/C++
					"cssls", -- CSS
					"dockerls", -- Docker
					"gopls", -- Go
					"html", -- HTML
					"ts_ls", -- TypeScript/JavaScript
					-- "marksman",    -- Markdown
					"ruff", -- Python linting
					"pyright", -- Python type checking
					"svelte", -- Svelte
					"sqlls", -- SQL
					"taplo", -- TOML
					"vuels", -- Vue
					"yamlls", -- YAML
					"zls", -- Zig
				},
				automatic_installation = true, -- Auto-install missing servers
			})
		end,
	},

	-- Main LSP configuration (common setup)
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
			{ "williamboman/mason-lspconfig.nvim", config = function() end },
		},
		opts = function()
			local ret = {
				-- Diagnostic configuration
				diagnostics = {
					underline = true,
					update_in_insert = false,
					virtual_text = {
						spacing = 4,
						source = "if_many",
						prefix = "●",
					},
					severity_sort = true,
					signs = true,
				},
				-- Enable inlay hints
				inlay_hints = {
					enabled = true,
					exclude = { "vue" },
				},
				-- Enable code lenses
				codelens = {
					enabled = false,
				},
				-- Enable LSP folding
				folds = {
					enabled = true,
				},
				-- Format options
				format = {
					formatting_options = nil,
					timeout_ms = nil,
				},
				-- LSP Server Settings
				servers = {
					-- Configuration for all LSP servers
					["*"] = {
						capabilities = {
							workspace = {
								fileOperations = {
									didRename = true,
									willRename = true,
								},
							},
						},
						-- Global LSP keymaps
						keys = {
							{ "<leader>cl", function() Snacks.picker.lsp_config() end, desc = "LSP Info" },
							{ "<leader>gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
							{ "<leader>gr", function() Snacks.picker.lsp_references() end, desc = "References" },
							{ "<leader>gi", vim.lsp.buf.implementation, desc = "Goto Implementation" },
							{ "<leader>gy", vim.lsp.buf.type_definition, desc = "Goto Type Definition" },
							{ "<leader>gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
							{ "<leader>k", vim.lsp.buf.hover, desc = "Hover Documentation" },
							{ "<leader>gk", vim.lsp.buf.signature_help, desc = "Signature Help" },
							{ "<C-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
							{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "x" } },
							{ "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "x" } },
							{ "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens" },
							{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
							{ "<leader>dl", vim.diagnostic.open_float, desc = "Show Line Diagnostics" },
							{ "<leader>df", vim.diagnostic.setqflist, desc = "Show All Diagnostics" },
						},
					},
					-- Language-specific server configurations
					lua_ls = {
						settings = {
							Lua = {
								workspace = {
									checkThirdParty = false,
								},
								codeLens = {
									enable = true,
								},
								completion = {
									callSnippet = "Replace",
								},
								doc = {
									privateName = { "^_" },
								},
								hint = {
									enable = true,
									setType = false,
									paramType = true,
									paramName = "Disable",
									semicolon = "Disable",
									arrayIndex = "Disable",
								},
							},
						},
					},
					bashls = {},
					clangd = {},
					cssls = {},
					dockerls = {},
					gopls = {},
					html = {},
					ts_ls = {},
					ruff = {},
					pyright = {},
					svelte = {},
					sqlls = {},
					taplo = {},
					vuels = {},
					yamlls = {},
					zls = {},
				},
				setup = {},
			}
			return ret
		end,
		config = function(_, opts)
			-- Setup keymaps from server options
			for server, server_opts in pairs(opts.servers) do
				if type(server_opts) == "table" and server_opts.keys then
					for _, keymap in ipairs(server_opts.keys) do
						local key = keymap[1]
						local action = keymap[2]
						local kopts = {
							desc = keymap.desc,
							mode = keymap.mode or "n",
							silent = keymap.silent ~= false,
						}
						vim.keymap.set(kopts.mode, key, action, kopts)
					end
				end
			end

			-- Apply diagnostics configuration
			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			-- Configure all servers
			if opts.servers["*"] then
				vim.lsp.config("*", opts.servers["*"])
			end

			-- Setup individual servers
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			for server, server_opts in pairs(opts.servers) do
				if server ~= "*" and type(server_opts) == "table" then
					local config = vim.tbl_deep_extend("force", { capabilities = capabilities }, server_opts)
					vim.lsp.config[server](config)
				end
			end
		end,
	},

	-- Language Formatter Init 
	{
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo", "ConformEnable", "ConformDisable" },
        keys = {
            {
                "<leader>fc",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "Format code",
            },
        },
        opts = {
            -- Formatters are registered by language files
            formatters_by_ft = {},
            formatters = {},
            
            -- Format on save disabled
            -- Use <leader>fc to format manually
            -- Or enable with :ConformEnable
        },
        init = function()
            -- If you want to use conform for gq formatting
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
	{
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                auto_install = true, -- Automatically install parsers
                highlight = { enable = true }, -- Enable syntax highlighting
                indent = { enable = true }, -- Enable treesitter-based indentation
            })
        end,
    },

    -- Main completion engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
            "L3MON4D3/LuaSnip", -- Snippet engine
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif require("luasnip").expand_or_jumpable() then
                            require("luasnip").expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif require("luasnip").jumpable(-1) then
                            require("luasnip").jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- LSP completions
                    { name = "luasnip" }, -- Snippet completions
                }, {
                    { name = "buffer" }, -- Buffer completions
                }),
            })
        end,
    },

}
