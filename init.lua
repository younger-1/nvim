---[[--------------------------------------------]]---
--             Configuration for neovim             --
--             Author: younger-1@github             --
---[[--------------------------------------------]]---

--  ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
--  ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
--  ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
--  ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
--  ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
--  ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝

-- require 'young'
-- tt()
tt = tt or function() end

pcall(function()
  require('impatient').enable_profile()
end)

tt()
require 'young'

tt()
require('young.cfg').done()

tt()
xy.util.defer(function()
  require('young.packer').done()

  require('young.lsp').done()

  vim.cmd [[doautocmd BufWinEnter | doautocmd BufRead]]
end)

tt()
vim.cmd [[silent! colorscheme dracula]]

tt()
require('young.gui').done()
