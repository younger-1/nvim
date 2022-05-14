--[[
  1. my utils
--]]
local ut = require 'young.utils'
local m3 = ut.apply_defaults(m, { a = 'lua', d = 'zig' })
print(vim.inspect(m3)) -- { a = "python", b = "rust", c = "go", d = "zig" }

local t3 = { 'a', 'x', 3 }
ut.add_to_set(t3, { 'x', 3, 'x' })
print(vim.inspect(t3))

-- time
local test_time = function()
  local a_time = os.clock()
  local b_time = vim.fn.reltime()

  local max = 2000
  for i = 1, max do
    for j = 1, max do
      for k = 1, max do
        local a = i * j * k
      end
    end
  end

  pp(os.clock() - a_time)
  pp(vim.fn.reltimestr(vim.fn.reltime(b_time)))
  pp(vim.fn.reltimefloat(vim.fn.reltime(b_time)))
end
