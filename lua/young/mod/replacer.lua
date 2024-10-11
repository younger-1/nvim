return {
  keys = {
    {
      '<leader>rn',
      function()
        require('replacer').run()
      end,
      desc = 'Replacer run',
    },
    {
      '<leader>rN',
      function()
        require('replacer').save()
      end,
      desc = 'Replacer save',
    },
  },
  done = function()
    require('replacer').setup {
      save_on_write = false,
      rename_files = false,
    }
  end,
}
