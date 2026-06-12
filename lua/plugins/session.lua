return {
	"olimorris/persisted.nvim",
	event = "BufReadPre",
	opts = {
		autoload = true,
		should_save = function()
			-- Do not save if the alpha dashboard is the current filetype
			if vim.bo.filetype == "alpha" then
				return false
			end
			return true
		end,
	},
}
