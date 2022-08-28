-- <https://github.com/numToStr/Comment.nvim>
local M = {}

local _ts_comment = function()
  local ok, ts_internal = pcall(require, 'ts_context_commentstring.internal')
  return ok and ts_internal.calculate_commentstring() or nil
end

M.done = function()
  require('Comment').setup {
    ignore = '^$',
    ---LHS of toggle mappings in NORMAL + VISUAL mode
    ---@type table
    toggler = {
      ---line-comment keymap
      line = 'gcc',
      ---block-comment keymap
      block = 'gCC',
    },
    ---LHS of operator-pending mappings in NORMAL + VISUAL mode
    ---@type table
    opleader = {
      ---line-comment keymap
      line = 'gc',
      ---block-comment keymap
      block = 'gC',
    },
    mappings = {
      ---operator-pending mapping
      ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
      ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
      basic = true,
      ---extra mapping
      ---Includes `gco`, `gcO`, `gcA`
      extra = true,
      ---extended mapping
      ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      extended = false,
    },
    pre_hook = _ts_comment,
  }
end

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

return M
