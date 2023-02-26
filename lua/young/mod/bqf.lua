local M = {}

-- TODO:https://github.com/b0o/nvim-conf/blob/main/lua/user/plugin/bqf.lua

local cfg = {
  -- auto_enable = true,
  preview = {
    -- auto_preview = true,
    win_height = 12,
    win_vheight = 12,
    -- delay_syntax = 80,
    border_chars = { '│', '│', '─', '─', '╭', '╮', '╰', '╯', '█' },
    -- border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
  },
  func_map = {
    stogglevm = '<Tab>', -- toggle multiple signs in visual mode
    stogglebuf = 'zb', -- "'<Tab>", -- toggle signs for same buffers under the cursor
    sclear = 'zc', -- "z<Tab>", -- clear the signs in current quickfix list
    filter = 'zn', -- create new list for signed items
    filterr = 'zN', -- create new list for non-signed items
    tab = 't',
    tabb = 'T', -- like tab, but stay at quickfix window
    prevfile = 'K', -- "<C-p>", -- go to next file under the cursor
    nextfile = 'J', -- "<C-n>",
    pscrollup = '<C-u>',
    pscrolldown = '<C-d>',
    pscrollorig = 'zz', -- scroll back to original postion in preview window
    ptogglemode = 'zp', -- toggle preview window between normal and max size
  },
  filter = {
    fzf = {
      extra_opts = { '--bind', 'ctrl-o:toggle-all', '--prompt', '> ' },
    },
  },
  should_preview_cb = function(bufnr)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local fsize = vim.fn.getfsize(fname)
    -- disable preview if file size greater than 100k
    if fsize > 100 * 1024 then
      return false
    end
    return true
  end,
}

M.done = function()
  -- pp(require 'bqf.config')
  require('bqf').setup(cfg)
end

return M
