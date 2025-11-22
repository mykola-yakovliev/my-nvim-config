return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    local shell_prog = nil
    if vim.fn.executable("pwsh") == 1 then
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

    vim.keymap.set('t', '<leader>tq', [[<C-\><C-n>]], { noremap = true, silent = true })
    vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
    vim.keymap.set({ "n", "t" }, "<leader>ts", "<cmd>TermSelect<CR>", { noremap = true, silent = true })
    vim.keymap.set({ "n", "t" }, "<leader>tn", function()
      require("toggleterm.terminal").Terminal:new():toggle()
    end, { noremap = true, silent = true })
  end
}
