-- @test code
--[[
local color = '#ade9ff'
local cmd = 'hi MyHL guifg=' .. color

print(cmd)

vim.cmd(cmd)

vim.api.nvim_buf_add_highlight(0, 12, 'MyHL', 1, 3, -1)
]]

require('luapad').setup {
  count_limit = 150000,
  -- error_indicator = false,
  eval_on_change = true,
  -- eval_on_move = true,
  -- print_highlight = 'Comment'
  -- error_highlight = 'WarningMsg',
  -- split_orientation = 'horizontal',
  on_init = function()
    print 'Hello from Luapad!'
  end,
  -- context = {},
}

xy.command {
  'LuapadToggle',
  require('luapad').toggle,
  desc = 'Toggle luapad'
}
