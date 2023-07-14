-- local _ts_comment = function()
--   local ok, ts_internal = pcall(require, 'ts_context_commentstring.internal')
--   return ok and ts_internal.calculate_commentstring() or nil
-- end

local pre_hook
local loaded, ts_comment = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
if loaded and ts_comment then
  pre_hook = ts_comment.create_pre_hook()
end

require('Comment').setup {
  ---Lines to be ignored while comment/uncomment.
  ---Could be a regex string or a function that returns a regex string.
  ---Example: Use '^$' to ignore empty lines
  ---@type string|function
  ignore = nil,
  -- ignore = '^$',

  ---Whether to create basic (operator-pending) and extra mappings for NORMAL/VISUAL mode
  ---@type table
  mappings = {
    ---operator-pending mapping
    ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
    ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
    basic = true,
    ---extra mapping
    ---Includes `gco`, `gcO`, `gcA`
    extra = true,
  },

  ---LHS of toggle mappings in NORMAL mode
  ---@type table
  toggler = {
    ---line-comment toggle
    line = 'gcc',
    ---block-comment toggle
    block = 'gcl',
  },

  ---LHS of operator-pending mappings in NORMAL and VISUAL mode
  ---@type table
  opleader = {
    ---line-comment opfunc mapping
    line = 'gc',
    ---block-comment opfunc mapping
    block = 'gcm',
  },

  ---LHS of extra mappings
  ---@type table
  -- extra = {
  --   ---Add comment on the line above
  --   above = 'gcO',
  --   ---Add comment on the line below
  --   below = 'gco',
  --   ---Add comment at the end of line
  --   eol = 'gcA',
  -- },

  ---Pre-hook, called before commenting the line
  ---@type function|nil
  pre_hook = pre_hook,
  -- pre_hook = _ts_comment,

  ---Post-hook, called after commenting is done
  ---@type function|nil
  post_hook = nil,
}

--[[
# Linewise

`gcw` - Toggle from the current cursor position to the next word
`gc$` - Toggle from the current cursor position to the end of line
`gc}` - Toggle until the next blank line
`gcip` - Toggle inside of paragraph
`gca}` - Toggle around curly brackets

# Blockwise

`gC2}` - Toggle until the 2 next blank line
`gCaf` - Toggle comment around a function (w/ LSP/treesitter support)
`gCac` - Toggle comment around a class (w/ LSP/treesitter support)
--]]
