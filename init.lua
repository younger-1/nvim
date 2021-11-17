require('young.cfg').once()
require('young.plugin-loader').done()

vim.cmd 'syntax on'
vim.cmd 'colorscheme onedark'

require 'young.lsp'

require('young.gui').setup()
