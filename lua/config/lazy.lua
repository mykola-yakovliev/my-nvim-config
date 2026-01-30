-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
local lazy = require("lazy")

lazy.setup({
	spec = {
		{ import = "plugins" },
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = false },
})

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		lazy.check({ show = false })
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyCheck",
	callback = function()
    local count = (require("lazy.status").updates() or 0)
    if count > 0 then
      vim.notify("Detected " .. count .. " plugin(s) ready for update. Updating...", vim.log.levels.INFO)
      lazy.update({ show = false })
		end
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyUpdate",
	once = true,
	callback = function()
		vim.notify("Plugins updated.", vim.log.levels.INFO)
	end,
})
