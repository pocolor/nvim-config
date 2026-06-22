return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'lua', 'python', 'javascript', 'typescript',
          'c', 'cpp', 'tsx', 'json', 'yaml', 'toml',
          'markdown', 'markdown_inline', 'bash', 'vim', 'vimdoc',
        },

        auto_install = true,  -- install missing parsers automatically on open

        highlight = {
          enable = true,
          -- Disable for very large files to avoid lag
          disable = function(_, buf)
            local max_filesize = 500 * 1024 -- 500 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then return true end
          end,
        },

        indent = { enable = true },

        -- Select/move by semantic units (functions, classes, arguments, etc.)
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- jump forward to next match
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
            },
          },

          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']f'] = '@function.outer',
              [']c'] = '@class.outer',
            },
            goto_prev_start = {
              ['[f'] = '@function.outer',
              ['[c'] = '@class.outer',
            },
          },

          swap = {
            enable = true,
            swap_next     = { ['<leader>sp'] = '@parameter.inner' },
            swap_previous = { ['<leader>sP'] = '@parameter.inner' },
          },
        },
      })
    end,
  },
}
