local M = {}

local cfg = {
  -- when there is only one window available to pick from, use that window
  -- without prompting the user to select
  autoselect_one = true,

  -- whether you want to include the window you are currently on to window
  -- selection or not
  include_current_win = false,

  -- when you go to window selection mode, status bar will show one of
  -- following letters on them so you can use that letter to select the window
  selection_chars = 'FJDKSLA;CMRUEIWOQP',

  -- if you want to manually filter out the windows, pass in a function that
  -- takes two parameters. you should return window ids that should be
  -- included in the selection
  -- EX:-
  -- function(window_ids, filters)
  --    -- filder the window_ids
  --    -- return only the ones you want to include
  --    return {1000, 1001}
  -- end
  filter_func = nil,

  -- following filters are only applied when you are using the default filter
  -- defined by this plugin. if you pass in a function to "filter_func"
  -- property, you are on your own
  filter_rules = {
    -- filter using buffer options
    bo = {
      -- if the file type is one of following, the window will be ignored
      -- filetype = { 'NvimTree', 'neo-tree', 'notify' },
      filetype = { 'notify' },
      -- if the buffer type is one of following, the window will be ignored
      buftype = { 'terminal' },
    },

    -- filter using window options
    -- wo = {},

    -- if the file path contains one of following names, the window
    -- will be ignored
    -- file_path_contains = {},

    -- if the file name contains one of following names, the window will be
    -- ignored
    -- file_name_contains = {},
  },

  -- if you have include_current_win == true, then current_win_hl_color will
  -- be highlighted using this background color
  -- current_win_hl_color = '#e35e4f',
  current_win_hl_color = '#2D4F67',

  -- all the windows except the curren window will be highlighted using this color
  -- other_win_hl_color = '#44cc41',
  other_win_hl_color = '#76946A',
}

M.pick = function()
  local wid = require('window-picker').pick_window()
  if wid then
    vim.api.nvim_set_current_win(wid)
    return wid
  end
end

M.done = function()
  -- local status_ok, win_picker = pcall(require, 'window-picker')
  -- if not status_ok then
  --   return
  -- end

  require('window-picker').setup(cfg)
end

return M
