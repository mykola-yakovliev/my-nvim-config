return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"qvalentin/helm-ls.nvim",
		},
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.enable("helm_ls")
			vim.lsp.config("helm_ls", {
				settings = {
					["helm-ls"] = {
						yamlls = {
							enabled = false,
						},
					},
				},
			})

			vim.lsp.enable("yamlls")
		end,
	},
	{
		"qvalentin/helm-ls.nvim",
		ft = "helm",
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "ts_ls", "jsonls", "terraformls", "angularls" },
		},
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
			"smjonas/inc-rename.nvim",
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
			require("inc_rename").setup()

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
					local tb = require("telescope.builtin")
					local bufnr = args.buf

					local function buf_opts(desc)
						return { buffer = bufnr, desc = desc }
					end

					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, buf_opts("Code Action"))

					vim.keymap.set("n", "gd", tb.lsp_definitions, buf_opts("Go to Definition"))
					vim.keymap.set("n", "gi", tb.lsp_implementations, buf_opts("Go to Implementation"))
					vim.keymap.set("n", "gt", tb.lsp_type_definitions, buf_opts("Go to Type Definition"))
					vim.keymap.set("n", "gr", tb.lsp_references, buf_opts("Go to References"))

					vim.keymap.set("n", "fr", function()
						require("telescope.builtin").lsp_references({
							include_declaration = false,
							show_line = true,
						})
					end, buf_opts("Find References"))

					vim.keymap.set("n", "<leader>dw", tb.diagnostics, buf_opts("Workspace Diagnostics"))
					vim.keymap.set("n", "<leader>dc", function()
						tb.diagnostics({ bufnr = 0 })
					end, buf_opts("Buffer Diagnostics"))
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, buf_opts("Previous Diagnostic"))
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, buf_opts("Next Diagnostic"))

					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover({ border = "rounded", max_width = 80, max_height = 20 })
					end, buf_opts("View Documentation"))

					vim.keymap.set("n", "<leader>rn", function()
						if vim.fn.exists(":IncRename") == 2 then
							return ":IncRename " .. vim.fn.expand("<cword>")
						else
							vim.lsp.buf.rename()
						end
					end, { buffer = bufnr, expr = true, desc = "Rename Symbol" })
				end,
			})
		end,
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "simple",
			})
			vim.diagnostic.config({ virtual_text = false })
		end,
	},
}
