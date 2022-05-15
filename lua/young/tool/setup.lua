vim.cmd [[command! Scratch lua require'young.tool.demo'.makeScratch()]]
vim.cmd [[command! Md2HTML lua require'young.tool.demo'.convertFile()]]
vim.cmd [[command! -nargs=+ -complete=dir -bar Grepp lua require'young.tool.demo'.asyncGrep(<q-args>)]]

-- vim.api.nvim_command [[autocmd CursorHold   * lua require'young.tool.blame'.blameVirtText()]]
-- vim.api.nvim_command [[autocmd CursorMoved  * lua require'young.tool.blame'.clearBlameVirtText()]]
-- vim.api.nvim_command [[autocmd CursorMovedI * lua require'young.tool.blame'.clearBlameVirtText()]]
-- vim.api.nvim_command [[hi! link GitLens Comment]]
