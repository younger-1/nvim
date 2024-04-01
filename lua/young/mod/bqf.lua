local M = {}

-- | Function    | Action                                                     | Def Key   |
-- | ----------- | ---------------------------------------------------------- | --------- |
-- | open        | open the item under the cursor                             | `<CR>`    |
-- | openc       | open the item, and close quickfix window                   | `o`       |
-- | drop        | use `drop` to open the item, and close quickfix window     | `O`       |
-- | tabdrop     | use `tab drop` to open the item, and close quickfix window |           |
-- | tab         | open the item in a new tab                                 | `t`       |
-- | tabb        | open the item in a new tab, but stay in quickfix window    | `T`       |
-- | tabc        | open the item in a new tab, and close quickfix window      | `<C-t>`   |
-- | split       | open the item in horizontal split                          | `<C-x>`   |
-- | vsplit      | open the item in vertical split                            | `<C-v>`   |
-- | prevfile    | go to previous file under the cursor in quickfix window    | `<C-p>`   |
-- | nextfile    | go to next file under the cursor in quickfix window        | `<C-n>`   |
-- | prevhist    | cycle to previous quickfix list in quickfix window         | `<`       |
-- | nexthist    | cycle to next quickfix list in quickfix window             | `>`       |
-- | lastleave   | go to last selected item in quickfix window                | `'"`      |
-- | stoggleup   | toggle sign and move cursor up                             | `<S-Tab>` |
-- | stoggledown | toggle sign and move cursor down                           | `<Tab>`   |
-- | stogglevm   | toggle multiple signs in visual mode                       | `<Tab>`   |
-- | stogglebuf  | toggle signs for same buffers under the cursor             | `'<Tab>`  |
-- | sclear      | clear the signs in current quickfix list                   | `z<Tab>`  |
-- | pscrollup   | scroll up half-page in preview window                      | `<C-b>`   |
-- | pscrolldown | scroll down half-page in preview window                    | `<C-f>`   |
-- | pscrollorig | scroll back to original position in preview window         | `zo`      |
-- | ptogglemode | toggle preview window between normal and max size          | `zp`      |
-- | ptoggleitem | toggle preview for a quickfix list item                    | `p`       |
-- | ptoggleauto | toggle auto-preview when cursor moves                      | `P`       |
-- | filter      | create new list for signed items                           | `zn`      |
-- | filterr     | create new list for non-signed items                       | `zN`      |
-- | fzffilter   | enter fzf mode                                             | `zf`      |

-- TODO:https://github.com/b0o/nvim-conf/blob/main/lua/user/plugin/bqf.lua

local cfg = {
  auto_enable = true,
  magic_window = true,
  auto_resize_height = true,
  previous_winid_ft_skip = {},
  preview = {
    auto_preview = true,
    border = 'rounded',
    -- border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
    -- border = { '│', '│', '─', '─', '╭', '╮', '╰', '╯', '█' },
    -- border = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },
    show_title = true,
    show_scroll_bar = true,
    delay_syntax = 50,
    winblend = 12,
    win_height = 15,
    win_vheight = 15,
    wrap = false,
    buf_label = true,
    should_preview_cb = function(bufnr, qwinid)
      local ret = true
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local fsize = vim.fn.getfsize(bufname)
      if fsize > 100 * 1024 then
        -- skip file size greater than 100k
        ret = false
      elseif bufname:match '^fugitive://' then
        -- skip fugitive buffer
        ret = false
      end
      return ret
    end,
  },

  func_map = { -- set to empty string to disable
    open = '<CR>',
    openc = 'o',
    drop = 'O',
    split = '<C-s>',
    vsplit = '<C-v>',
    tab = 't',
    tabb = 'T',
    tabc = '<C-t>',
    tabdrop = '',
    ptogglemode = 'zp',
    ptoggleitem = 'p',
    ptoggleauto = 'P',
    pscrollup = '<C-u>',
    pscrolldown = '<C-d>',
    pscrollorig = 'zz', -- 'zo', scroll back to original postion in preview window
    prevfile = '<C-p>',
    nextfile = '<C-n>',
    prevhist = '<',
    nexthist = '>',
    lastleave = [['"]],
    stoggleup = '<S-Tab>',
    stoggledown = '<Tab>',
    stogglevm = '<Tab>', -- toggle multiple signs in visual mode
    stogglebuf = 'zb', -- "'<Tab>", -- toggle signs for same buffers under the cursor
    sclear = 'zc', -- "z<Tab>", -- clear the signs in current quickfix list
    filter = 'zn',
    filterr = 'zN',
    fzffilter = 'zf',
  },
  filter = {
    fzf = {
      action_for = {
        ['ctrl-t'] = 'tabedit',
        ['ctrl-h'] = 'vsplit',
        ['ctrl-x'] = 'split',
        ['ctrl-q'] = 'signtoggle',
        ['ctrl-c'] = 'closeall',
      },
      extra_opts = { '--bind', 'ctrl-o:toggle-all' },
    },
  },
}

M.done = function()
  -- pp(require 'bqf.config')
  require('bqf').setup(cfg)
end

return M
