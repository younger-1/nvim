return {
  keys = {
    {
      "<leader>'",
      function()
        vim.cmd 'Telescope live_grep_args'
      end,
      desc = 'Grep',
    },
    {
      "<leader>'",
      function()
        require('telescope-live-grep-args.shortcuts').grep_visual_selection()
      end,
      mode = 'x',
      desc = 'Grep',
    },
    {
      '<leader>"',
      function()
        require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()
      end,
      desc = 'Grep cursor word',
    },
  },
  config = function()
    require('young.mod.telescope').cfg.extensions.live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      mappings = {
        i = {
          ['<C-l>'] = function(prompt_bufnr)
            require('telescope-live-grep-args.actions').quote_prompt()(prompt_bufnr)
          end,
          ['<A-l>'] = function(prompt_bufnr)
            require('telescope-live-grep-args.actions').quote_prompt { postfix = ' --iglob ' }(prompt_bufnr)
          end,
        },
      },
    }
    require('telescope').load_extension 'live_grep_args'
  end,
}
