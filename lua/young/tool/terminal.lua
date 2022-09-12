-- <https://github.com/David-Kunz/vim/blob/37eaa6b4f04fc952be4c6f055952f6406d464c2a/init.lua#L481-L544>

_G.term_buf_of_tab = _G.term_buf_of_tab or {}
_G.term_buf_max_nmb = _G.term_buf_max_nmb or 0

local function spawn_terminal()
  local cur_tab = vim.api.nvim_get_current_tabpage()
  vim.cmd 'vs | terminal'
  local cur_buf = vim.api.nvim_get_current_buf()
  _G.term_buf_max_nmb = _G.term_buf_max_nmb + 1
  vim.api.nvim_buf_set_name(cur_buf, 'Terminal ' .. _G.term_buf_max_nmb)
  table.insert(_G.term_buf_of_tab, cur_tab, cur_buf)
  vim.cmd ':startinsert'
end

function toggle_terminal()
  local cur_tab = vim.api.nvim_get_current_tabpage()
  local term_buf = term_buf_of_tab[cur_tab]
  if term_buf ~= nil then
    local cur_buf = vim.api.nvim_get_current_buf()
    if cur_buf == term_buf then
      vim.cmd 'q'
    else
      local win_list = vim.api.nvim_tabpage_list_wins(cur_tab)
      for _, win in ipairs(win_list) do
        local win_buf = vim.api.nvim_win_get_buf(win)
        if win_buf == term_buf then
          vim.api.nvim_set_current_win(win)
          vim.cmd ':startinsert'
          return
        end
      end
      vim.cmd('vert sb' .. term_buf)
      vim.cmd ':startinsert'
    end
  else
    spawn_terminal()
    vim.cmd ':startinsert'
  end
end

vim.keymap.set('n', '<c-y>', toggle_terminal)
vim.keymap.set('i', '<c-y>', '<ESC>:lua toggle_terminal()<CR>')
vim.keymap.set('t', '<c-y>', '<c-\\><c-n>:lua toggle_terminal()<CR>')

_G.send_line_to_terminal = function()
  local curr_line = vim.api.nvim_get_current_line()
  local cur_tab = vim.api.nvim_get_current_tabpage()
  local term_buf = term_buf_of_tab[cur_tab]
  if term_buf == nil then
    spawn_terminal()
    term_buf = term_buf_of_tab[cur_tab]
  end
  for _, chan in pairs(vim.api.nvim_list_chans()) do
    if chan.buffer == term_buf then
      chan_id = chan.id
    end
  end
  vim.api.nvim_chan_send(chan_id, curr_line .. '\n')
end

vim.keymap.set('n', '<leader>x', ':lua send_line_to_terminal()<CR>')
