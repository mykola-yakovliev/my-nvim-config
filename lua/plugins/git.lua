return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local gs = require("gitsigns")

			gs.setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signs_staged = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = false,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 400,
				},
				on_attach = function(bufnr)
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
					end

					-- Hunk navigation
					map("n", "]h", function()
						gs.nav_hunk("next")
					end, "Next Git Hunk")
					map("n", "[h", function()
						gs.nav_hunk("prev")
					end, "Prev Git Hunk")

					-- Stage / reset hunks
					map("n", "<leader>Gs", gs.stage_hunk, "Git Stage Hunk")
					map("n", "<leader>Gr", gs.reset_hunk, "Git Reset Hunk")
					map("v", "<leader>Gs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, "Git Stage Selected Hunk")
					map("v", "<leader>Gr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, "Git Reset Selected Hunk")

					-- Preview hunk inline
					map("n", "<leader>Gp", gs.preview_hunk_inline, "Git Preview Hunk Inline")

					-- Blame
					map("n", "<leader>Gb", gs.blame, "Git Blame")
					map("n", "<leader>Gt", gs.toggle_current_line_blame, "Git Toggle Blame for current line")

					-- Git history for current file (via Telescope)
					map("n", "<leader>Gh", function()
						require("telescope.builtin").git_bcommits({
							prompt_title = "Git File History",
						})
					end, "Git File History")

					-- Toggle inline diff (word diff in buffer)
					map("n", "<leader>Gd", gs.toggle_word_diff, "Git Toggle Inline Diff")
				end,
			})

			-- Close blame panel with q when focused inside it
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "gitsigns-blame",
				callback = function(ev)
					vim.keymap.set("n", "q", "<cmd>close<cr>", {
						buffer = ev.buf,
						silent = true,
						desc = "Close Git Blame",
					})
				end,
			})
		end,
	},
}
