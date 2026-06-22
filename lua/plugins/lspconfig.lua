return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
  },
  config = function ()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities
    })

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

    vim.lsp.enable({
      'pyright',
      'ts_ls',
      'clangd',
      'lua_ls',
    })

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
}
