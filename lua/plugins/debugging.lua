return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		local state = {}

		local function get_runnable_projects()
			local projects = {}

			for _, csproj in ipairs(vim.fn.glob("**/*.csproj", 1, 1)) do
				local content = table.concat(vim.fn.readfile(csproj), "\n")
				if
					content:match("<OutputType>Exe</OutputType>")
					or content:match('<Project Sdk="Microsoft.NET.Sdk.Web">')
				then
					local dir = vim.fn.fnamemodify(csproj, ":h")
					local relative_path = vim.fn.fnamemodify(dir, ":.")

					table.insert(projects, relative_path)
				end
			end

			return projects
		end

		local function get_target_framework(project_dir, callback)
			local bin_debug_path = project_dir .. "/bin/Debug"
			local frameworks = {}

			if vim.fn.isdirectory(bin_debug_path) == 1 then
				for _, dir in ipairs(vim.fn.glob(bin_debug_path .. "/*", 0, 1)) do
					if vim.fn.isdirectory(dir) == 1 then
						table.insert(frameworks, vim.fn.fnamemodify(dir, ":t"))
					end
				end
			end

			if #frameworks == 0 then
				local csproj = vim.fn.glob(project_dir .. "/*.csproj")
				if csproj ~= "" then
					local lines = vim.fn.readfile(csproj)
					for _, line in ipairs(lines) do
						local fw = line:match("<TargetFramework>(.+)</TargetFramework>")
						if fw then
							table.insert(frameworks, fw)
							break
						end
					end
				end
			end

			if #frameworks == 0 then
				vim.ui.input({
					prompt = "Could not detect TargetFramework for "
						.. project_dir
						.. ". Enter target framework (e.g. net8.0): ",
				}, function(input)
					if input ~= nil and input ~= "" then
						callback(input)
					else
						callback(nil)
					end
				end)
			elseif #frameworks == 1 then
				callback(frameworks[1])
			else
				vim.ui.select(frameworks, { prompt = "Select Target Framework:" }, function(choice)
					callback(choice)
				end)
			end
		end

		local function get_dll_path(project_dir, framework)
			local project_name = vim.fn.fnamemodify(project_dir, ":t")

			return project_dir .. "/bin/Debug/" .. framework .. "/" .. project_name .. ".dll"
		end

		dap.adapters.coreclr = {
			type = "executable",
			command = "netcoredbg",
			args = { "--interpreter=vscode" },
		}

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "Launch debugger (DAP)",
				request = "launch",
				program = function()
					if not state.dll_path then
						vim.notify("No project selected. Cannot start debugger!", vim.log.levels.ERROR)
						return nil
					end

					return vim.fn.getcwd() .. "/" .. state.dll_path
				end,
			},
		}

		dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<F5>", function()
			dap.continue()
		end)
		vim.keymap.set("n", "<F10>", function()
			dap.step_over()
		end)
		vim.keymap.set("n", "<F11>", function()
			dap.step_into()
		end)
		vim.keymap.set("n", "<F12>", function()
			dap.step_out()
		end)
		vim.keymap.set("n", "<Leader>db", function()
			dap.toggle_breakpoint()
		end)

		vim.api.nvim_create_user_command("SetStartupProject", function()
			local projects = get_runnable_projects()

			vim.ui.select(projects, { prompt = "Select project" }, function(project_path)
				if project_path then
					get_target_framework(project_path, function(target_framework)
						if target_framework then
							state.dll_path = get_dll_path(project_path, target_framework)
						else
							vim.notify("No target framework selected.", vim.log.levels.ERROR)
						end
					end)
				end
			end)
		end, { desc = "Select startup project" })
	end,
}
