local Hydra = require 'hydra'

local yanky_hydra = Hydra {
  name = 'Yank ring',
  mode = 'n',
  -- config = {
  --   invoke_on_body = true,
  -- },
  -- body = 'p',
  heads = {
    { 'p', '<Plug>(YankyPutAfter)', { desc = 'Paste before' } },
    { 'P', '<Plug>(YankyPutBefore)', { desc = 'Paste after' } },
    { '<C-n>', '<Plug>(YankyCycleForward)', { private = true, desc = '↓' } },
    { '<C-p>', '<Plug>(YankyCycleBackward)', { private = true, desc = '↑' } },
  },
}

local M = {}

M.put_after = function()
  vim.fn.feedkeys(xy.util.t '<Plug>(YankyPutAfter)')
  yanky_hydra:activate()
end

M.put_before = function()
  vim.fn.feedkeys(xy.util.t '<Plug>(YankyPutBefore)')
  yanky_hydra:activate()
end

return M
