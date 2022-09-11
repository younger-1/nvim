local Hydra = require 'hydra'

Hydra {
  name = 'Yank ring',
  mode = 'n',
  body = 'g',
  heads = {
    { 'p', '<Plug>(YankyPutAfter)', { desc = 'Paste before' } },
    { 'P', '<Plug>(YankyPutBefore)', { desc = 'Paste after' } },
    { '<C-n>', '<Plug>(YankyCycleForward)', { private = true, desc = '↓' } },
    { '<C-p>', '<Plug>(YankyCycleBackward)', { private = true, desc = '↑' } },
  },
}
