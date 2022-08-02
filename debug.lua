--@Important to lua LSP, from `lua-dev`
-- vim = require("vim.shared")
-- vim = require("vim.uri")
-- vim = require("vim.inspect")

-- vim.lsp = require("vim.lsp")
-- vim.diagnostic = require("vim.diagnostic")
-- vim.treesitter = require("vim.treesitter")
-- vim.highlight = require("vim.highlight")

vim.lsp.buf_get_clients()
vim.lsp.buf.hover()

local iter = require 'plenary.iterators'
local it = iter.iter { b = 'rust', c = 'go', a = 'python' }
it:for_each(function(k, v)
  print(v .. ':' .. k)
end)

-- Should not be required, not in lua runtime.path
require 'plenary.filetypes.base'

local x = {
  a = 3,
  b = 4,
}

local mt = {}
-- mt.__index = {
--   c = 5,
--   a = 6,
-- }
function mt:__index(k)
  pp(self)
  pp(k)
end

setmetatable(x, mt)

pp(x.a)
pp(x.b)
pp(x.c)

local mt = {}
-- function mt.__index(t, k)
function mt:__index(k)
  if self[k] == nil then
    local ok, ret = pcall(require, 'young.' .. (self._path or '') .. k)
    -- No use: xy = ok and ret or { no = true }
    if ok then
      self[k] = ret
    else
      self[k] = { _nil = true, _path = (self._path or '') .. k .. '.' }
      setmetatable(self[k], mt)
    end
  end
  return self[k]
end

setmetatable(xy, mt)

--[[
xy.a -> require('xy').a -> require('xy.a')
xy.a.b -> require('xy').a.b -> require('xy.a').b -> require('xy.a.b')
]]
