require 'young.utils.global'

require 'young.cfg.settings'

require 'young.key.mappings'

require 'young.key.which-key'.ice()
vim.g.mapleader = ' '
require 'young.plugin-loader'.init()
require 'young.plugin-loader'.load()

vim.cmd 'syntax on'
vim.cmd 'colorscheme onedark'

require 'young.lsp'
