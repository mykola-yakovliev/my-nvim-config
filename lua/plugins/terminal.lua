return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local shell_prog = nil

		-- Linux
		if vim.fn.executable("bash") == 1 then
			shell_prog = "bash"
		elseif vim.fn.executable("sh") == 1 then
			shell_prog = "sh"

		-- Windows
		elseif vim.fn.executable("pwsh") == 1 then
			shell_prog = "pwsh.exe"
		elseif vim.fn.executable("powershell") == 1 then
			shell_prog = "powershell.exe"
		else
			-- fallback, e.g. cmd.exe
			shell_prog = "cmd.exe"
		end

		require("toggleterm").setup({
			shell = shell_prog,
			start_in_insert = true,
			direction = "horizontal",
			size = 20,
			close_on_exit = true,
		})

		local Terminal = require("toggleterm.terminal").Terminal

		vim.keymap.set("t", "<leader>tq", [[<C-\><C-n>]], { noremap = true, silent = true })
		vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
		vim.keymap.set({ "n", "t" }, "<leader>ts", "<cmd>TermSelect<CR>", { noremap = true, silent = true })
		vim.keymap.set({ "n", "t" }, "<leader>tn", function()
			Terminal:new():toggle()
		end, { noremap = true, silent = true })

		local function create_terminal(cmd)
			return require("toggleterm.terminal").Terminal:new({
				cmd = cmd,
				hidden = true,
				direction = "float",
				float_opts = {
					border = "rounded",
				},
			})
		end

		local lazygit = create_terminal("lazygit")
		local lazydocker = create_terminal("lazydocker")

		vim.keymap.set("n", "<leader>lg", function()
			lazygit:toggle()
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "<leader>ld", function()
			lazydocker:toggle()
		end, { noremap = true, silent = true })

		vim.api.nvim_create_autocmd("DirChanged", {
			callback = function()
				lazygit = create_terminal("lazygit")
				lazydocker = create_terminal("lazydocker")
			end,
			desc = "Re-create terminal instances when workspace changes",
		})
	end,
}
