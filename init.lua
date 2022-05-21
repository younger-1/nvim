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

_G.ytime = {
  os = os.clock(),
  a = vim.fn.reltime(),
}

pcall(function()
  require('impatient').enable_profile()
end)

ytime.b = vim.fn.reltime()
require('young.cfg').done()

ytime.c = vim.fn.reltime()
require('young.packer').done()

ytime.d = vim.fn.reltime()
-- vim.cmd [[ syntax clear ]]
vim.schedule(function()
  vim.cmd [[ silent! colorscheme dracula ]]
end)

ytime.e = vim.fn.reltime()
require('young.gui').done()

ytime.f = vim.fn.reltime()
