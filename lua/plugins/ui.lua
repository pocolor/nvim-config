return {
  -- Colorscheme
  {
    'folke/tokyonight.nvim',
    lazy    = false,
    priority = 1000, -- load before everything else
    config = function()
      require('tokyonight').setup({
        style       = 'night',   -- night | storm | moon | day
        transparent = true,      -- transparent background
        terminal_colors = true,
        styles = {
          comments  = { italic = true },
          keywords  = { italic = true },
          sidebars  = 'transparent',
          floats    = 'transparent',
        },
      })
      vim.cmd.colorscheme('tokyonight')

      -- Extra transparency overrides (belt-and-suspenders)
      vim.api.nvim_set_hl(0, 'Normal',      { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalNC',    { bg = 'none' })
      vim.api.nvim_set_hl(0, 'SignColumn',  { bg = 'none' })
      vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme                = 'tokyonight',
        globalstatus         = true,
        component_separators = { left = '', right = '' },
        section_separators   = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } }, -- relative path
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
  },

  -- Buffer line (tabs at top)
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
      { '<leader>bd', '<cmd>bdelete<cr>',        desc = 'Close buffer' },
    },
    opts = {
      options = {
        mode              = 'buffers',
        numbers           = 'none',
        diagnostics       = 'nvim_lsp',
        show_buffer_close_icons = true,
        show_close_icon   = false,
        separator_style   = 'slant',
        always_show_bufferline = false,
        offsets = {
          {
            filetype   = 'NvimTree',
            text       = 'Explorer',
            highlight  = 'Directory',
            separator  = true,
          },
        },
      },
    },
  },

  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main  = 'ibl',
    opts  = {
      indent  = { char = '▏' },
      scope   = { enabled = true },
    },
  },

  -- Keybind hints
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts  = {
      preset = 'modern',
      delay  = 300,
    },
  },

  -- Modern command line + notifications UI
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown']                = true,
          ['cmp.entry.get_documentation']                  = true,
        },
      },
      presets = {
        bottom_search        = true,  -- classic search bar at bottom
        command_palette      = true,  -- command line centered at top
        long_message_to_split = true,
        inc_rename           = false,
        lsp_doc_border       = true,
      },
    },
  },

  -- Notification manager
  {
    'rcarriga/nvim-notify',
    lazy = true,
    opts = {
      background_colour = '#000000',
      timeout           = 3000,
      max_width         = 60,
      render            = 'wrapped-compact',
    },
  },

  -- Better vim.ui.input / vim.ui.select popups
  {
    'stevearc/dressing.nvim',
    lazy = true,
    opts = {},
  },

  -- Smooth cursor smear animation
  {
    'sphamba/smear-cursor.nvim',
    event = 'VeryLazy',
    opts  = {
      smear_between_buffers        = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space          = true,
      legacy_computing_symbols_support = false,
    },
  },
}
