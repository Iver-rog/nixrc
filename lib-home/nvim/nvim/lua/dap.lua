local dap = require('nvim-dap')

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

require("nvim-dap-ui").setup()
