require('smart-splits').setup {
  -- Ignored filetypes (only while resizing)
  ignored_filetypes = {
    'nofile',
    'quickfix',
    'prompt',
  },
  -- Ignored buffer types (only while resizing)
  ignored_buftypes = {
    'NvimTree',
  },
}

-- local amount = 3
-- require('smart-splits').resize_up(amount)
-- require('smart-splits').resize_down(amount)
-- require('smart-splits').resize_left(amount)
-- require('smart-splits').resize_right(amount)

-- vim.cmd [[
-- " resizing splits
-- nmap <A-h> <cmd>lua require('smart-splits').resize_left()<CR>
-- nmap <A-j> <cmd>lua require('smart-splits').resize_down()<CR>
-- nmap <A-k> <cmd>lua require('smart-splits').resize_up()<CR>
-- nmap <A-l> <cmd>lua require('smart-splits').resize_right()<CR>
-- " moving between splits
-- nmap <C-h> <cmd>lua require('smart-splits').move_cursor_left()<CR>
-- nmap <C-j> <cmd>lua require('smart-splits').move_cursor_down()<CR>
-- nmap <C-k> <cmd>lua require('smart-splits').move_cursor_up()<CR>
-- nmap <C-l> <cmd>lua require('smart-splits').move_cursor_right()<CR>
-- " persistent resize mode
-- nmap <C-w>r <require('smart-splits').start_resize_mode()
-- ]]

-- resizing splits
-- vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
-- vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
-- vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
-- vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
vim.keymap.set('n', '<C-Left>', require('smart-splits').resize_left)
vim.keymap.set('n', '<C-Down>', require('smart-splits').resize_down)
vim.keymap.set('n', '<C-Up>', require('smart-splits').resize_up)
vim.keymap.set('n', '<C-Right>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
-- persistent resize mode
vim.keymap.set('n', '<C-w>r', require('smart-splits').start_resize_mode)
