return {
  {
    'akinsho/toggleterm.nvim',
    keys = {
      { '<C-\\>',     desc = 'Toggle terminal' },
      { '<leader>tg', desc = 'Lazygit' },
      { '<leader>tf', desc = 'Float terminal' },
      { '<leader>th', desc = 'Horizontal terminal' },
      { '<leader>tv', desc = 'Vertical terminal' },
    },
    config = function()
      require('toggleterm').setup({
        size              = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return math.floor(vim.o.columns * 0.4)
          end
        end,

        open_mapping      = [[<C-\>]],
        hide_numbers      = true,
        shade_terminals   = false,
        start_in_insert   = true,
        insert_mappings   = true, -- <C-\> works in insert mode too
        terminal_mappings = true,
        persist_size      = true,
        direction         = 'float',
        close_on_exit     = true,
        shell             = vim.o.shell,

        float_opts        = {
          border   = 'curved',
          winblend = 0, -- 0 = respect terminal transparency
        },
      })

      -- Lazygit integration
      local Terminal = require('toggleterm.terminal').Terminal

      local lazygit = Terminal:new({
        cmd        = 'lazygit',
        hidden     = true,
        direction  = 'float',
        float_opts = { border = 'curved' },
        on_open    = function(term)
          vim.cmd('startinsert!')
          vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = term.bufnr, silent = true })
        end,
      })

      vim.keymap.set('n', '<leader>tg', function() lazygit:toggle() end, { desc = 'Lazygit' })
      vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = 'Float terminal' })
      vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = 'Horizontal terminal' })
      vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', { desc = 'Vertical terminal' })

      -- Escape terminal mode with Esc
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      vim.api.nvim_create_autocmd('TermOpen', {
        pattern  = 'term://*',
        callback = function() _G.set_terminal_keymaps() end,
      })
    end,
  },
}
