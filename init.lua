vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.wo.relativenumber = true
vim.wo.number = true

vim.api.nvim_create_user_command("MyConfig", function()
  vim.cmd.cd(vim.fn.stdpath("config"))
end, {})

vim.api.nvim_create_user_command("MyLogs", function()
  vim.cmd.cd(vim.fn.stdpath("data"))
end, {})

require("config.lazy")

