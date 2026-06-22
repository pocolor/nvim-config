return {
  -- Inline git signs, hunk staging, blame
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      signs = {
        add          = { text = '▎' },
        change       = { text = '▎' },
        delete       = { text = '' },
        topdelete    = { text = '' },
        changedelete = { text = '▎' },
        untracked    = { text = '▎' },
      },

      on_attach = function(buf)
        local gs  = package.loaded.gitsigns
        local map = function(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, { buffer = buf, desc = desc })
        end

        -- Navigation
        map(']h', gs.next_hunk,  'Next hunk')
        map('[h', gs.prev_hunk,  'Prev hunk')

        -- Actions
        map('<leader>hs', gs.stage_hunk,        'Stage hunk')
        map('<leader>hr', gs.reset_hunk,        'Reset hunk')
        map('<leader>hS', gs.stage_buffer,      'Stage buffer')
        map('<leader>hu', gs.undo_stage_hunk,   'Undo stage hunk')
        map('<leader>hR', gs.reset_buffer,      'Reset buffer')
        map('<leader>hp', gs.preview_hunk,      'Preview hunk')
        map('<leader>hb', gs.blame_line,        'Blame line')
        map('<leader>hd', gs.diffthis,          'Diff this')
        map('<leader>tb', gs.toggle_current_line_blame, 'Toggle line blame')
      end,
    },
  },

  -- Full Git workflow: :G, :Gdiff, :Glog, etc.
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git', 'Gdiff', 'Glog', 'Gclog' },
    keys = {
      { '<leader>gg', '<cmd>Git<cr>',      desc = 'Git status' },
      { '<leader>gd', '<cmd>Gdiff<cr>',   desc = 'Git diff' },
      { '<leader>gl', '<cmd>Gclog<cr>',   desc = 'Git log' },
      { '<leader>gp', '<cmd>Git push<cr>', desc = 'Git push' },
    },
  },

  -- Beautiful side-by-side diffs and file history
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gv', '<cmd>DiffviewOpen<cr>',        desc = 'Diffview open' },
      { '<leader>gh', '<cmd>DiffviewFileHistory<cr>', desc = 'File history' },
    },
    opts = {},
  },
}
