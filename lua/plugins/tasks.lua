return {
	"stevearc/overseer.nvim",
	opts = {},
	config = function()
		require("overseer").setup()
		vim.keymap.set("n", "<leader>ot", ":OverseerToggle<CR>")
		vim.keymap.set("n", "<leader>or", ":OverseerRun<CR>")
		vim.keymap.set(
			"n",
			"<leader>oq",
			"<Cmd>OverseerQuickAction open float<CR>",
			{ desc = "Overseer: open last output" }
		)
	end,
}
