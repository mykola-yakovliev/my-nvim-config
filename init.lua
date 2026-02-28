vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.wo.relativenumber = true
vim.wo.number = true

vim.api.nvim_create_user_command("MyConfig", function()
  vim.cmd.cd(vim.fn.stdpath("config"))
end, {})

-- Remove CLRF endings
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd([[silent! %s/\r//g]])
  end,
})

require("config.lazy")

