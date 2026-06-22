return {
  -- Comment lines with gcc / gc (visual)
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts  = {},
  },

  -- Auto-close brackets, quotes, etc.
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts  = {
      check_ts = true, -- use treesitter to avoid pairing in comments/strings
    },
  },

  -- Add/change/delete surroundings: ys, cs, ds
  {
    'kylechui/nvim-surround',
    event   = { 'BufReadPost', 'BufNewFile' },
    version = '*',
    opts    = {},
  },

  -- Better diagnostics/quickfix list
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',                        desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',          desc = 'Buffer diagnostics' },
      { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>',               desc = 'Symbols (Trouble)' },
      { '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP (Trouble)' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<cr>',                            desc = 'Quickfix (Trouble)' },
    },
    opts = {},
  },

  -- Formatting engine
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    keys  = {
      { '<leader>cf', function() require('conform').format({ async = true, lsp_fallback = true }) end, desc = 'Format file' },
    },
    opts = {
      formatters_by_ft = {
        python     = { 'black', 'isort' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        lua        = { 'stylua' },
        c          = { 'clang_format' },
        cpp        = { 'clang_format' },
        json       = { 'prettier' },
        yaml       = { 'prettier' },
        markdown   = { 'prettier' },
      },
      -- Format on save (remove if you prefer manual formatting)
      format_on_save = {
        timeout_ms   = 500,
        lsp_fallback = true,
      },
    },
  },

  -- Linting engine (separate from LSP diagnostics)
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      local lint = require('lint')

      lint.linters_by_ft = {
        python     = { 'ruff' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
      }

      -- Run linters on save and after leaving insert mode
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- Utility library (required by many plugins)
  { 'nvim-lua/plenary.nvim', lazy = true },

  -- Icons (requires a Nerd Font in your terminal)
  { 'nvim-tree/nvim-web-devicons', lazy = true },
}
