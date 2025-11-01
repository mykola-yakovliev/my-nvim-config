return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio"
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    local nvim_path = vim.fn.stdpath("config")

    local function get_project_name()
      return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    end

    local function get_target_framework()
      local csproj = vim.fn.glob("*.csproj")
      local framework

      if csproj ~= "" then
        local lines = vim.fn.readfile(csproj)
        for _, line in ipairs(lines) do
          framework = line:match("<TargetFramework>(.+)</TargetFramework>")
          if framework then break end
        end
      end

      local bin_debug_path = vim.fn.getcwd() .. "/bin/Debug"

      -- If framework was not found in csproj
      if not framework then
        if vim.fn.isdirectory(bin_debug_path) == 1 then
          local dirs = vim.fn.glob(bin_debug_path .. "/*", 0, 1)
          if #dirs == 1 then
            framework = vim.fn.fnamemodify(dirs[1], ":t")
          else
            framework = vim.fn.input("Could not detect framework. Enter target framework (e.g., net8.0): ")
          end
        else
          framework = vim.fn.input("Could not detect framework. Enter target framework (e.g., net8.0): ")
        end
      end

      return framework
    end

    local netcoredbg_path = nvim_path .. "/executables/netcoredbg/netcoredbg.exe"

    dap.adapters.coreclr = {
      type = 'executable',
      command = netcoredbg_path,
      args = { '--interpreter=vscode' }
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          local project_name = get_project_name()
          local framework = get_target_framework()
          local dll_path = string.format("%s/bin/Debug/%s/%s.dll", vim.fn.getcwd(), framework, project_name)
          return dll_path
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

    vim.keymap.set('n', '<F5>', function() dap.continue() end)
    vim.keymap.set('n', '<F10>', function() dap.step_over() end)
    vim.keymap.set('n', '<F11>', function() dap.step_into() end)
    vim.keymap.set('n', '<F12>', function() dap.step_out() end)
    vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
  end
}
