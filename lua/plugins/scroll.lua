return {
	{
		"karb94/neoscroll.nvim",
		opts = {
			mappings = { "<C-e>", "<C-y>", "zz" },
		},
	},
	{
		"petertriho/nvim-scrollbar",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"kevinhwang91/nvim-hlslens",
		},
		config = function()
			local scrollbar = require("scrollbar")

			scrollbar.setup({
				show_in_active_only = false,
				hide_if_all_visible = false,
				handle = {
					text = " ",
					blend = 0,
					highlight = "CursorLine",
				},
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
				handlers = {
					cursor = true,
					diagnostic = true,
					gitsigns = true,
					handle = true,
					search = true,
					ale = false,
				},
				excluded_buftypes = {
					"terminal",
					"nofile",
					"quickfix",
					"prompt",
				},
				excluded_filetypes = {
					"neo-tree",
					"alpha",
					"TelescopePrompt",
					"toggleterm",
					"lazy",
					"mason",
					"help",
				},
			})

			require("scrollbar.handlers.diagnostic").setup()
			require("scrollbar.handlers.gitsigns").setup()
			require("scrollbar.handlers.search").setup()

			local hlslens = require("hlslens")
			hlslens.setup({
				calm_down = true,
				nearest_only = false,
			})

			local map = vim.keymap.set
			local opts = { noremap = true, silent = true }

			map("n", "n", function()
				hlslens.start()
				vim.cmd("normal! " .. (vim.v.searchforward == 1 and "n" or "N"))
			end, opts)

			map("n", "N", function()
				hlslens.start()
				vim.cmd("normal! " .. (vim.v.searchforward == 1 and "N" or "n"))
			end, opts)

			map("n", "*", function()
				vim.fn.setreg("/", "\\<" .. vim.fn.expand("<cword>") .. "\\>")
				hlslens.start()
			end, opts)

			map("n", "#", function()
				vim.fn.setreg("/", "\\<" .. vim.fn.expand("<cword>") .. "\\>")
				hlslens.start()
			end, opts)
		end,
	},
}
