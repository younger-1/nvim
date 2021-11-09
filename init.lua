require 'young.utils.global'

require 'young.cfg.settings'

require 'young.key.mappings'.config()

vim.g.mapleader = ' '
require 'plugins'

vim.cmd 'syntax on'
vim.cmd 'colorscheme onedark'

require 'young.key.mappings'.setup()

require 'lsp'
