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

if vim.loader then
  vim.loader.enable()
end

-- require 'young'
-- tt()
tt = tt or function() end

tt()
require 'young'

tt()
require('young.cfg').done()

tt()
-- xy.util.defer(function()
--   require('young.packer').done()
--   require('young.lsp').done()
--   vim.cmd [[doautocmd BufWinEnter | doautocmd BufReadPost | doautocmd FileType]]
-- end)
require 'young.lazy'

tt()
vim.cmd [[
" colorscheme habamax
" silent! colorscheme dracula
" silent! colorscheme dracula-soft
" silent! colorscheme tokyonight
" silent! colorscheme nightfox
silent! colorscheme kanagawa
" silent! colorscheme github_dark
" silent! colorscheme github_dark_dimmed
" silent! colorscheme github_dark_colorblind
" silent! colorscheme github_dark_high_contrast
]]

tt()
require('young.gui').done()
