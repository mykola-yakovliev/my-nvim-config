return {
	"ellisonleao/dotenv.nvim",
	lazy = false,
	config = function()
		require("dotenv").setup()

		local function load_env_for_cwd()
			local env = (vim.uv or vim.loop).cwd() .. "/.env"
			if (vim.uv or vim.loop).fs_stat(env) then
				vim.cmd("silent! Dotenv " .. vim.fn.fnameescape(env))
			end
		end

		vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
			callback = load_env_for_cwd,
		})
	end,
}
