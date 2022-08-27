-- <https://github.com/andrewferrier/dotfiles/blob/main/common/.config/nvim/lua/plugins/text_case.lua>
-- Do NOT run setup, otherwise it creates default keybindings
-- require("textcase").setup({})

local hydra = require 'hydra'

hydra {
  config = {
    exit = true,
  },
  name = 'Change case',
  mode = 'n',
  body = 'gyc',
  heads = {
    {
      'k',
      function()
        require('textcase').operator 'to_snake_case'
      end,
      { desc = 'snake case' },
    },
    {
      '-',
      function()
        require('textcase').operator 'to_dash_case'
      end,
      { desc = 'dash-case' },
    },
    {
      'C',
      function()
        require('textcase').operator 'to_constant_case'
      end,
      { desc = 'CONSTANT CASE' },
    },
    {
      '.',
      function()
        require('textcase').operator 'to_dot_case'
      end,
      { desc = 'dot.case' },
    },
    {
      'c',
      function()
        require('textcase').operator 'to_camel_case'
      end,
      { desc = 'camelCase' },
    },
    {
      't',
      function()
        require('textcase').operator 'to_title_case'
      end,
      { desc = 'Title Case' },
    },
    {
      '/',
      function()
        require('textcase').operator 'to_path_case'
      end,
      { desc = 'path/case' },
    },
    {
      -- sentence
      's',
      function()
        require('textcase').operator 'to_phrase_case'
      end,
      { desc = 'Sentence case' },
    },
    {
      -- mixed case
      'm',
      function()
        require('textcase').operator 'to_pascal_case'
      end,
      { desc = 'MixedCase' },
    },

    { '<Esc>', nil, { exit = true } },
  },
}
