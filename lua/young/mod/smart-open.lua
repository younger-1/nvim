return {
  'danielfalk/smart-open.nvim',
  keys = {
    {
      '<leader><leader>',
      function()
        require('telescope').extensions.smart_open.smart_open {}
      end,
      desc = 'Smart frecency',
    },
  },
  init = function()
    -- To record most recent files opened by telescope
    xy.lazy_on_load('telescope.nvim', function()
      vim.cmd 'Lazy load smart-open.nvim'
    end)
    require('young.mod.telescope').cfg.extensions.smart_open = {
      show_scores = true,
      ignore_patterns = { '*.git/*', '*/tmp/*' },
      match_algorithm = 'fzy',
      open_buffer_indicators = { previous = '👀', others = '🙈' },
      buffer_indicators = { previous = '#', others = '*' },
    }
  end,
  config = function()
    require('telescope').load_extension 'smart_open'
  end,
}
