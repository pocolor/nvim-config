return {
  -- Core DAP engine
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'nvim-neotest/nvim-nio',         -- async I/O required by dap-ui
      'rcarriga/nvim-dap-ui',          -- visual debugger UI
      'mfussenegger/nvim-dap-python',  -- Python adapter (uses debugpy)
      'jay-babu/mason-nvim-dap.nvim',  -- install debug adapters via Mason
    },
    keys = {
      { '<F5>',       function() require('dap').continue() end,          desc = 'Debug: continue' },
      { '<F10>',      function() require('dap').step_over() end,         desc = 'Debug: step over' },
      { '<F11>',      function() require('dap').step_into() end,         desc = 'Debug: step into' },
      { '<F12>',      function() require('dap').step_out() end,          desc = 'Debug: step out' },
      { '<leader>bp', function() require('dap').toggle_breakpoint() end, desc = 'Toggle breakpoint' },
      { '<leader>bc', function()
          require('dap').set_breakpoint(vim.fn.input('Condition: '))
        end, desc = 'Conditional breakpoint' },
      { '<leader>du', function() require('dapui').toggle() end,          desc = 'Toggle DAP UI' },
      { '<leader>dr', function() require('dap').repl.open() end,         desc = 'Open REPL' },
    },
    config = function()
      local dap    = require('dap')
      local dapui  = require('dapui')

      -- DAP UI setup
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = 'scopes',      size = 0.4 },
              { id = 'breakpoints', size = 0.2 },
              { id = 'stacks',      size = 0.2 },
              { id = 'watches',     size = 0.2 },
            },
            size = 40,
            position = 'left',
          },
          {
            elements = {
              { id = 'repl',    size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            size = 10,
            position = 'bottom',
          },
        },
      })

      -- Auto open/close UI with debug session
      dap.listeners.after.event_initialized['dapui_config']  = dapui.open
      dap.listeners.before.event_terminated['dapui_config']  = dapui.close
      dap.listeners.before.event_exited['dapui_config']      = dapui.close

      -- Python adapter
      -- Make sure debugpy is installed: pip install debugpy
      require('dap-python').setup('python')

      -- C/C++ via codelldb (install with :MasonInstall codelldb)
      dap.adapters.codelldb = {
        type    = 'server',
        port    = '${port}',
        executable = {
          command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
          args    = { '--port', '${port}' },
        },
      }

      dap.configurations.c = {
        {
          name    = 'Launch',
          type    = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd            = '${workspaceFolder}',
          stopOnEntry    = false,
        },
      }
      dap.configurations.cpp = dap.configurations.c

      -- Breakpoint signs
      vim.fn.sign_define('DapBreakpoint',          { text = '●', texthl = 'DapBreakpoint',      linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DapBreakpointCond',  linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped',             { text = '▶', texthl = 'DapStopped',          linehl = 'DapStoppedLine', numhl = '' })
    end,
  },

  -- Install debug adapters via Mason
  {
    'jay-babu/mason-nvim-dap.nvim',
    lazy = true,
    opts = {
      ensure_installed = { 'python', 'codelldb' },
      automatic_installation = true,
    },
  },
}
