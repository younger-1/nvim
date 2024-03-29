--@Important to lua LSP, from `lua-dev`
-- vim = require("vim.shared")
-- vim = require("vim.uri")
-- vim = require("vim.inspect")

-- vim.lsp = require("vim.lsp")
-- vim.diagnostic = require("vim.diagnostic")
-- vim.treesitter = require("vim.treesitter")
-- vim.highlight = require("vim.highlight")

vim.lsp.get_active_clients()
vim.lsp.buf.hover()

local iter = require 'plenary.iterators'
local it = iter.iter { b = 'rust', c = 'go', a = 'python' }
it:for_each(function(k, v)
  print(v .. ':' .. k)
end)

-- Should not be required, not in lua runtime.path
require 'plenary.filetypes.base'

local t = { 'hi' }
function t:say(k)
  pp(self)
  self[2] = 3
end
t:say(3)
pp(t)

local x = {
  a = 3,
}
local mt = { 'hi' }
-- mt.__index = {
--   a = 6,
--   c = 5,
-- }
function mt:__index(k)
  self[k] = 'bye~'
  return self[k]
end

setmetatable(x, mt)

pp(x.a)
pp(x.c)
pp(mt)
