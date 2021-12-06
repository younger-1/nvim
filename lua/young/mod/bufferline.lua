local nmap = require('young.key').nmap

nmap('<TAB>', ':BufferLineCycleNext<CR>')
nmap('<S-TAB>', ':BufferLineCyclePrev<CR>')

local colors = {
  foreground = '#E5E9F0',
  background = '#2E3440',
  yellow = '#d4d198',
  green = '#98C379',
  black = '#2b2e36',
  blue = '#5d8ac2',
  grey = '#3B4048',
  purple = '#c487b9',
  red = '#d94848',
  light_blue = '#8fc6e3',
  blue_green = '#4EC9B0',
  line_color = '#353c4a',
}

require('bufferline').setup {
  highlights = {
    fill = {
      guibg = colors.background,
    },
    --[[ buffer_visible = {
            guifg = '<color-value-here>',
            guibg = '<color-value-here>'
        }, ]]
    buffer_selected = {
      guifg = colors.foreground,
      guibg = colors.line_color,
      gui = 'bold,italic',
    },
    --[[ separator_selected = {
			guifg = colors.purple,
			guibg = colors.purple
        },
        separator_visible = {
			guifg = colors.purple,
			guibg = colors.purple
        },
        separator = {
			guifg = colors.purple,
			guibg = colors.purple
        }, ]]
    modified = {
      guifg = colors.yellow,
    },
    modified_visible = {
      guifg = colors.yellow,
    },
    modified_selected = {
      guifg = colors.yellow,
    },
  },
}
