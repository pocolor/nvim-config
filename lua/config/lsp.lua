vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.config('lua_ls', {
  settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
})

vim.lsp.enable({ 'pyright', 'ts_ls', 'clangd', 'lua_ls' })
