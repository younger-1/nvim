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

-- [Patterns](https://www.lua.org/manual/5.1/manual.html#5.4.1)
--[[
Character Class:

  A character class is used to represent a set of characters. The following combinations are allowed in describing a character class:

    x: (where x is not one of the magic characters ^$()%.[]*+-?) represents the character x itself.
    .: (a dot) represents all characters.
    %a: represents all letters.
    %c: represents all control characters.
    %d: represents all digits.
    %l: represents all lowercase letters.
    %p: represents all punctuation characters.
    %s: represents all space characters.
    %u: represents all uppercase letters.
    %w: represents all alphanumeric characters.
    %x: represents all hexadecimal digits.
    %z: represents the character with representation 0.
    %x: (where x is any non-alphanumeric character) represents the character x. This is the standard way to escape the magic characters. Any punctuation character (even the non magic) can be preceded by a '%' when used to represent itself in a pattern.
    [set]: represents the class which is the union of all characters in set. A range of characters can be specified by separating the end characters of the range with a '-'. All classes %x described above can also be used as components in set. All other characters in set represent themselves. For example, [%w_] (or [_%w]) represents all alphanumeric characters plus the underscore, [0-7] represents the octal digits, and [0-7%l%-] represents the octal digits plus the lowercase letters plus the '-' character.

    The interaction between ranges and classes is not defined. Therefore, patterns like [%a-z] or [a-%%] have no meaning.
    [^set]: represents the complement of set, where set is interpreted as above.

  For all classes represented by single letters (%a, %c, etc.), the corresponding uppercase letter represents the complement of the class. For instance, %S represents all non-space characters.

  The definitions of letter, space, and other character groups depend on the current locale. In particular, the class [a-z] may not be equivalent to %l.

Pattern Item:

  A pattern item can be

    a single character class, which matches any single character in the class;
    a single character class followed by '*', which matches 0 or more repetitions of characters in the class. These repetition items will always match the longest possible sequence;
    a single character class followed by '+', which matches 1 or more repetitions of characters in the class. These repetition items will always match the longest possible sequence;
    a single character class followed by '-', which also matches 0 or more repetitions of characters in the class. Unlike '*', these repetition items will always match the shortest possible sequence;
    a single character class followed by '?', which matches 0 or 1 occurrence of a character in the class;
    %n, for n between 1 and 9; such item matches a substring equal to the n-th captured string (see below);
    %bxy, where x and y are two distinct characters; such item matches strings that start with x, end with y, and where the x and y are balanced. This means that, if one reads the string from left to right, counting +1 for an x and -1 for a y, the ending y is the first y where the count reaches 0. For instance, the item %b() matches expressions with balanced parentheses.

Pattern:

  A pattern is a sequence of pattern items. A '^' at the beginning of a pattern anchors the match at the beginning of the subject string. A '$' at the end of a pattern anchors the match at the end of the subject string. At other positions, '^' and '$' have no special meaning and represent themselves.

Captures:

  A pattern can contain sub-patterns enclosed in parentheses; they describe captures. When a match succeeds, the substrings of the subject string that match captures are stored (captured) for future use. Captures are numbered according to their left parentheses. For instance, in the pattern "(a*(.)%w(%s*))", the part of the string matching "a*(.)%w(%s*)" is stored as the first capture (and therefore has number 1); the character matching "." is captured with number 2, and the part matching "%s*" has number 3.

  As a special case, the empty capture () captures the current string position (a number). For instance, if we apply the pattern "()aa()" on the string "flaaap", there will be two captures: 3 and 5.

  A pattern cannot contain embedded zeros. Use %z instead.
]]

-- [[string]]
-- <https://somedudesays.com/2019/12/lua-string-operations/>

local s = 'hello world'
local ans = { string.find(s, 'll', 1, true) }
pp(ans) -- { 3, 4 }
local ans = { string.find(s, '^hel') }
pp(ans) -- { 1, 3 }
pp(s:sub(2)) -- "ello world"
pp(s:sub(1, 2)) -- "he"
pp(s:sub(-2)) -- "ld"
pp(s:sub(1, -2)) -- "hello worl"
pp(s:match '%s') -- " "

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

local init_path = debug.getinfo(1, 'S').source:sub(2)
pp('[debug.getinfo 1]: ', init_path)

local line = debug.getinfo(1, 'l').currentline
pp('[debug.getinfo 2]: ', line)

pp('[debug.getinfo 3]: ', debug.getinfo(vim.api.nvim__get_runtime, 'S'))

local what
local function d1()
  local level = 1
  local function d2(aa)
    aa = 1
    local bb = '2'
    pp('[debug.getinfo d2]: ', debug.getinfo(1, what))

    print('[debug.getlocal 1]: ', debug.getlocal(level, 1))
    print('[debug.getlocal 2]: ', debug.getlocal(level, 2))
    print('[debug.getlocal 3]: ', debug.getlocal(level, 3))

    print('[debug.traceback 0]: ', debug.traceback())
    print('[debug.traceback 1]: ', debug.traceback("", 1))
    print('[debug.traceback 2]: ', debug.traceback("", 2))
    print('[debug.traceback 3]: ', debug.traceback("", 3))
  end
  pp('[debug.getinfo d1]: ', debug.getinfo(1, what))
  d2()
end

pp('[debug.getinfo main]: ', debug.getinfo(1, what))
d1()
