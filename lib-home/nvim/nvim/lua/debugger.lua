local dap, dapui = require("dap"), require("dapui")
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
-- local dap = require('dap')
-- local ui = require "dapui"

dap.adapters.debugpy = {
  type = 'executable';
  command = 'python';
  -- command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python';
  args = { '-m', 'debugpy.adapter' };
}

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = '/usr/bin/codelldb',
    args = {"--port", "${port}"},
  }
}

dap.adapters.codelldb = {
    type = "server",
    host = "127.0.0.1",
    port = "${port}",

    executable = {
        command = "${pkgs.lldb}/out/lldb",
        -- command = "~/.local/share/nvim/mason/packages/codelldb",
        -- command = "/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb",
        args = { "--port", "${port}" },
    },
}

dap.configurations.rust = {
  {
    name = "Rust debug",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    showDisassembly = "never",
  },
}
require("dapui").setup()

