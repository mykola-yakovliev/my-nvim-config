return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope-ui-select.nvim",
			"jvgrootveld/telescope-zoxide",
			"nvim-telescope/telescope-live-grep-args.nvim",
			"olimorris/persisted.nvim",
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					file_ignore_patterns = { "node_modules", "%.git", "bin", "obj", ".terraform", "%.angular/" },
					path_display = { "smart" },
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							width = 0.9,
							height = 0.9,
							preview_width = 0.6,
						},
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						no_ignore = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					zoxide = {
						prompt_title = "Select location",
					},
					persisted = {},
				},
			})

			telescope.load_extension("ui-select")
			telescope.load_extension("zoxide")
			telescope.load_extension("live_grep_args")
			telescope.load_extension("persisted")

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<C-f>", telescope.extensions.live_grep_args.live_grep_args)
			vim.keymap.set("n", "<C-z>", telescope.extensions.zoxide.list)

			vim.api.nvim_create_autocmd("User", {
				pattern = "TelescopePreviewerLoaded",
				callback = function(args)
					vim.wo.number = true
					vim.wo.relativenumber = false
				end,
			})
		end,
	},
}
