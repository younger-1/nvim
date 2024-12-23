--[[
  1. vim
--]]
local t = { 'a', 'b', 'c' }
local m = { b = 'rust', c = 'go', a = 'python' }
vim.list_extend(t, { 'c', 'd' })
-- print(vim.inspect(t)) -- { "a", "b", "c", "c", "d" }
-- print(vim.inspect(vim.tbl_keys(t))) -- { 1, 2, 3, 4, 5 }
-- print(vim.inspect(vim.tbl_keys(m))) -- { "b", "c", "a" }
-- print(vim.inspect(vim.tbl_values(t))) -- { "a", "b", "c", "c", "d" }

t = vim.tbl_extend('force', t, { 'x', 'y', 1, 2 })
print(vim.inspect(t)) -- { "x", "y", 1, 2, "d" }
-- print(vim.islist(t)) -- true

-- m = vim.tbl_extend("force", m, { b = "GG" })
-- pp(m)

local t1 = vim.list_slice(t, 2, 3)
-- print(vim.inspect(t1)) -- { "y", "1" }

t1 = vim.tbl_filter(function(value)
  return type(value) == 'number'
end, t)
-- print(vim.inspect(t1)) -- { 1, 2 }

t1 = vim.tbl_map(function(value)
  return value .. 0
end, t)
-- print(vim.inspect(t1)) -- { "x0", "y0", "10", "20", "d0" }

local m1 = vim.tbl_deep_extend('force', m, {
  b = { 6, 7 },
})
m1 = vim.tbl_deep_extend('force', m1, {
  b = { 'hi', bb = { 8, 9 } },
})

--[[
  2. vim.loop
--]]
-- Reference: https://github.com/luvit/luv/blob/master/docs.md
-- Examples:  https://github.com/luvit/luv/tree/master/examples

local uv = vim.loop

local stdin = uv.new_pipe(false)
local stdout = uv.new_pipe(false)
local stderr = uv.new_pipe(false)

local handle, pid = uv.spawn('fd', {
  args = { '.snippets' },
  stdio = { stdin, stdout, stderr },
}, function() end)

uv.read_start(stdout, function(err, data)
  assert(not err, err)
  if data then
    pp(data)
  end
end)

uv.read_start(stderr, function() end)

uv.shutdown(stdin, function()
  uv.close(handle, function() end)
end)

--[[
  3. plenary
--]]

-- [tbl]
local tbl = require 'plenary.tbl'
local t2 = tbl.pack(4, 6, 5)

-- [functional]
local fcl = require 'plenary.functional'

local m2 = fcl.kv_pairs(m)
-- print(vim.inspect(m2)) -- { { "b", "rust" }, { "c", "go" }, { "a", "python" } }

m2 = fcl.kv_map(function(elem)
  return elem[2] .. ',' .. elem[1]
end, m)
-- print(vim.inspect(m2)) -- { "rust,b", "go,c", "python,a" }

-- t2 = table.concat(t, "|")
t2 = fcl.join(t, '|')
-- print(vim.inspect(t2)) -- "x|y|1|2|d"

-- [iterators]
---@contains iter, wrap, unwrap, range, duplicate, from_fun, zeros, ones, rands, split, words, lines, chain, zip
---@methods of Iterator: for_each, stateful, map, flatten, filter, any, all, find, tolist, tolistn, tomap,
local iter = require 'plenary.iterators'
local it = iter.iter(m)
it:for_each(function(k, v)
  print(v .. ':' .. k)
end)
m2 = it
  :map(function(k, v)
    return v .. ':' .. k
  end)
  :tolist()
print(vim.inspect(m2)) -- { "rust:b", "go:c", "python:a" }

-- [path]
-- :h telescope.changelog-473
-- Guide to switch over to plenary.path
--     - separator
--         before: require("telescope.path").separator
--         now:    require("plenary.path").path.sep
--     - home
--         before: require("telescope.path").home
--         now:    require("plenary.path").path.home
--     - make_relative
--         before: require("telescope.path").make_relative(filepath, cwd)
--         now:    require("plenary.path"):new(filepath):make_relative(cwd)
--     - shorten
--         before: require("telescope.path").shorten(filepath)
--         now:    require("plenary.path"):new(filepath):shorten()
--                 with optional len, default is 1
--     - normalize
--         before: require("telescope.path").normalize(filepath, cwd)
--         now:    require("plenary.path"):new(filepath):normalize(cwd)
--     - read_file
--         before: require("telescope.path").read_file(filepath)
--         now:    require("plenary.path"):new(filepath):read()
--     - read_file_async
--         before: require("telescope.path").read_file_async(filepath, callback)
--         now:    require("plenary.path"):new(filepath):read(callback)

-- [Job]

local Job = require 'plenary.job'
Job
  :new({
    command = 'fd',
    args = { '.py' },
    -- command = 'rg',
    -- args = { '--files', '.' },
    -- command = 'sleep',
    -- args = { '2' },
    on_exit = function(this, code, signal)
      pp(this:result(), code, signal)
    end,
  })
  -- :sync()
  :start()
