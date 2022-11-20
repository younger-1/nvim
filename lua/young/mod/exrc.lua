-- disable built-in local config file support
vim.o.exrc = false

require('exrc').setup {
  files = {
    '.nvimrc.lua',
    '.nvimrc',
    '.exrc.lua',
    '.exrc',
  },
}
