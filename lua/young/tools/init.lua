vim.cmd [[command! Scratch lua require'young.tools.demo'.makeScratch()]]
vim.cmd [[command! Md2HTML lua require'young.tools.demo'.convertFile()]]
vim.cmd [[command! -nargs=+ -complete=dir -bar Grepp lua require'young.tools.demo'.asyncGrep(<q-args>)]]

-- vim.api.nvim_command [[autocmd CursorHold   * lua require'young.tools.blame'.blameVirtText()]]
-- vim.api.nvim_command [[autocmd CursorMoved  * lua require'young.tools.blame'.clearBlameVirtText()]]
-- vim.api.nvim_command [[autocmd CursorMovedI * lua require'young.tools.blame'.clearBlameVirtText()]]
-- vim.api.nvim_command [[hi! link GitLens Comment]]
