local win_picker = require 'window-picker'
local M = {}

win_picker.setup {
    filter_rules = {
        -- filter using buffer options
        bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { 'NvimTree', 'neo-tree', 'notify' },
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

    -- all the windows except the curren window will be highlighted using this
    -- color
    -- other_win_hl_color = '#44cc41',
}

M.pick = function()
  local wid = require('window-picker').pick_window()
  if wid then
    vim.api.nvim_set_current_win(wid)
    return wid
  end
end

vim.keymap.set('n', '<C-w>p', M.pick)

return M