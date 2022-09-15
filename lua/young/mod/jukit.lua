local M = {}

function M.once()
  -- vim.filetype.add {
  --   extension = { ipynb = 'ipynb' },
  -- }
  -- vim.cmd 'au BufRead,BufNewFile *.ipynb set syntax=json'
  -- vim.cmd 'au BufReadPost *.ipynb set syntax=json'
  -- vim.cmd 'au! Syntax ipynb source $VIMRUNTIME/syntax/json.vim'
  vim.cmd 'au BufReadPost *.ipynb PackerLoad vim-jukit'

  vim.cmd [[
""" Basic jukit options
let g:jukit_shell_cmd = 'ipython3'
"    - Specifies the command used to start a shell in the output split. Can also be an absolute path. Can also be any other shell command, e.g. `R`, `julia`, etc. (note that output saving is only possible for ipython)
let g:jukit_terminal = ''
"   - Terminal to use. Can be one of '', 'kitty', 'vimterm', 'nvimterm' or 'tmux'. If '' is given then will try to detect terminal
let g:jukit_auto_output_hist = 0
"   - If set to 1, will create an autocmd with event `CursorHold` to show saved ipython output of current cell in output-history split. Might slow down (n)vim significantly, you can use `set updatetime=<number of milliseconds>` to control the time to wait until CursorHold events are triggered, which might improve performance if set to a higher number (e.g. `set updatetime=1000`).
let g:jukit_use_tcomment = 0
"   - Whether to use tcomment plugin (https://github.com/tomtom/tcomment_vim) to comment out cell markers. If not, then cell markers will simply be prepended with `g:jukit_comment_mark`
let g:jukit_comment_mark = '#'
"   - See description of `g:jukit_use_tcomment` above
let g:jukit_mappings = 0
"   - If set to 0, none of the default function mappings (as specified further down) will be applied

  ]]

end

function M.done()
  -- xy.autogroup('jukit_python', {
  --   {
  --     'FileType',
  --     'python',
  --     function() end,
  --   },
  -- })
  -- vim.cmd [[doautoall jukit_python FileType]]

  -- local call = require('young.key').call
  -- xy.map.register {
  --   ['<leader>j'] = {
  --     m = { call '', '[py] Test method', buffer = true },
  --   },
  -- }
  vim.cmd [[
""" Splits
nnoremap <leader>cj<tab>o :call jukit#splits#output()<cr>
"   - Opens a new output window and executes the command specified in `g:jukit_shell_cmd`
nnoremap <leader>cj<tab>s :call jukit#splits#term()<cr>
"   - Opens a new output window without executing any command
nnoremap <leader>cj<tab>h :call jukit#splits#history()<cr>
"   - Opens a new output-history window, where saved ipython outputs are displayed
nnoremap <leader>cj<tab><tab> :call jukit#splits#output_and_history()<cr>
"   - Shortcut for opening output terminal and output-history
nnoremap <leader>cj<tab>O :call jukit#splits#close_history()<cr>
"   - Close output-history window
nnoremap <leader>cj<tab>H :call jukit#splits#close_output_split()<cr>
"   - Close output window
nnoremap <leader>cj<tab>c :call jukit#splits#close_output_and_history(1)<cr>
"   - Close both windows. Argument: Whether or not to ask you to confirm before closing.
nnoremap <leader>cjl :call jukit#splits#show_last_cell_output(1)<cr>
"   - Show output of current cell (determined by current cursor position) in output-history window. Argument: Whether or not to reload outputs if cell id of outputs to display is the same as the last cell id for which outputs were displayed
nnoremap <leader>cjj :call jukit#splits#out_hist_scroll(1)<cr>
"   - Scroll down in output-history window. Argument: whether to scroll down (1) or up (0)
nnoremap <leader>cjk :call jukit#splits#out_hist_scroll(0)<cr>
"   - Scroll up in output-history window. Argument: whether to scroll down (1) or up (0)
nnoremap <leader>cjt :call jukit#splits#toggle_auto_hist()<cr>
"   - Create/delete autocmd for displaying saved output on CursorHold. Also, see explanation for `g:jukit_auto_output_hist`
nnoremap <leader>cjT :call jukit#layouts#set_layout()<cr>
"   - Apply layout (see `g:jukit_layout`) to current splits - NOTE: it is expected that this function is called from the main file buffer/split

"""Sending code
nnoremap <leader>cj<space> :call jukit#send#section(0)<cr>
"   - Send code within the current cell to output split (also saves the output if ipython is used and `g:jukit_save_output==1`). Argument: if 1, will move the cursor to the next cell below after sending the code to the split, otherwise cursor position stays the same.
nnoremap <leader>cj<cr> :call jukit#send#line()<cr>
"   - Send current line to output split
vnoremap <leader>cj<cr> :<C-U>call jukit#send#selection()<cr>
"   - Send visually selected code to output split
nnoremap <leader>cju :call jukit#send#until_current_section()<cr>
"   - Execute all cells until the current cell
nnoremap <leader>cjA :call jukit#send#all()<cr>
"   - Execute all cells

"""Cells
nnoremap <leader>cjo :call jukit#cells#create_below(0)<cr>
"   - Create new code cell below. Argument: Whether to create code cell (0) or markdown cell (1)
nnoremap <leader>cjO :call jukit#cells#create_above(0)<cr>
"   - Create new code cell above. Argument: Whether to create code cell (0) or markdown cell (1)
nnoremap <leader>cjy :call jukit#cells#create_below(1)<cr>
"   - Create new textcell below. Argument: Whether to create code cell (0) or markdown cell (1)
nnoremap <leader>cjY :call jukit#cells#create_above(1)<cr>
"   - Create new textcell above. Argument: Whether to create code cell (0) or markdown cell (1)
nnoremap <leader>cjd :call jukit#cells#delete()<cr>
"   - Delete current cell
nnoremap <leader>cjs :call jukit#cells#split()<cr>
"   - Split current cell (saved output will then be assigned to the resulting cell above)
nnoremap <leader>cjM :call jukit#cells#merge_above()<cr>
"   - Merge current cell with the cell above
nnoremap <leader>cjm :call jukit#cells#merge_below()<cr>
"   - Merge current cell with the cell below
nnoremap <leader>cjK :call jukit#cells#move_up()<cr>
"   - Move current cell up
nnoremap <leader>cjJ :call jukit#cells#move_down()<cr>
"   - Move current cell down
nnoremap <leader>cjx :call jukit#cells#delete_outputs(0)<cr>
"   - Delete saved output of current cell. Argument: Whether to delete all saved outputs (1) or only saved output of current cell (0)
nnoremap <leader>cjX :call jukit#cells#delete_outputs(1)<cr>
"   - Delete saved outputs of all cells. Argument: Whether to delete all saved outputs (1) or only saved output of current cell (0)

"""ipynb conversion
nnoremap <leader>cjc :call jukit#convert#notebook_convert("jupyter-notebook")<cr>
"   - Convert from ipynb to py or vice versa. Argument: Optional. If an argument is specified, then its value is used to open the resulting ipynb file after converting script.
nnoremap <leader>cjh :call jukit#convert#save_nb_to_file(0,1,'html')<cr>
"   - Convert file to html (including all saved outputs) and open it using the command specified in `g:jukit_html_viewer'. If `g:jukit_html_viewer` is not defined, then will default to `g:jukit_html_viewer='xdg-open'`. Arguments: 1.: Whether to rerun all cells when converting 2.: Whether to open it after converting 3.: filetype to convert to
nnoremap <leader>cjH :call jukit#convert#save_nb_to_file(1,1,'html')<cr>
"   - same as above, but will (re-)run all cells when converting to html
nnoremap <leader>cjp :call jukit#convert#save_nb_to_file(0,1,'pdf')<cr>
"   - Convert file to pdf (including all saved outputs) and open it using the command specified in `g:jukit_pdf_viewer'. If `g:jukit_pdf_viewer` is not defined, then will default to `g:jukit_pdf_viewer='xdg-open'`. Arguments: 1.: Whether to rerun all cells when converting 2.: Whether to open it after converting 3.: filetype to convert to
nnoremap <leader>cjP :call jukit#convert#save_nb_to_file(1,1,'pdf')<cr>
"   - same as above, but will (re-)run all cells when converting to pdf

"""Überzug
" nnoremap <leader>pos :call jukit#ueberzug#set_default_pos()<cr>
" "   - set position and dimension of überzug window
  ]]
end

return M
