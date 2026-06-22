return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        -- C-based sorter, much faster than the default
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
      -- Replaces vim.ui.select with a telescope picker (used by LSP code actions etc.)
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      local telescope = require('telescope')
      local actions   = require('telescope.actions')

      telescope.setup({
        defaults = {
          prompt_prefix   = ' ',
          selection_caret = ' ',
          path_display    = { 'smart' },

          mappings = {
            i = {
              ['<C-j>']    = actions.move_selection_next,
              ['<C-k>']    = actions.move_selection_previous,
              ['<C-q>']    = actions.send_to_qflist + actions.open_qflist,
              ['<Esc>']    = actions.close,
            },
          },

          file_ignore_patterns = {
            'node_modules', '.git/', '__pycache__', '%.lock',
          },
        },

        pickers = {
          find_files = {
            hidden = true, -- include dotfiles
          },
        },

        extensions = {
          fzf = {
            fuzzy                   = true,
            override_generic_sorter = true,
            override_file_sorter    = true,
            case_mode               = 'smart_case',
          },
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      })

      telescope.load_extension('fzf')
      telescope.load_extension('ui-select')

      -- Keymaps
      local map = function(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { desc = desc })
      end

      local builtin = require('telescope.builtin')

      map('<leader>ff', builtin.find_files,              'Find files')
      map('<leader>fg', builtin.live_grep,               'Live grep')
      map('<leader>fb', builtin.buffers,                 'Buffers')
      map('<leader>fh', builtin.help_tags,               'Help tags')
      map('<leader>fr', builtin.oldfiles,                'Recent files')
      map('<leader>fs', builtin.lsp_document_symbols,   'Document symbols')
      map('<leader>fd', builtin.diagnostics,             'Diagnostics')
      map('<leader>gc', builtin.git_commits,             'Git commits')
      map('<leader>gb', builtin.git_branches,            'Git branches')
    end,
  },
}
