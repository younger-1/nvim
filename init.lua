pcall(require, 'impatient')

require('young.cfg').once()

require('young.plugin-loader').done()

vim.cmd 'colorscheme monokai'

require 'young.lsp'

require('young.gui').setup()
