return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		config = function()
			vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle<CR>")
			require("neo-tree").setup({
				filesystem = {
					filtered_items = {
						visible = true,
					},
					follow_current_file = {
						enabled = true,
						leave_dirs_open = false,
					},
					hijack_netrw_behavior = "open_current",
				},
				event_handlers = {
					{
						event = "file_open_requested",
						handler = function()
							require("neo-tree.command").execute({ action = "close" })
						end,
					},
				},
			})
		end,
	},
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = {
			{
				"<leader>yt",
        mode = { "n", "v" },
        "<cmd>Yazi toggle<cr>",
        desc = "Toggle Yazi",
			},
		},
	},
}
