local M = {}

local dial = require "dial"
local utils = require("young.utils")

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
  "number#decimal#fixed#zero",
  "markup#markdown#header",
}

local function add_true_false()
  -- Toggle true / false
  dial.augends["custom#boolean"] = dial.common.enum_cyclic {
    name = "boolean",
    strlist = { "true", "false" },
  }

  -- For Languages which prefer True/False, e.g. python.
  dial.augends["custom#Boolean"] = dial.common.enum_cyclic {
    name = "Boolean",
    strlist = { "True", "False" },
  }

  utils.append_to_list(settings, {
    "custom#Boolean",
    "custom#boolean",
  })
end

M.done = function()
  vim.cmd [[
    nmap <C-a> <Plug>(dial-increment)
    nmap <C-x> <Plug>(dial-decrement)
    vmap <C-a> <Plug>(dial-increment)
    vmap <C-x> <Plug>(dial-decrement)
    vmap g<C-a> <Plug>(dial-increment-additional)
    vmap g<C-x> <Plug>(dial-decrement-additional)
  ]]

  add_true_false()

  -- dial.config.searchlist.normal = settings

  -- for _, v in ipairs(settings) do
  --   table.insert(dial.config.searchlist.normal, v)
  -- end

  utils.add_to_set(dial.config.searchlist.normal, settings)
end

return M
