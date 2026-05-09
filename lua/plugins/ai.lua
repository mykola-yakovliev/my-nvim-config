return {
	{
		"olimorris/codecompanion.nvim",
		version = "^18.0.0",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ravitemer/mcphub.nvim",
			"franco-ruggeri/codecompanion-spinner.nvim",
		},
		config = function()
			require("mcphub").setup()
			require("codecompanion").setup({
				prompt_library = {
					markdown = {
						dirs = {
							vim.fn.getcwd() .. "/.prompts", -- Can be relative
						},
					},
				},
				extensions = {
					mcphub = {
						callback = "mcphub.extensions.codecompanion",
						opts = {
							make_vars = true,
							make_slash_commands = true,
							show_result_in_chat = true,
						},
					},
					spinner = {},
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
							model = vim.env.AI_CHAT_MODEL,
						},
					},
					inline = {
						adapter = {
							name = "my_ai_hub",
							model = vim.env.AI_INLINE_MODEL,
						},
					},
					cmd = {
						adapter = {
							name = "my_ai_hub",
							model = vim.env.AI_CMD_MODEL,
						},
					},
				},
			})

			vim.keymap.set("n", "<leader>Ct", "<Cmd>CodeCompanionChat Toggle<CR>", { desc = "Toggle AI chat" })
			vim.keymap.set("n", "<leader>Ca", "<Cmd>CodeCompanionActions<CR>", { desc = "Show CodeCompanion Actions" })
		end,
	},
	{
		"nickjvandyke/opencode.nvim",
		version = "*",
		config = function()
			vim.o.autoread = true -- Required for event-based reload

			-- Configure opencode options
			vim.g.opencode_opts = {
				ui = {
					persist_state = true,
				},
			}

      vim.keymap.set({ "n", "t" }, "<leader>Oc", function()
        require("opencode").toggle()
      end, { desc = "Toggle opencode" })
			vim.keymap.set({ "n", "x" }, "<leader>Oa", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode…" })
			vim.keymap.set({ "n", "x" }, "<leader>Oe", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })

			-- vim.keymap.set("n", "<S-C-u>", function()
			-- 	require("opencode").command("session.half.page.up")
			-- end, { desc = "Scroll opencode up" })
			-- vim.keymap.set("n", "<S-C-d>", function()
			-- 	require("opencode").command("session.half.page.down")
			-- end, { desc = "Scroll opencode down" })
		end,
	},
}
