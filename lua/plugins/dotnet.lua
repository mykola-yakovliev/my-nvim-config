return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
  config = function()
    require("easy-dotnet").setup()

    vim.keymap.set("n", "<leader>Dn", ':Dotnet<CR>', { noremap = true, silent = true })
  end
}
