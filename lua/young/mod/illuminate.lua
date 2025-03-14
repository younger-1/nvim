require('illuminate').configure {
  -- providers: provider used to get references in the buffer, ordered by priority
  providers = {
    'lsp',
    'treesitter',
    'regex',
  },
  -- delay: delay in milliseconds
  delay = 100,
  -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
  filetypes_denylist = {
    'dirvish',
    'fugitive',
    'TelescopePrompt',
    'alpha',
    'lspsagafinder',
  },
  -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
  filetypes_allowlist = {},
  -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
  modes_denylist = { 'i' },
  -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
  modes_allowlist = {},
  -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
  -- Only applies to the 'regex' provider
  -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
  providers_regex_syntax_denylist = {},
  -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
  -- Only applies to the 'regex' provider
  -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
  providers_regex_syntax_allowlist = {},
  -- under_cursor: whether or not to illuminate under the cursor
  under_cursor = true,
}

vim.cmd [[
hi! def link IlluminatedWordText  LspReferenceText
hi! def link IlluminatedWordRead  LspReferenceRead
hi! def link IlluminatedWordWrite LspReferenceWrite
]]

-- vim.cmd [[
-- hi def link IlluminatedWordText Visual
-- hi def link IlluminatedWordRead Visual
-- hi def link IlluminatedWordWrite Visual
-- ]]
-- vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'Visual' })
-- vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'Visual' })
-- vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'Visual' })

vim.keymap.set('n', ']w', require('illuminate').goto_next_reference, { desc = 'Next reference' })
vim.keymap.set('n', '[w', require('illuminate').goto_prev_reference, { desc = 'Previous reference' })
vim.keymap.set('n', ']]', require('illuminate').goto_next_reference, { desc = 'Next reference' })
vim.keymap.set('n', '[[', require('illuminate').goto_prev_reference, { desc = 'Previous reference' })
-- vim.keymap.set('o', '<a-i>', require('illuminate').textobj_select)
-- vim.keymap.set('x', '<a-i>', require('illuminate').textobj_select)
--
xy.map.n { '<leader>lT', '<cmd>IlluminateToggle<cr>', 'Toggle highlight cursor word' }
