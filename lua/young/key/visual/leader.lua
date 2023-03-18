local cmd = require('young.key').cmd

return {
  -- ['/'] = { '<ESC><CMD>lua ___comment_gc(fn.visualmode())<cr>', 'Comment' },
  l = {
    name = '+lsp',
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
      'Find files',
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
    t = {
      function()
        require('telescope.builtin').grep_string {
          search = xy.util.get_visual_selection_by_reg(),
        }
      end,
      'Search fixed string',
    },
    y = { 'dh<cmd>Telescope neoclip<cr>', 'Clipboard' },
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
  }
}
