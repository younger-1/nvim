-- https://github.com/haya14busa/vim-asterisk
-- But z is conflick with vim-sneak and lightspeed.nvim

-- vim.cmd [[
--   let g:asterisk#keeppos = 1
--   map *   <Plug>(asterisk-*)
--   map #   <Plug>(asterisk-#)
--   map g*  <Plug>(asterisk-g*)
--   map g#  <Plug>(asterisk-g#)
--
--   map z*  <Plug>(asterisk-z*)
--   map gz* <Plug>(asterisk-gz*)
--   map z#  <Plug>(asterisk-z#)
--   map gz# <Plug>(asterisk-gz#)
-- ]]

vim.cmd [[
  let g:asterisk#keeppos = 1
  map *  <Plug>(asterisk-z*)
  map #  <Plug>(asterisk-z#)
  map g* <Plug>(asterisk-gz*)
  map g# <Plug>(asterisk-gz#)
]]
