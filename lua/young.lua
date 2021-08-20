vim = vim
vim.g.mapleader = " "
-- vim.opt.termguicolors = true

-- local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
-- 
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then vim.fn.system({
--     'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path
--   })
--   vim.cmd 'packadd packer.nvim'
-- end

vim.cmd [[command! Scratch lua require'tools'.makeScratch()]]
vim.cmd [[command! Md2HTML lua require'tools'.convertFile()]]
vim.cmd [[command! -nargs=+ -complete=dir -bar Grepp lua require'tools'.asyncGrep(<q-args>)]]

-- vim.api.nvim_command [[autocmd CursorHold   * lua require'utils'.blameVirtText()]]
-- vim.api.nvim_command [[autocmd CursorMoved  * lua require'utils'.clearBlameVirtText()]]
-- vim.api.nvim_command [[autocmd CursorMovedI * lua require'utils'.clearBlameVirtText()]]
-- vim.api.nvim_command [[hi! link GitLens Comment]]

