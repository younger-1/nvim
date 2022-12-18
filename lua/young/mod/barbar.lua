-- Very Dynamic
-- call dictwatcheradd(g:bufferline, '*', 'BufferlineOnOptionChanged')
-- function! BufferlineOnOptionChanged(d, k, z)
--    let g:bufferline = extend(s:DEFAULT_OPTIONS, get(g:, 'bufferline', {}))
--    if a:k == 'letters'
--       call luaeval("require'bufferline.jump_mode'.initialize_indexes()")
--    end
-- endfunc

vim.g.bufferline = {
  -- Enable/disable animations
  animation = true,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = true,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enable/disable close button
  closable = true,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
  exclude_ft = { 'git', 'fugitive' },
  -- exclude_name = { "package.json" },

  -- Show every buffer
  -- hide = { current = false, inactive = false, visible = false },

  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  -- if set to 'buffer_number', will show buffer number in the tabline
  -- if set to 'buffer_number_with_icon', will show buffer number and icons in the tabline
  icons = 'both',

  -- Sets the icon's highlight group.
  -- If false, will use nvim-web-devicons colors
  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  icon_custom_colors = false,

  -- Configure icons on the bufferline.
  icon_separator_active = '▌',
  icon_separator_inactive = '▎',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  -- icon_pinned = "📌",
  icon_pinned = '車',

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  -- maximum_padding = 2,

  -- Sets the minimum padding width with which to surround each tab
  -- minimum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  -- letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  -- no_name_title = "Empty",
}

-- vim.cmd 'BarbarEnable'
xy.map.n { '<S-l>', '<cmd>BufferNext<CR>' }
xy.map.n { '<S-h>', '<cmd>BufferPrevious<CR>' }
-- vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })
