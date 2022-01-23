require('young.cfg').once()

pcall(require, 'impatient')

require('young.plugin-loader').done()

vim.cmd 'syntax on'
vim.cmd 'colorscheme onedark'

require 'young.lsp'

require('young.gui').setup()
