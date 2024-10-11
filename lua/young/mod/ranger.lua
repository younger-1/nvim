return {
  keys = {
    {
      '<leader>er',
      function()
        require('ranger-nvim').open(true)
      end,
      desc = 'Ranger',
    },
  },
  done = function()
    require('ranger-nvim').setup {
      replace_netrw = true,
    }
  end,
}
