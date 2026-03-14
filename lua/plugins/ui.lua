return {
	-- Theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				background = { light = "latte", dark = "mocha" },
				transparent_background = false,
				term_colors = true,
				color_overrides = {
					mocha = {
						base = "#151616",
						mantle = "#121313",
						crust = "#0e0f0f",
					},
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = true,
					mini = { enabled = true },
					bufferline = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "undercurl" },
							hints = { "undercurl" },
							warnings = { "undercurl" },
							information = { "undercurl" },
						},
					},
					navic = { enabled = true, custom_bg = "NONE" },
					noice = true,
					aerial = true,
					telescope = true,
					which_key = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "auto",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				globalstatus = true,
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
				lualine_b = { "filename", "branch" },
				lualine_c = {
					"%=",
					{
						function()
							return require("nvim-navic").get_location()
						end,
						cond = function()
							return require("nvim-navic").is_available()
						end,
					},
				},
				lualine_x = { "diagnostics", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
			},
		},
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				mode = "buffers",
				diagnostics = "nvim_lsp",
				offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center", separator = true } },
				separator_style = "thin",
				hover = { enabled = true, delay = 200, reveal = { "close" } },
			},
		},
	},

	-- Notifications & UI
	{
		"rcarriga/nvim-notify",
		opts = { timeout = 3000, render = "wrapped-compact", stages = "fade" },
		config = function(_, opts)
			require("notify").setup(opts)
			vim.notify = require("notify")
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				lsp_doc_border = true,
			},
		},
	},
	{ "stevearc/dressing.nvim", opts = {} },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = { scope = { enabled = true } } },

	-- Dashboard
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.header.val = {
				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			}
			dashboard.section.buttons.val = {
				dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", "  Config", ":e ~/.config/nvim/lua/config/lazy.lua <CR>"),
				dashboard.button("q", "  Quit", ":qa<CR>"),
			}
			alpha.setup(dashboard.config)
		end,
	},

	-- Markdown Rendering
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},

	-- Symbols Outline
	{
		"stevearc/aerial.nvim",
		opts = {
			backends = { "treesitter", "lsp", "markdown", "man" },
			layout = { max_width = { 40, 0.2 }, default_direction = "right" },
			show_guides = true,
			filter_kind = false,
			on_attach = function(bufnr)
				-- Use non-conflicting mappings instead of overriding built-in { and }
				vim.keymap.set("n", "[a", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "]a", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
		},
	},

	{ "NvChad/nvim-colorizer.lua", opts = { user_default_options = { tailwind = true } } },

	-- VSCode-like Status Column
	{
		"luukvbaal/statuscol.nvim",
		event = "VeryLazy",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				-- Smooth alignment for relative numbers (if used)
				relculright = true,
				segments = {
					-- Segment 1: Folds (Leftmost, clickable)
					{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
					-- Segment 2: Signs (Git, Diagnostics)
					{ text = { "%s" }, click = "v:lua.ScSa" },
					-- Segment 3: Line Numbers (Padded for premium feel)
					{
						text = { builtin.lnumfunc, " " },
						condition = { true, builtin.not_empty },
						click = "v:lua.ScLa",
					},
				},
			})
		end,
	},
}
