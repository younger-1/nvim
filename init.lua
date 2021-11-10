require 'young.utils.global'

require 'young.cfg.settings'

require 'young.key.mappings'

require 'young.key.which-key'.ice()
vim.g.mapleader = ' '
require 'plugins'

vim.cmd 'syntax on'
vim.cmd 'colorscheme onedark'

require 'lsp'
