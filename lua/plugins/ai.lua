return {
	{
		"github/copilot.vim",
		init = function()
			vim.g.copilot_assume_mapped = true
			vim.g.copilot_no_tab_map = true
		end,
		config = function()
			vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})
			vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)")
			vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)")
			vim.keymap.set("i", "<C-h>", "<Plug>(copilot-dismiss)")
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		version = "^18.0.0",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ravitemer/mcphub.nvim",
		},
		config = function()
			require("mcphub").setup()
			require("codecompanion").setup({
				extensions = {
					mcphub = {
						callback = "mcphub.extensions.codecompanion",
						opts = {
							make_vars = true,
							make_slash_commands = true,
							show_result_in_chat = true,
						},
					},
				},
				display = {
					action_palette = {
						width = 95,
						height = 10,
						prompt = "Prompt ",
						provider = "telescope",
						opts = {
							show_preset_actions = true,
							show_preset_prompts = true,
							title = "CodeCompanion actions",
						},
					},
				},
			})

			vim.keymap.set(
				"n",
				"<leader>Ct",
				"<Cmd>CodeCompanionChat Toggle<CR>",
				{ desc = "Toggle AI chat" }
			)
			vim.keymap.set(
				"n",
				"<leader>Ca",
				"<Cmd>CodeCompanionActions<CR>",
				{ desc = "Show CodeCompanion Actions" }
			)
		end,
	},
}
