local Hydra = require 'hydra'

Hydra {
  name = 'Smart word',
  config = {
    color = 'pink',
    hint = { type = 'statusline' },
  },
  mode = { 'n', 'x', 'o' },
  body = ',,',
  heads = {
    { 'w', '<Plug>(smartword-w)', { desc = 'Smart word w' } },
    { 'b', '<Plug>(smartword-b)', { desc = 'Smart word b' } },
    { 'e', '<Plug>(smartword-e)', { desc = 'Smart word e' } },
    { 'ge', '<Plug>(smartword-ge)', { desc = 'ge' } },
    { '<Esc>', nil, { exit = true, mode = 'n' } },
  },
}
