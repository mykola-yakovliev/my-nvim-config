return {
	{
		"kevinhwang91/nvim-hlslens",
		lazy = false,
		config = function()
			local hlslens = require("hlslens")
			hlslens.setup({
				calm_down = true,
				nearest_only = false,
			})

			local map = vim.keymap.set
			local opts = { noremap = true, silent = true }

			map("n", "n", function()
				hlslens.start()
				vim.cmd("normal! " .. (vim.v.searchforward == 1 and "n" or "N"))
			end, opts)

			map("n", "N", function()
				hlslens.start()
				vim.cmd("normal! " .. (vim.v.searchforward == 1 and "N" or "n"))
			end, opts)

			map("n", "*", function()
				vim.fn.setreg("/", "\\<" .. vim.fn.expand("<cword>") .. "\\>")
				hlslens.start()
			end, opts)

			map("n", "#", function()
				vim.fn.setreg("/", "\\<" .. vim.fn.expand("<cword>") .. "\\>")
				hlslens.start()
			end, opts)
		end,
	},
}
