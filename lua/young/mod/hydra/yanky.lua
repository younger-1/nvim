local Hydra = require 'hydra'

local yanky_hydra = Hydra {
  name = 'Yank ring',
  mode = 'n',
  -- config = {
  --   invoke_on_body = true,
  -- },
  -- body = 'p',
  heads = {
    { 'p', '<Plug>(YankyPutAfter)', { desc = 'After' } },
    { 'P', '<Plug>(YankyPutBefore)', { desc = 'Before' } },
    { '<C-n>', '<Plug>(YankyCycleForward)', { private = true, desc = '↓' } },
    { '<C-p>', '<Plug>(YankyCycleBackward)', { private = true, desc = '↑' } },
  },
}

for key, putAction in pairs {
  ['p'] = '<Plug>(YankyPutAfter)',
  ['P'] = '<Plug>(YankyPutBefore)',
  -- ['gp'] = '<Plug>(YankyGPutAfter)',
  -- ['gP'] = '<Plug>(YankyGPutBefore)',
} do
  vim.keymap.set({ 'n', 'x' }, key, function()
    vim.fn.feedkeys('"' .. vim.v.register .. vim.v.count1 .. xy.util.t(putAction))
    yanky_hydra:activate()
  end)
end

for key, putAction in pairs {
  [']p'] = '<Plug>(YankyPutIndentAfterLinewise)',
  ['[p'] = '<Plug>(YankyPutIndentBeforeLinewise)',
  -- [']P'] = '<Plug>(YankyPutIndentAfterLinewise)',
  -- ['[P'] = '<Plug>(YankyPutIndentBeforeLinewise)',

  -- ['>p'] = '<Plug>(YankyPutIndentAfterShiftRight)',
  -- ['<p'] = '<Plug>(YankyPutIndentAfterShiftLeft)',
  -- ['>P'] = '<Plug>(YankyPutIndentBeforeShiftRight)',
  -- ['<P'] = '<Plug>(YankyPutIndentBeforeShiftLeft)',

  ['=p'] = '<Plug>(YankyPutAfterFilter)',
  ['=P'] = '<Plug>(YankyPutBeforeFilter)',
} do
  vim.keymap.set('n', key, function()
    vim.fn.feedkeys('"' .. vim.v.register .. vim.v.count1 .. xy.util.t(putAction))
    yanky_hydra:activate()
  end)
end
