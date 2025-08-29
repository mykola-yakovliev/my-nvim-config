return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.install').prefer_git = false

      require("nvim-treesitter.configs").setup({
        -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
        ensure_installed = {
          "lua",
          "vim",
        },

        sync_install = false,
        auto_install = true,

        highlight = {
          enable = true,
        },

        indent = { enable = true },
      })
    end,
  },
}

