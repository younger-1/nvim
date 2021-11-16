-- <https://github.com/numToStr/Comment.nvim>
require('Comment').setup {
  ignore = "^$",
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
}
