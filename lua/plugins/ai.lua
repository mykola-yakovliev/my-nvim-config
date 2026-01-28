return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<C-l>",
						next = "<C-j>",
						prev = "<C-k>",
						dismiss = "<C-h>",
					},
				},
				panel = {
					enabled = false,
				},
				disable_limit_reached_message = true,
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
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
				adapters = {
					http = {
						my_ai_hub = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								env = {
									url = vim.env.AI_HUB_URL,
									api_key = vim.env.AI_API_KEY,
								},
							})
						end,
					},
				},
				interactions = {
					chat = {
						adapter = {
							name = "my_ai_hub",
							model = "claude-haiku-*",
						},
					},
					inline = {
						adapter = {
							name = "my_ai_hub",
							model = "gpt-4.1-mini",
						},
					},
					cmd = {
						adapter = {
							name = "my_ai_hub",
							model = "gemini-2.5-pro",
						},
					},
				},
			})

			vim.keymap.set("n", "<leader>Ct", "<Cmd>CodeCompanionChat Toggle<CR>", { desc = "Toggle AI chat" })
			vim.keymap.set("n", "<leader>Ca", "<Cmd>CodeCompanionActions<CR>", { desc = "Show CodeCompanion Actions" })
		end,
	},
}
