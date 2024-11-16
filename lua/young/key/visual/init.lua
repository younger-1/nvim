return {
  ['<leader>'] = require 'young.key.visual.leader',

  ['\\'] = {
    s = { ':so<cr>', ':source' },
    p = {
      function()
        local text = xy.util.get_visual_selection_by_reg()
        vim.fn.feedkeys(vim.keycode '<Esc>' .. ':=' .. text, 'n')
      end,
      'Inspect (=)',
    },
    l = {
      function()
        local text = xy.util.get_visual_selection_by_reg()
        vim.fn.feedkeys(vim.keycode '<Esc>' .. ':lua ' .. text, 'n')
      end,
      'Inspect (lua)',
    },
  },
  g = {
    -- ['/'] = { [["ky/\V<C-r>=escape(@k,'/\')<CR><CR>]], 'Search selection' },
    -- ['/'] = { [[<esc>/\V<C-r>=VirtualSelection()<cr><cr>]], 'Search selection' },
    -- s = { ':<C-u>call SubstituteVirtualSelection()<cr>', 'Substitute selection' },
  },
}
