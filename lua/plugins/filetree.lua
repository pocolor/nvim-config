return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>e',  '<cmd>NvimTreeToggle<cr>',   desc = 'Toggle file tree' },
      { '<leader>ef', '<cmd>NvimTreeFindFile<cr>', desc = 'Find file in tree' },
    },
    config = function()
      -- Disable netrw so nvim-tree takes over completely
      vim.g.loaded_netrw       = 1
      vim.g.loaded_netrwPlugin = 1

      require('nvim-tree').setup({
        view = {
          width = 35,
          side  = 'left',
        },

        renderer = {
          group_empty = true, -- collapse single-child dirs
          highlight_git = true,
          icons = {
            show = {
              file        = true,
              folder      = true,
              folder_arrow = true,
              git         = true,
            },
          },
        },

        filters = {
          dotfiles = false, -- show dotfiles
          custom   = { '.DS_Store', 'node_modules', '__pycache__', '.git' },
        },

        git = {
          enable  = true,
          ignore  = false, -- show git-ignored files (greyed out)
        },

        actions = {
          open_file = {
            quit_on_open = false,  -- keep tree open after opening a file
            window_picker = { enable = true },
          },
        },

        -- Close tree if it's the last window
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')
          api.config.mappings.default_on_attach(bufnr)

          -- Extra keymaps inside the tree
          local map = function(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
          end

          map('l', api.node.open.edit,   'Open')
          map('h', api.node.navigate.parent_close, 'Collapse')
          map('?', api.tree.toggle_help, 'Help')
        end,
      })

      -- Close Neovim if tree is the last buffer
      vim.api.nvim_create_autocmd('QuitPre', {
        callback = function()
          local tree_wins = {}
          local floating_wins = {}
          local wins = vim.api.nvim_list_wins()
          for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match('NvimTree_') ~= nil then
              table.insert(tree_wins, w)
            end
            if vim.api.nvim_win_get_config(w).relative ~= '' then
              table.insert(floating_wins, w)
            end
          end
          if #wins - #floating_wins - #tree_wins == 0 then
            for _, w in ipairs(tree_wins) do
              vim.api.nvim_win_close(w, true)
            end
          end
        end,
      })
    end,
  },
}
