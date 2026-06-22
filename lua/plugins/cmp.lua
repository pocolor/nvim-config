return {
-- Completion engine
{
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',   -- LSP source
    'hrsh7th/cmp-buffer',      -- words from current buffer
    'hrsh7th/cmp-path',        -- filesystem paths
    'saadparwaiz1/cmp_luasnip', -- snippet source
  },
  config = function()
    local cmp     = require('cmp')
    local luasnip = require('luasnip')

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>']     = cmp.mapping.abort(),
        ['<CR>']      = cmp.mapping.confirm({ select = true }),

        -- Tab through completion items
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),

        -- Scroll docs in completion popup
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      }),

      sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'luasnip',  priority = 750 },
        { name = 'buffer',   priority = 500 },
        { name = 'path',     priority = 250 },
      }),

      formatting = {
        format = function(entry, item)
          -- Source label shown next to completion item
          local source_labels = {
            nvim_lsp = '[LSP]',
            luasnip  = '[Snip]',
            buffer   = '[Buf]',
            path     = '[Path]',
          }
          item.menu = source_labels[entry.source.name] or ''
          return item
        end,
      },

      window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      experimental = {
        ghost_text = true, -- inline preview of first completion
      },
    })
  end,
},

-- LSP completion source
{ 'hrsh7th/cmp-nvim-lsp', lazy = true },
{ 'hrsh7th/cmp-buffer',   lazy = true },
{ 'hrsh7th/cmp-path',     lazy = true },
}
