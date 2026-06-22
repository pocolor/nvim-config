return {
  -- Config definitions for all LSP servers (consumed by vim.lsp.config)
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      -- Capabilities from nvim-cmp (richer completion info sent to servers)
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Apply capabilities to ALL servers at once
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      -- Per-server overrides
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.config('pyright', {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'standard',
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      vim.lsp.config('clangd', {
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
          '--header-insertion=iwyu',
          '--completion-style=detailed',
        },
      })

      -- ts_ls (TypeScript/JavaScript) uses defaults from lspconfig

      -- Enable all servers
      -- Make sure these are installed via :MasonInstall
      -- pyright | ts_ls | clangd | lua_ls
      vim.lsp.enable({
        'pyright',
        'ts_ls',
        'clangd',
        'lua_ls',
      })

      -- Keymaps applied when any LSP attaches to a buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local buf = args.buf
          local map = function(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { buffer = buf, desc = desc })
          end

          map('gd',         vim.lsp.buf.definition,      'Go to definition')
          map('gD',         vim.lsp.buf.declaration,     'Go to declaration')
          map('gi',         vim.lsp.buf.implementation,  'Go to implementation')
          map('gr',         vim.lsp.buf.references,      'References')
          map('K',          vim.lsp.buf.hover,           'Hover docs')
          map('<leader>rn', vim.lsp.buf.rename,          'Rename symbol')
          map('<leader>ca', vim.lsp.buf.code_action,     'Code action')
          map('<leader>f',  vim.lsp.buf.format,          'Format buffer')
          map('[d',         vim.diagnostic.goto_prev,    'Prev diagnostic')
          map(']d',         vim.diagnostic.goto_next,    'Next diagnostic')
          map('<leader>d',  vim.diagnostic.open_float,   'Diagnostic float')
        end,
      })
    end,
  },

  -- Installs LSP server binaries
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    opts = {
      ui = {
        icons = {
          package_installed   = '✓',
          package_pending     = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
}
