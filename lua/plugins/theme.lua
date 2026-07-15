return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          treesitter = true,
          telescope = true,
        },
        custom_highlights = function(colors)
          return {
            ["@lsp.type.class.cs"] = { fg = colors.yellow },
            ["@lsp.type.interface.cs"] = { fg = colors.green },
            ["@lsp.type.namespace.cs"] = { fg = colors.lavender },
            ["@lsp.type.struct.cs"] = { fg = colors.peach },
            ["@lsp.type.enum.cs"] = { fg = colors.teal },
            ["@lsp.type.enumMember.cs"] = { fg = colors.flamingo },
            ["@lsp.type.typeParameter.cs"] = { fg = colors.maroon },
            ["@lsp.type.recordClass.cs"] = { fg = colors.rosewater },
            ["@lsp.type.recordStruct.cs"] = { fg = colors.sapphire },
            ["@lsp.type.extensionMethod.cs"] = { fg = colors.blue },
            ["@lsp.type.delegate.cs"] = { fg = colors.mauve },
            ["@lsp.type.field.cs"] = { fg = colors.subtext1 },
            ["@lsp.type.constant.cs"] = { fg = colors.red },
            ["@lsp.type.controlKeyword.cs"] = { fg = colors.sky },
            ["@lsp.type.operatorOverloaded.cs"] = { fg = colors.pink },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin-nvim")
    end,
  },
}

