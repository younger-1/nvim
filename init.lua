require 'young.utils.global'

require 'settings'

vim.g.mapleader = ' '

require 'plugins'

vim.cmd 'syntax on'
vim.cmd 'colorscheme onedark'

require 'young.key.mappings'.setup()
require 'lsp'
