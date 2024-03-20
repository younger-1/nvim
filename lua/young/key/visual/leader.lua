return {
  -- ['/'] = { '<ESC><CMD>lua ___comment_gc(fn.visualmode())<cr>', 'Comment' },
  g = {
    name = '+git',
    h = {
      function()
        vim.cmd [[exe "normal! \<ESC>"]]
        require('telescope.builtin').git_bcommits_range {
          from = vim.fn.line "'<",
          to = vim.fn.line "'>",
        }
      end,
      'Commits(current range)',
    },
  },
  l = {
    name = '+lsp',
  },
  f = {
    name = '+fzf',
  },
  s = {
    name = '+search',
    f = {
      function()
        local text = xy.util.get_visual_selection_by_reg()
        require('telescope.builtin').find_files {}
        fn.feedkeys(text)
      end,
      'Find files',
    },
    F = {
      function()
        local text = xy.util.get_visual_selection_by_reg()
        require('telescope.builtin').find_files { no_ignore = true }
        fn.feedkeys(text)
      end,
      'Find files (with ignored)',
    },
    g = {
      function()
        local text = xy.util.get_visual_selection_by_reg()
        require('telescope.builtin').live_grep {}
        fn.feedkeys(text)
      end,
      'Grep',
    },
    -- g = { 'y:Telescope live_grep<cr><C-r>"', 'Grep' },
    -- g = { '<Esc><cmd>Telescope live_grep<cr><C-r>=AsciiVirtualSelection()<cr>', 'Grep' },
    G = {
      function()
        local text = xy.util.get_visual_selection_by_reg()
        require('telescope.builtin').live_grep {
          additional_args = function()
            return { '-F' } --fixed-string
          end,
        }
        fn.feedkeys(text)
      end,
      'Grep fixed string',
    },
    w = {
      function()
        require('telescope.builtin').grep_string {
          search = xy.util.get_visual_selection_by_reg(),
        }
      end,
      'Word under cursor',
    },
  },
  y = {
    name = '+young',
    g = {
      function()
        local text = xy.util.get_visual_selection_by_reg()
        require('young.mod.telescope.finder').grep_config()
        fn.feedkeys(text)
      end,
      'Grep',
    },
  },
}
