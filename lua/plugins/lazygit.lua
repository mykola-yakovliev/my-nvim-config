return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    vim.g.lazygit_floating_window_use_plenary = 1
  end
}
