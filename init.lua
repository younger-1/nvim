require 'young.utils.global'

require 'young.cfg.global'
require 'young.cfg.option'

require 'young.key.mappings'

require('young.key.which-key').ice()
vim.g.mapleader = ' '
require('young.plugin-loader').init()
require('young.plugin-loader').load()

vim.cmd 'syntax on'
vim.cmd 'colorscheme onedark'

require 'young.lsp'

require('young.gui').setup()
