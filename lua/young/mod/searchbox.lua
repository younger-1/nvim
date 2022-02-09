local nmap = require('young.key').nmap
local xmap = require('young.key').xmap

nmap('<C-f>', ':SearchBoxMatchAll<CR>')
xmap('<C-f>', ':SearchBoxMatchAll visual_mode=true<CR>')
nmap('<C-b>', ':SearchBoxMatchAll exact=true title=" Search 🦝 "<CR>')

require('searchbox').setup({
  popup = {
    relative = 'win',
    position = {
      row = '5%',
      col = '95%',
    },
    size = 30,
    border = {
      style = 'rounded',
      highlight = 'FloatBorder',
      text = {
        top = ' Search ',
        top_align = 'left',
      },
    },
    win_options = {
      winhighlight = 'Normal:Normal',
    },
  },
  hooks = {
    before_mount = function(input)
      -- code
    end,
    after_mount = function(input)
      -- code
    end,
    on_done = function(value, search_type)
      if value == nil then return end
      vim.fn.setreg('s', value)
    end
  }
})
