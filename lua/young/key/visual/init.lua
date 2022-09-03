local visual = {
  ['\\'] = {
    s = { ':so<cr>', ':source' },
  },
  g = {
    -- ['/'] = { [["ky/\V<C-r>=escape(@k,'/\')<CR><CR>]], 'Search selection' },
    -- ['/'] = { [[<esc>/\V<C-r>=VirtualSelection()<cr><cr>]], 'Search selection' },
    -- s = { ':<C-u>call SubstituteVirtualSelection()<cr>', 'Substitute selection' },
  },
}

visual['<leader>'] = require 'young.key.visual.leader'

return visual
