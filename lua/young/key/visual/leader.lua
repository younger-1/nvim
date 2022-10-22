local cmd = require('young.key').cmd

return {
  -- ['/'] = { '<ESC><CMD>lua ___comment_gc(vim.fn.visualmode())<cr>', 'Comment' },
  g = {
    name = '+git',
    s = { ':Gitsigns stage_hunk<CR>', 'Stage Hunk' },
    r = { ':Gitsigns reset_hunk<CR>', 'Reset Hunk' },
    y = 'Link',
  },
  l = {
    name = '+lsp',
    a = { vim.lsp.buf.range_code_action, 'Code action' },
    f = { vim.lsp.buf.range_formatting, 'Format' },
  },
  p = {
    name = '+packer',
    I = { 'y:lua pp(<C-r>")', 'Inspect' },
  },
  s = {
    name = '+search',
    f = {
      function()
        local text = xy.util.get_visual_selection()
        require('telescope.builtin').find_files {}
        vim.fn.feedkeys(text)
      end,
      'Find files',
    },
    g = {
      function()
        local text = xy.util.get_visual_selection()
        require('telescope.builtin').live_grep {}
        vim.fn.feedkeys(text)
      end,
      'Grep',
    },
    -- g = { 'y:Telescope live_grep<cr><C-r>"', 'Grep' },
    -- g = { '<Esc><cmd>Telescope live_grep<cr><C-r>=AsciiVirtualSelection()<cr>', 'Grep' },
    t = {
      function()
        require('telescope.builtin').grep_string {
          search = xy.util.get_visual_selection(),
        }
      end,
      'Search fixed string',
    },
    y = { 'dh<cmd>Telescope neoclip<cr>', 'Clipboard' },
  },
}
