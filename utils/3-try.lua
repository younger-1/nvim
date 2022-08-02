--[[
  1. my utils
--]]
local ut = require 'young.util'
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

local function extract_basename(pats)
  pp(pats)
  -- Deconstruct basename from pats
  for _, pat in ipairs(pats) do
    for _, npat in ipairs {
      -- Ordered by most specific
      'lua/(.*)/init%.lua',
      'lua/(.*)%.lua',
    } do
      local m = pat:match(npat)
      gg(m)
      if m and vim.endswith(m, 'init') then
        m = m:sub(0, -6)
      end
    end
  end
end

local _load_package = function(name)
  local basename = name:gsub('%.', '/')
  local paths = { 'lua/' .. basename .. '.lua', 'lua/' .. basename .. '/init.lua' }

  extract_basename(paths)

  -- local found = nvim__get_runtime(paths, false, {is_lua=true})
  -- if #found > 0 then
  --   local f, err = loadfile(found[1])
  --   return f or error(err)
  -- end
end

_load_package 'young.lsp.config'

local x = 1 and nil or 3
pp(x)

