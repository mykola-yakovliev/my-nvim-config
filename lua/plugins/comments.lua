return {
	"numToStr/Comment.nvim",
	opts = {},
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "bicep",
			callback = function()
				vim.bo.commentstring = "// %s"
			end,
		})
	end,
}
