-- local autocmd = vim.api.nvim_create_autocmd
-- autocmd({ 'BufReadPre' }, {
--   group = '_mini.indentscope',
--   callback = function() end,
-- })

require('mini.indentscope').setup {
  symbol = xy.icon.bar,
  options = { try_as_border = true },
}
do
  vim.api.nvim_create_autocmd('FileType', {
    pattern = {
      'alpha',
      'dashboard',
      'neo-tree',
      'Trouble',
      -- 'help',
      -- 'lspinfo',
      -- 'mason',
      -- 'lazy',
    },
    callback = function()
      vim.b.miniindentscope_disable = true
    end,
  })
end

-- require('mini.animate').setup()

require('mini.files').setup {
  mappings = {
    -- close       = 'q',
    -- go_in       = 'l',
    -- go_in_plus  = 'L',
    -- go_out      = 'h',
    -- go_out_plus = 'H',
    -- reset       = '<BS>',
    -- reveal_cwd  = '@',
    reveal_cwd = 'gf',
    -- show_help   = 'g?',
    show_help = 'gh',
    -- synchronize = '=',
    -- trim_left   = '<',
    -- trim_right  = '>',
  },
}
do
  -- Toggle explorer
  xy.map2.n('<leader>em', function()
    if not require('mini.files').close() then
      require('mini.files').open(vim.fn.expand '%:p')
      require('mini.files').reveal_cwd()
    end
  end, { desc = 'Mini files' })
  xy.map2.n('<leader>eM', function()
    if not require('mini.files').close() then
      require('mini.files').open()
    end
  end, { desc = 'Mini files' })
  -- Customize windows
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
      local win_id = args.data.win_id
      vim.wo[win_id].winblend = 15
      vim.api.nvim_win_set_config(win_id, { border = 'double' })
    end,
  })
  -- Create mapping to show/hide dot-files
  local show_dotfiles = true
  local filter_show = function()
    return true
  end
  local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, '.')
  end
  local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    require('mini.files').refresh { content = { filter = new_filter } }
  end
  local files_set_cwd = function()
    local cur_entry_path = require('mini.files').get_fs_entry().path
    local cur_directory = vim.fs.dirname(cur_entry_path)
    vim.cmd.tcd(cur_directory)
  end
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      vim.keymap.set('n', 'g.', toggle_dotfiles, {
        buffer = args.data.buf_id,
        desc = '[young] show/hide dot-files',
      })
      vim.keymap.set('n', 'gj', files_set_cwd, {
        buffer = args.data.buf_id,
        desc = '[young] set cwd',
      })
      vim.keymap.set('n', 'gd', function()
        require('mini.files').open(vim.fn.getcwd())
      end, {
        buffer = args.data.buf_id,
        desc = '[young] open cwd',
      })
      vim.keymap.set('n', '<CR>', function()
        require('mini.files').go_in { close_on_file = true }
      end, {
        buffer = args.data.buf_id,
        desc = '[young] open cwd',
      })
    end,
  })
end

require('mini.statusline').setup {
  set_vim_settings = false,
}
