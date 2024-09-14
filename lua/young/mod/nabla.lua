return {
  once = function()
    xy.map.register {
      ['<leader>an'] = {
        group = '+nabla',
        n = {
          function()
            require('nabla').popup { border = 'rounded' }
          end,
          'ASCII LaTeX equations',
        },
        r = {
          function()
            require('nabla').replace_current()
          end,
          'Replace current LaTeX equations',
        },
        a = {
          function()
            require('nabla').replace_all()
          end,
          'Replace current LaTeX equations',
        },
        d = {
          function()
            require('nabla').draw_overlay()
          end,
          'Draw overlay',
        },
        t = {
          function()
            require('nabla').toggle_virt()
          end,
          'Toggle ASCII LaTeX',
        },
      },
    }
  end,
  done = function() end,
}
