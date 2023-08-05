local M = {}

M.once = function()
  vim.cmd [[
" Start Win-Move mode:
nnoremap <C-W><C-M> <Cmd>WinShift<CR>
" Swap two windows:
nnoremap <C-W><C-X> <Cmd>WinShift swap<CR>

nnoremap <C-M-H> <Cmd>WinShift left<CR>
nnoremap <C-M-J> <Cmd>WinShift down<CR>
nnoremap <C-M-K> <Cmd>WinShift up<CR>
nnoremap <C-M-L> <Cmd>WinShift right<CR>

nnoremap <C-M-left>  <Cmd>WinShift left<CR>
nnoremap <C-M-down>  <Cmd>WinShift down<CR>
nnoremap <C-M-up>    <Cmd>WinShift up<CR>
nnoremap <C-M-right> <Cmd>WinShift right<CR>
]]
end

M.done = function()
  require('winshift').setup {
    highlight_moving_win = true, -- Highlight the window being moved
    focused_hl_group = 'Visual', -- The highlight group used for the moving window
    moving_win_options = {
      -- These are local options applied to the moving window while it's
      -- being moved. They are unset when you leave Win-Move mode.
      wrap = false,
      cursorline = false,
      cursorcolumn = false,
      colorcolumn = '',
    },
  }
end

return M
