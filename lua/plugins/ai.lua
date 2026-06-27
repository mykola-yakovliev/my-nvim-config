return {
	{
		"nickjvandyke/opencode.nvim",
		version = "*",
		config = function()
			vim.o.autoread = true -- Required for event-based reload

			local opencode_term = require("toggleterm.terminal").Terminal:new({
				cmd = "opencode",
				hidden = true,
				direction = "vertical",
				on_open = function()
					vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.5))
				end,
			})

			vim.keymap.set({ "n", "t" }, "<leader>Oc", function()
				opencode_term:toggle()
			end, { desc = "Toggle opencode" })
			vim.keymap.set({ "n", "x" }, "<leader>Oa", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode…" })
			vim.keymap.set({ "n", "x" }, "<leader>Oe", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })
		end,
	},
}
