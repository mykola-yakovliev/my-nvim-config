return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
  config = function()
    local nvim_path = vim.fn.stdpath("config")
    local netcoredbg_path = nvim_path .. "/executables/netcoredbg/netcoredbg.exe"

    local dotnet = require('easy-dotnet')
    dotnet.setup({
      debugger = {
        bin_path = netcoredbg_path,
      }
    })

    require("easy-dotnet.netcoredbg").register_dap_variables_viewer()

    vim.keymap.set("n", "<leader>Dn", ':Dotnet<CR>', { noremap = true, silent = true })
  end
}
