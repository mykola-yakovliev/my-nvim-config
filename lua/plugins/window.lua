return {
	{
		"yorickpeterse/nvim-window",
		keys = {
			{ "<leader>wj", "<cmd>lua require('nvim-window').pick()<cr>", desc = "nvim-window: Jump to window" },
		},
		config = true,
	},
	{
		"declancm/maximize.nvim",
		config = {
			plugins = {
				dapui = {
					enable = true,
				},
			},
		},
		keys = {
			{
				"<leader>wm",
				"<cmd>Maximize<cr>",
				desc = "Maximize window",
			},
		},
	},
}
