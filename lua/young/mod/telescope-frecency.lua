return {
  'nvim-telescope/telescope-frecency.nvim',
  keys = {
    {
      '<leader>:',
      function()
        vim.cmd 'Telescope frecency'
      end,
      desc = 'Frecency',
    },
    {
      '<leader>;',
      function()
        vim.cmd 'Telescope frecency default_text=:CWD:'
      end,
      desc = 'Frecency',
    },
  },
  init = function()
    -- To record most recent files opened by telescope
    xy.lazy_on_load('telescope.nvim', function()
      vim.cmd 'Lazy load telescope-frecency.nvim'
    end)
    require('young.mod.telescope').cfg.extensions.frecency = {
      show_scores = true,
      show_unindexed = true,
      show_filter_column = false,
      workspaces = {
        -- [](https://github.com/nvim-telescope/telescope-frecency.nvim/issues/21)
        ['conf'] = vim.fn.expand '~/.config',
        ['share'] = vim.fn.expand '~/.local/share',
        ['dot'] = vim.fn.expand '~/dotter',
        ['beauty'] = vim.fn.expand '~/Beauty',
        ['project'] = vim.fn.expand '~/projects',
        ['source'] = vim.fn.expand '~/source',
        ['wiki'] = vim.fn.expand '~/wiki',
      },
    }
  end,
  config = function()
    require('telescope').load_extension 'frecency'
  end,
}
