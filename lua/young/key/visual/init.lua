local visual = {
  ['\\'] = {
    s = { ':so<cr>', ':source' },
    -- I = { 'y:lua pp(<C-r>")', 'Inspect' },
    I = {
      function()
        local text = xy.util.get_visual_selection_by_reg()
        fn.feedkeys(':lua=' .. text)
      end,
      'Inspect',
    },
  },
  g = {
    -- ['/'] = { [["ky/\V<C-r>=escape(@k,'/\')<CR><CR>]], 'Search selection' },
    -- ['/'] = { [[<esc>/\V<C-r>=VirtualSelection()<cr><cr>]], 'Search selection' },
    -- s = { ':<C-u>call SubstituteVirtualSelection()<cr>', 'Substitute selection' },
  },
}

visual['<leader>'] = require 'young.key.visual.leader'

return visual
