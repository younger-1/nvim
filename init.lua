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
require('young.packer').done()

tt()
vim.cmd [[silent! colorscheme dracula]]

tt()
require('young.gui').done()

tt()
require('young.lsp').done()

tt()

-- load all lua files in user directory
-- files are loaded in order alphabetically
-- for filename in io.popen('ls -pqAL "$HOME/.config/nvim/lua/user"'):lines() do
--   filename = filename:match('^(.*)%.lua$')
--   if filename then
--     require('user.' .. filename)
--   end
-- end
