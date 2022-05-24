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
-- <https://vi.stackexchange.com/questions/23287/how-can-i-calculate-the-duration-of-a-function-call>
-- os.clock(): not useful, CPU time
-- uv.now(): not useful, cached at the start of the event loop tick
-- uv.gettimeofday(): in second
local test_time = function()
  local a_time = os.clock()
  local b_time = vim.fn.reltime()
  local c_time = uv.uptime()
  local d_time = uv.hrtime()

  local max = 2000
  for i = 1, max do
    for j = 1, max do
      for k = 1, max do
        local a = i * j * k
      end
    end
  end

  pp(os.clock() - a_time)
  pp(vim.fn.reltimefloat(vim.fn.reltime(b_time)))
  pp(uv.uptime() - c_time)
  pp((uv.hrtime() - d_time) / 1e9)
end
test_time()
