local Hydra = require 'hydra'

Hydra {
  name = 'Quick words',
  config = {
    color = 'pink',
    hint = { type = 'statusline' },
  },
  mode = { 'n', 'x', 'o' },
  body = ',',
  heads = {
    { 'w', '<Plug>(smartword-w)', { desc = 'w' } },
    { 'b', '<Plug>(smartword-b)', { desc = 'b' } },
    { 'e', '<Plug>(smartword-e)', { desc = 'e' } },
    { 'ge', '<Plug>(smartword-ge)', { desc = 'ge' } },
    { '<Esc>', nil, { exit = true, mode = 'n' } },
  },
}
