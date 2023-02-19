local cfg = {
  enable = false, -- boolean: enable transparent
  extra_groups = { -- table/string: additional groups that should be cleared
    -- In particular, when you set it to 'all', that means all available groups

    -- example of akinsho/nvim-bufferline.lua
    'BufferLineTabClose',
    'BufferlineBufferSelected',
    'BufferLineFill',
    'BufferLineBackground',
    'BufferLineSeparator',
    'BufferLineIndicatorSelected',
  },
  exclude = {}, -- table: groups you don't want to clear
}

return {
  once = function()
    xy.map.n { '<leader>tt', '<cmd>TransparentToggle<cr>' }
  end,
  done = function()
    require('transparent').setup(cfg)
  end,
}
