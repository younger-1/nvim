-- vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })

local M = {}

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
  auto_hide = false,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Enable/disable close button
  closable = true,

  -- Excludes buffers from the tabline
  -- exclude_ft = { "javascript" },
  -- exclude_name = { "package.json" },

  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  -- icons = "both",

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
  maximum_padding = 2,

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

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,
}

M.hot = function()
  require('young.key.mappings').load {
    normal_mode = {
      ['<S-l>'] = ':BufferNext<CR>',
      ['<S-h>'] = ':BufferPrevious<CR>',
    },
  }
end

return M
