return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true
          }
        }
      }
    })

    vim.keymap.set("n", "<C-h>", ':bp<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<C-l>", ':bn<CR>', { noremap = true, silent = true })

    vim.keymap.set("n", "<leader>bd", ':bd<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>bc", ':BufferLineCloseOthers<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>bs", ':BufferLinePick<CR>', { noremap = true, silent = true })
  end
}
