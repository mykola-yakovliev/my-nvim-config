return {
	{
		"karb94/neoscroll.nvim",
		opts = {
			mappings = { "<C-e>", "<C-y>", "zz" },
		},
	},
	{
		"petertriho/nvim-scrollbar",
		branch = "refactor/v2",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			require("scrollbar").setup({
				marks = {
					Cursor = { text = "—", priority = 0, highlight = "ScrollbarCursor" },
					Search = { text = { "=", "≡" }, priority = 1 },
					Error = { text = { "●" }, priority = 2 },
					Warn = { text = { "●" }, priority = 3 },
					Info = { text = { "●" }, priority = 4 },
					Hint = { text = { "●" }, priority = 5 },
					Misc = { priority = 6 },
					GitAdd = { text = "│", priority = 7 },
					GitChange = { text = "│", priority = 7 },
					GitDelete = { text = "_", priority = 7 },
				},
				providers = {
					cursor = true,
					diagnostic = true,
					gitsigns = true,
					search = true,
					ale = false,
				},
				exclude = {
					buftypes = { "terminal", "nofile", "quickfix", "prompt" },
					filetypes = {
						"neo-tree",
						"alpha",
						"TelescopePrompt",
						"toggleterm",
						"lazy",
						"mason",
						"help",
					},
				},
				scrollbar = {
					visibility = "all",
					hide_if_all_visible = false,
					thumb = {
						text = " ",
						blend = 0,
						highlight = "CursorLine",
						hide_if_all_visible = false,
					},
				},
			})
		end,
	},
}
