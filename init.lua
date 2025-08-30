vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.api.nvim_create_user_command("MyConfig", function()
  vim.cmd("cd ~/AppData/Local/nvim")
end, {})

vim.api.nvim_create_user_command("Repos", function()
  vim.cmd("cd ~/source/repos")
end, {})

require("config.lazy")
