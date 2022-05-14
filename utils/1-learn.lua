--[[
  0. Builtins
  [](http://www.lua.org/manual/5.1/manual.html#5.1)
--]]

local function p(...)
  print(...)
  print(..., 'hi')
  print('hi', ...)
end
-- p(1,2,3)
-- 1 2 3
-- 1 hi
-- hi 1 2 3

-- assert (v [, message])
-- Issues an error when the value of its argument v is false (i.e., nil or false);
-- otherwise, returns all its arguments. message is an error message; when absent, it defaults to "assertion failed!"
assert(3)

-- loadstring (string [, chunkname])
-- If there are no errors, returns the compiled chunk as a function; otherwise, returns nil plus the error message
-- To load and run a given string, use the idiom: assert(loadstring(s))()
local func = loadstring [[local a = 4]]
func()

-- print(loadstring [[1 + 4]])
-- assert(loadstring [[1 + 4]])

-- executing the function return by loadstring
local a = loadstring [[return 6]]()
print(type(a)) -- number

local b = loadstring [[require('lspconfig')]]()
print(type(b)) -- nil

-- WARN:
pp(loadstring [[return require('lspconfig')]]())

-- [unpack](https://www.lua.org/pil/5.1.html)
---@returns all elements from the array, starting from index 1
-- print(unpack { 10, 20, 30 }) --> 10   20   30
-- local a, b = unpack { 10, 20, 30 } -- a=10, b=20, 30 is discarded

local function fup(x)
  local ta = {}
  while #ta ~= x do
    ta[#ta + 1] = #ta + 1
  end
  return unpack(ta)
end
-- pp { fup(3), fup(2), fup(1) }
-- pp { unpack { 2, 3, 4 }, unpack { 5, 6, 7 } }

-- [select](https://stackoverflow.com/questions/6929117/what-does-it-do-for-i-1-select)
-- print(select(1, "a", "b", "c"))  --> a b c
-- print(select(2, "a", "b", "c"))  --> b c
-- print(select(3, "a", "b", "c"))  --> c
-- print(select(-1, "a", "b", "c")) --> c
-- print(select "#") --> 0
-- print(select("#", { 1, 2, 3 })) --> 1 (single table as argument)
-- print(select("#", 1, 2, 3)) --> 3
-- print(select("#", { 1, 2, 3 }, 4, 5, { 6, 7, 8 })) --> 4 (a table, 2 numbers, another table)

-- [ipairs]
-- local f = function(...)
--   local first, second = select(1, ...)
--   local last = select(#{ ... }, ...)
--   for _, value in ipairs { ... } do
--     pp(value)
--   end
-- end
-- f("a", 1, "b", 2)

-- [pairs]
-- local tt = { "c", name = "May", "a", "z" }
-- for k, v in pairs(tt) do
--   print(k, v)
-- end

-- [](https://stackoverflow.com/questions/41349526/how-to-iterate-lua-table-from-end)
-- local mytable = { "a", "b", "c" }
-- for i = 1, #mytable do
--   print(mytable[#mytable + 1 - i])
-- end
-- for i = #mytable, 1, -1 do
--   value = mytable[i]
--   print(i .. ": " .. value)
-- end

-- [load]
-- [](https://stackoverflow.com/questions/52230434/eval-function-in-lua-5-1)
-- @return parses a string and returns a function that would execute that code
-- :lua load "print(1,2,3)"()
-- local fun = load "print(1,2,3)"

-- [pcall](https://www.lua.org/pil/8.4.html)
-- local status_ok, res = pcall(require, "gitlinker")
-- pp(status_ok)
-- pp "--"
-- pp(res)
-- local status, err = pcall(function() error { code = 121 } end)
-- print(err.code) -->  121

-- [[table]]
---@version >5.2, JIT
-- local a = table.pack(4, 6, 5)

-- local s = table.concat({ 3, 4, 5 }, "-")
-- print(vim.inspect(s)) -- "3-4-5"

-- local b = { "u", "i", "o" }
-- for _, v in ipairs { "i", "p" } do
--   table.insert(b, v)
-- end
-- print(vim.inspect(b)) -- { "u", "i", "o", "i", "p" }

-- local c = { u = 3, i = 1, o = 2 }
-- for k, v in pairs { i = 3, g = 4 } do
--   c[k] = v
-- end
-- print(vim.inspect(c))

-- a.name = "small"
-- pp(table.getn(a))

-- [[string]]
-- <https://somedudesays.com/2019/12/lua-string-operations/>

-- local s = "hello world"
-- local ans = { string.find(s, "ll", 1, true) }
-- pp(ans) -- { 3, 4 }
-- local ans = { string.find(s, "^he") }
-- pp(ans) -- { 1, 2 }
-- pp(s:sub(2):match "%s") -- " "

-- [](https://www.codegrepper.com/code-examples/lua/parse+string+lua)
-- local function split(s, delimiter)
--   local result = {}
--   for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
--     table.insert(result, match)
--   end
--   return result
-- end
-- local split_string = split("Hello World!", " ")
-- pp(split_string)

pp(string.char(97, 98))
pp(string.byte 'ab')

-- [[os]]

-- <https://www.jianshu.com/p/c3c70d046bfc>
local ret = os.execute()
if ret ~= 0 then
  print('the system shell is available, ret = ' .. ret .. '\n\n')
else
  print('the system shell is not available, ret = ' .. ret .. '\n\n')
end

-- [[io]]

local openPop = assert(io.popen('ls -la', 'r'))
local output = openPop:read '*all'
openPop:close()
print(output)

-- [[debug]]
local what
local function d1()
  local level = 1
  local function d2(aa)
    aa = 1
    local bb = '2'
    pp(debug.getinfo(1, what))
    -- pp(debug.getlocal(level, 1))
    -- pp(debug.getlocal(level, 2))
    -- pp(debug.getlocal(level, 3))
  end
  pp(debug.getinfo(1, what))
  d2()
end
pp(debug.getinfo(1, what))
d1()

local init_path = debug.getinfo(1, 'S').source:sub(2)
print('[debug]: ' .. init_path)

local line = debug.getinfo(1, 'l').currentline
print('[debug]: ' .. line)

pp(debug.getinfo(vim.api.nvim__get_runtime, 'S'))
