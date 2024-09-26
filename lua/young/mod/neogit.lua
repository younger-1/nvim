return {
  once = function()
    xy.map.register {
      ['<leader>g'] = {
        n = {
          group = '+neogit',
          c = {
            function()
              require('neogit').open { 'commit' }
            end,
            'Commit',
          },
          n = {
            function()
              vim.cmd 'Neogit'
            end,
            '♐',
          },
          s = {
            function()
              require('neogit').open { kind = 'split' }
            end,
            'Commit',
          },
          v = {
            function()
              require('neogit').open { kind = 'vsplit' }
            end,
            'Commit',
          },
        },
      },
    }
  end,
  done = function()
    require('neogit').setup {}
  end,
}
