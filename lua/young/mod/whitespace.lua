-- <https://github.com/cynix/config-nvim/blob/master/lua/config/better-whitespace.lua>

local g = vim.g
g.better_whitespace_filetypes_blacklist = { 'diff', 'gitcommit', 'help', 'Trouble', 'markdown', 'packer', 'qf' }
g.show_spaces_that_precede_tabs = 1

-- require('utils.highlight').hl { 'ExtraWhitespace', fg = '#870000' }
