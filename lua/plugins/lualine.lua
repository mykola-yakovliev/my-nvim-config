return {
	"nvim-lualine/lualine.nvim",
	opts = function()
		local job_indicator = require("easy-dotnet.ui-modules.jobs").lualine

		return {
			options = {
				theme = "dracula",
			},
			sections = {
				lualine_a = { "mode", job_indicator },
				lualine_z = { "%l/%L" },
			},
		}
	end,
}
