return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope-ui-select.nvim",
      "jvgrootveld/telescope-zoxide",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules", "%.git", "bin", "obj", ".terraform", "%.angular/" },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({})
          },
          zoxide = {
            prompt_title = "Select location",
          }
        },
      })

      telescope.load_extension("ui-select")
      telescope.load_extension("zoxide")
      telescope.load_extension("live_grep_args")

      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<C-f>", telescope.extensions.live_grep_args.live_grep_args)
      vim.keymap.set("n", "<C-z>", telescope.extensions.zoxide.list)
    end,
  },
}
