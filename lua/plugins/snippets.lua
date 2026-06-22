return {
  -- Snippet engine
  {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp', -- enables regex transforms in snippets
    dependencies = {
      'rafamadriz/friendly-snippets', -- large collection of ready-made snippets
    },
    config = function()
      local luasnip = require('luasnip')

      -- Load friendly-snippets collection
      require('luasnip.loaders.from_vscode').lazy_load()

      -- Optionally load snippets from your own directory
      -- require('luasnip.loaders.from_vscode').lazy_load({ paths = { './snippets' } })

      luasnip.config.setup({
        history = true,                -- allow jumping back into exited snippets
        update_events = 'TextChanged,TextChangedI', -- live update as you type
        enable_autosnippets = true,
      })

      -- Jump forward/backward through snippet placeholders outside of cmp
      -- (cmp.lua handles Tab/S-Tab inside completion; these are fallbacks)
      vim.keymap.set({ 'i', 's' }, '<C-l>', function()
        if luasnip.jumpable(1) then luasnip.jump(1) end
      end, { desc = 'Snippet jump forward' })

      vim.keymap.set({ 'i', 's' }, '<C-h>', function()
        if luasnip.jumpable(-1) then luasnip.jump(-1) end
      end, { desc = 'Snippet jump backward' })
    end,
  },

  -- cmp source for luasnip (loaded by cmp.lua, declared here for clarity)
  { 'saadparwaiz1/cmp_luasnip', lazy = true },

  -- Snippet collection
  { 'rafamadriz/friendly-snippets', lazy = true },
}
