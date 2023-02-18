local M = {}

local dial = require 'dial'

--[[

1. Current augends
:DialShowSearchList

pp(require "dial".config)
  normal = { "number#decimal", "number#hex", "number#binary", "date#[%Y/%m/%d]", "date#[%m/%d]", "date#[%Y-%m-%d]", "date#[%H:%M]", "date#[%jA]", "color#hex" },
  visual = { "number#decimal", "number#hex", "number#binary", "date#[%Y/%m/%d]", "date#[%m/%d]", "date#[%Y-%m-%d]", "date#[%H:%M]", "color#hex", "char#alph#small#word", "char#alph#capital#word" }

2. Provided augends
pp(require 'dial'.augends)

--]]

-- Add a few of augends into default searchlist
local settings = {
  'number#decimal#fixed#zero',
  'markup#markdown#header',
}

local function add_true_false()
  -- Toggle true / false
  dial.augends['custom#boolean'] = dial.common.enum_cyclic {
    name = 'boolean',
    strlist = { 'true', 'false' },
  }

  -- For Languages which prefer True/False, e.g. python.
  dial.augends['custom#Boolean'] = dial.common.enum_cyclic {
    name = 'Boolean',
    strlist = { 'True', 'False' },
  }

  vim.list_extend(settings, {
    'custom#Boolean',
    'custom#boolean',
  })
end

local function add_direction()
  dial.augends['custom#up_down'] = dial.common.enum_cyclic {
    name = 'up_down',
    strlist = { 'up', 'down' },
  }

  dial.augends['custom#left_right'] = dial.common.enum_cyclic {
    name = 'left_right',
    strlist = { 'left', 'right' },
  }

  vim.list_extend(settings, {
    'custom#up_down',
    'custom#left_right',
  })
end

M.once = function()
  vim.cmd [[
    map + <Plug>(dial-increment)
    map - <Plug>(dial-decrement)
    xmap g+ <Plug>(dial-increment-additional)
    xmap g- <Plug>(dial-decrement-additional)
  ]]
end

M.done = function()
  add_true_false()
  add_direction()
  -- TODO:on,off,yes,no

  -- dial.config.searchlist.normal = settings

  -- for _, v in ipairs(settings) do
  --   table.insert(dial.config.searchlist.normal, v)
  -- end

  xy.util.add_to_set(dial.config.searchlist.normal, settings)
end

return M
