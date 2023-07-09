-- This Vim setting controls the delay before the popup appears. The way it
-- works is, if you have mappings for, say, the key "a" and the key sequence
-- "ab", if you type "a", then Vim waits timeoutlen, and if you don't press
-- another key before that amount of time, then the "a" mapping is executed, but
-- if you press "b" before timeoutlen, then the "ab" mapping is executed.
vim.o.timeoutlen = 300

-- If you use <Space> as your mapping prefix, then this will make the key-menu
-- popup appear in Normal mode, after you press <Space>, after timeoutlen.
-- require('key-menu').set('n', '<Space>')

-- TODO:fix 'x' mappings
require('key-menu').set({ 'n', 'x' }, '<Space>')

require('key-menu').set('n', 'g')

require('key-menu').set('n', '<Space>g', { desc = 'Git' })
-- The function key-menu.set is just a thin wrapper around vim.keymap.set, and
-- is provided for convenience so that you don't have to type the key sequence
-- twice. The above call to key-menu.set is equivalent to this:
-- vim.keymap.set('n', '<Space>g', function()
--   require('key-menu').open_window '<Space>g'
-- end, { desc = 'Git' })

-- Create a mapping that does not appear in the pop up menu.
-- vim.keymap.set('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', { desc = 'HIDDEN' })
