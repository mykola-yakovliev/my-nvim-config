local function smart_preview()
	local ft = vim.bo.filetype
	local file = vim.api.nvim_buf_get_name(0)
	local ext = vim.fn.fnamemodify(file, ":e"):lower()

	if ft == "markdown" or ext == "md" or ft == "mermaid" or ext == "mmd" or ext == "mermaid" then
		require("lazy").load({ plugins = { "markdown-preview.nvim" } })
		vim.cmd("MarkdownPreview")
	elseif ft == "plantuml" or ext == "puml" or ext == "plantuml" or ext == "pu" or ext == "iuml" then
		require("lazy").load({ plugins = { "plantuml.nvim" } })
		vim.cmd("PlantumlLaunchBrowser")
	elseif ft == "svg" or ext == "svg" or ft == "html" or ext == "html" or ext == "htm" then
		require("lazy").load({ plugins = { "live-server.nvim" } })
		local ls = require("live_server")
		ls.start_picker()
	elseif file ~= "" then
		vim.ui.open(file)
	else
		vim.notify("No file to preview in current buffer", vim.log.levels.WARN)
	end
end

local function smart_preview_stop()
	local ft = vim.bo.filetype
	local file = vim.api.nvim_buf_get_name(0)
	local ext = vim.fn.fnamemodify(file, ":e"):lower()

	if ft == "markdown" or ext == "md" or ft == "mermaid" or ext == "mmd" or ext == "mermaid" then
		vim.cmd("MarkdownPreviewStop")
	elseif ft == "plantuml" or ext == "puml" or ext == "plantuml" or ext == "pu" then
		vim.cmd("PlantumlServerStop")
	elseif ft == "svg" or ext == "svg" or ft == "html" or ext == "html" then
		vim.cmd("LiveServerStopAll")
	end
end

vim.api.nvim_create_user_command("Preview", smart_preview, { desc = "Smart Preview for current file" })
vim.api.nvim_create_user_command("PreviewStop", smart_preview_stop, { desc = "Stop active preview server" })

vim.keymap.set("n", "<leader>op", smart_preview, { desc = "Open Preview (MD, Mermaid, PlantUML, SVG)" })
vim.keymap.set("n", "<leader>oq", smart_preview_stop, { desc = "Stop Preview" })

return {
	{
		"selimacerbas/markdown-preview.nvim",
		dependencies = { "selimacerbas/live-server.nvim" },
		ft = { "markdown", "mermaid", "mmd" },
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewRefresh" },
		opts = {
			instance_mode = "takeover",
			open_browser = true,
			default_theme = "dark",
			debounce_ms = 300,
		},
	},
	{
		"selimacerbas/live-server.nvim",
		cmd = {
			"LiveServerStart",
			"LiveServerStop",
			"LiveServerStopAll",
			"LiveServerReload",
			"LiveServerOpen",
			"LiveServerStatus",
		},
		opts = {
			open_browser = true,
		},
	},
	{
		"charlesnicholson/plantuml.nvim",
		ft = { "plantuml", "puml" },
		cmd = { "PlantumlLaunchBrowser", "PlantumlUpdate", "PlantumlServerStart", "PlantumlServerStop" },
		opts = {
			auto_launch_browser = "never",
		},
	},
	{
		"aklt/plantuml-syntax",
		ft = { "plantuml", "puml" },
	},
}
