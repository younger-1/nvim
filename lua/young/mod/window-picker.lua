local float_flag
local cfg = {
  -- type of hints you want to get
  -- following types are supported
  -- 'statusline-winbar' | 'floating-big-letter'
  -- 'statusline-winbar' draw on 'statusline' if possible, if not 'winbar' will be
  -- 'floating-big-letter' draw big letter on a floating window
  -- used
  hint = 'floating-big-letter',

  -- when you go to window selection mode, status bar will show one of
  -- following letters on them so you can use that letter to select the window
  -- selection_chars = 'FJDKSLA;CMRUEIWOQP',
  selection_chars = '1234567890',

  -- This section contains picker specific configurations
  picker_config = {
    statusline_winbar_picker = {
      -- You can change the display string in status bar.
      -- It supports '%' printf style. Such as `return char .. ': %f'` to display
      -- buffer file path. See :h 'stl' for details.
      selection_display = function(char, windowid)
        return '%=' .. char .. '%='
      end,

      -- whether you want to use winbar instead of the statusline
      -- "always" means to always use winbar,
      -- "never" means to never use winbar
      -- "smart" means to use winbar if cmdheight=0 and statusline if cmdheight > 0
      use_winbar = 'never', -- "always" | "never" | "smart"
    },

    floating_big_letter = {
      -- window picker plugin provides bunch of big letter fonts
      -- fonts will be lazy loaded as they are being requested
      -- additionally, user can pass in a table of fonts in to font
      -- property to use instead

      font = 'ansi-shadow', -- ansi-shadow |
    },
  },

  -- whether to show 'Pick window:' prompt
  show_prompt = true,

  -- prompt message to show to get the user input
  prompt_message = 'Pick window: ',

  -- if you want to manually filter out the windows, pass in a function that
  -- takes two parameters. You should return window ids that should be
  -- included in the selection
  filter_func = function(window_ids, filter_rules)
    window_ids = vim.tbl_filter(function(win_id)
      local win_cfg = vim.api.nvim_win_get_config(win_id)
      return win_cfg.focusable -- exclude non-focusable windows(nvim-treesitter-context)
        and (
          (float_flag == true and win_cfg.relative ~= '') -- only floating windows
          or (float_flag == false and win_cfg.relative == '') -- only non-floating windows
        )
    end, window_ids)

    -- exclude current window
    if not filter_rules.include_current_win then
      window_ids = vim.tbl_filter(function(win_id)
        return win_id ~= vim.api.nvim_get_current_win()
      end, window_ids)
    end

    -- exclude buffer filetype/buftype
    window_ids = vim.tbl_filter(function(win_id)
      local buf_id = vim.api.nvim_win_get_buf(win_id)
      for opt_key, opt_values in pairs(filter_rules.bo) do
        local actual_opt = vim.api.nvim_buf_get_option(buf_id, opt_key)
        if not float_flag and vim.tbl_contains(opt_values, actual_opt) then
          return false
        end
      end
      return true
    end, window_ids)

    return window_ids
  end,

  -- following filters are only applied when you are using the default filter
  -- defined by this plugin. If you pass in a function to "filter_func"
  -- property, you are on your own
  filter_rules = {
    -- when there is only one window available to pick from, use that window
    -- without prompting the user to select
    autoselect_one = true,

    -- whether you want to include the window you are currently on to window
    -- selection or not
    include_current_win = false,

    -- filter using buffer options
    bo = {
      -- if the file type is one of following, the window will be ignored
      filetype = { 'NvimTree', 'neo-tree', 'notify' },
      -- if the buffer type is one of following, the window will be ignored
      buftype = { 'terminal' },
    },

    -- filter using window options
    wo = {},

    -- if the file path contains one of following names, the window
    -- will be ignored
    file_path_contains = {},

    -- if the file name contains one of following names, the window will be
    -- ignored
    file_name_contains = {},
  },

  -- You can pass in the highlight name or a table of content to set as
  -- highlight
  highlights = {
    -- '#76946A', '#2D4F67'
    statusline = {
      focused = {
        fg = '#ededed',
        bg = '#e35e4f',
        bold = true,
      },
      unfocused = {
        fg = '#ededed',
        bg = '#44cc41',
        bold = true,
      },
    },
    winbar = {
      focused = {
        fg = '#ededed',
        bg = '#e35e4f',
        bold = true,
      },
      unfocused = {
        fg = '#ededed',
        bg = '#44cc41',
        bold = true,
      },
    },
  },
}

return {
  once = function()
    xy.map2.n({ '<S-CR>', '<C-w><cr>' }, function()
      float_flag = false
      local wid = require('window-picker').pick_window()
      if wid then
        vim.api.nvim_set_current_win(wid)
        return wid
      end
    end, { desc = 'Pick window' })
    xy.map2.n({ '<C-w>w', '<C-w><tab>' }, function()
      float_flag = true
      local wid = require('window-picker').pick_window()
      if wid then
        vim.api.nvim_set_current_win(wid)
        xy.map.n { 'q', '<cmd>close<cr>', buffer = true }
        return wid
      end
    end, { desc = 'Pick window(float)' })
  end,
  done = function()
    require('window-picker').setup(cfg)
  end,
}
