return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules", "%.git", "bin", "obj" },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true
          }
        }
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<C-f>", builtin.live_grep, { desc = "Telescope live grep" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({})
          }
        },
      })

      telescope.load_extension("ui-select")
    end,
  },
}
