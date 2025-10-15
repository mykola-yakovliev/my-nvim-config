return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "ts_ls", "jsonls", "terraformls", "angularls", "omnisharp" },
    },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local bufmap = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          -- Code Actions
          bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          bufmap("v", "<leader>ca", vim.lsp.buf.code_action, "Code Action (Visual)")

          -- Other useful LSP keymaps
          bufmap("n", "gd", vim.lsp.buf.definition, "Go to Definition")
          bufmap("n", "K", vim.lsp.buf.hover, "Hover Documentation")
          bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
          bufmap("n", "gr", vim.lsp.buf.references, "Find References")

          bufmap("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
          bufmap("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
        end,
      })
    end,
  },
}

