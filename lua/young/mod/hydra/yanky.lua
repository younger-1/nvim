local Hydra = require 'hydra'

local yanky_hydra = Hydra {
  name = 'Yank ring',
  mode = 'n',
  heads = {
    { 'p', '<Plug>(YankyPutAfter)', { desc = 'Paste before' } },
    { 'P', '<Plug>(YankyPutBefore)', { desc = 'Paste after' } },
    { '<C-n>', '<Plug>(YankyCycleForward)', { private = true, desc = '↓' } },
    { '<C-p>', '<Plug>(YankyCycleBackward)', { private = true, desc = '↑' } },
  },
}

local function do_yanky()
  yanky_hydra:activate()
end

return do_yanky
