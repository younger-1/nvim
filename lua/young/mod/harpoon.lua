local mark = require 'harpoon.mark'
local ui = require 'harpoon.ui'
local term = require 'harpoon.term'

local map = vim.keymap.set

map('n', '<leader>oa', mark.add_file)

-- map('n', '<leader>oo', ui.toggle_quick_menu)
map('n', '<leader>oo', function()
  if vim.v.count == 0 then
    ui.toggle_quick_menu()
  end
  ui.nav_file(vim.v.count)
end)
-- map('n', '<leader>on', function()
--   ui.nav_file(2)
-- end)
-- map('n', '<leader>oe', function()
--   ui.nav_file(3)
-- end)
-- map('n', '<leader>oi', function()
--   ui.nav_file(4)
-- end)

-- map('n', '<leader>ol', function()
--   term.gotoTerminal(1)
-- end)
-- map('n', '<leader>ou', function()
--   term.gotoTerminal(2)
-- end)
