local cfg = {
  show_icons = true,
  -- always_show_path = false,
  -- separate_by_branch = false, -- Bookmarks will be separated by git branch
  -- hide_handbook = false, -- set to true to hide the shortcuts on menu.
  -- separate_save_and_remove = false, -- if true, will remove the toggle and create the save/remove keymaps.
  -- global_bookmarks = false, -- if true, arrow will save files globally (ignores separate_by_branch)
  -- index_keys = '123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP', -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
  -- full_path_list = { 'update_stuff' }, -- filenames on this list will ALWAYS show the file path too.
  -- leader_key = ';',
  mappings = {
    -- toggle = 's', -- used as save if separate_save_and_remove is true
    -- remove = 'x', -- only used if separate_save_and_remove is true
    -- edit = 'e',
    -- delete_mode = 'd',
    -- clear_all_items = 'C',
    open_vertical = 'v',
    open_horizontal = 'x',
    -- next_item = ']',
    -- prev_item = '[',
    -- quit = 'q',
  },
  -- save_path = function()
  --   return vim.fn.stdpath 'cache' .. '/arrow'
  -- end,
  -- save_key = "cwd", -- what will be used as root to save the bookmarks. Can be also `git_root`.
  -- custom_actions = {
  --   open = function(target_file_name, current_file_name) end, -- target_file_name = file selected to be open, current_file_name = filename from where this was called
  --   split_vertical = function(target_file_name, current_file_name) end,
  --   split_horizontal = function(target_file_name, current_file_name) end,
  -- },
  -- window = { -- controls the appearance and position of an arrow window (see nvim_open_win() for all options)
  --   width = 'auto',
  --   height = 'auto',
  --   row = 'auto',
  --   col = 'auto',
  --   border = 'double',
  -- },
}

return {
  once = function()
    vim.keymap.set('n', ';', function()
      vim.cmd 'Arrow open'
    end, { desc = 'Arrow prev file' })
    vim.keymap.set('n', 'H', function()
      require('arrow.persist').previous()
    end, { desc = 'Arrow prev file' })
    vim.keymap.set('n', 'L', function()
      require('arrow.persist').next()
    end, { desc = 'Arrow next file' })
    vim.keymap.set('n', '<C-s>', function()
      require('arrow.persist').toggle()
    end, { desc = 'Arrow toggle current file' })
  end,
  done = function()
    require('arrow').setup(cfg)
  end,
}
