vim.on_key(function(char)
  if vim.fn.mode() == 'n' then
    local new_hlsearch = vim.tbl_contains({
      'n',
      'N',
      '*',
      '#',
      -- '<CR>',
      '?',
      '/',
    }, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end, vim.api.nvim_create_namespace 'auto_hlsearch')

if true then
  return
end

-- automatically disable search highlight
-- <https://github.com/glepnir/hlsearch.nvim>
local function stop_hl()
  if vim.v.hlsearch == 0 then
    return
  end
  local keycode = api.nvim_replace_termcodes('<Cmd>nohl<CR>', true, false, true)
  api.nvim_feedkeys(keycode, 'n', false)
end

local function start_hl()
  local res = vim.fn.getreg '/'
  if vim.v.hlsearch == 1 and vim.fn.search([[\%#\zs]] .. res, 'cnW') == 0 then
    stop_hl()
  end
end

xy.autogroup('_hls', {
  {
    'CursorMoved',
    '*',
    start_hl,
  },
  {
    'InsertEnter',
    '*',
    stop_hl,
  },
})

-- <https://github.com/rafamadriz/dotfiles/blob/2628301f9c8ee7397a796ec50c790e83cff1d57b/private_dot_config/nvim/plugin/autocommands.lua>
----------------------------------------------------------------------------------------------------
-- Chezmoi
----------------------------------------------------------------------------------------------------
if fn.executable 'chezmoi' == 1 then
  young.augroup('Chezmoi', {
    {
      event = 'BufWritePost',
      pattern = '~/.local/share/chezmoi/*',
      command = [[silent! chezmoi apply --source-path "%"]],
      desc = 'apply dotfiles modifications with chezmoi if executable',
    },
  })
end

----------------------------------------------------------------------------------------------------
-- Trim trailing white space
----------------------------------------------------------------------------------------------------
--source: https://github.com/mcauley-penney/tidy.nvim
--credits: mcauley-penney
young.augroup('TrimTrailing', {
  {
    event = 'BufWritePre',
    pattern = '*',
    command = function()
      local pos = api.nvim_win_get_cursor(0)

      -- delete all whitespace
      vim.cmd [[:keepjumps keeppatterns %s/\s\+$//e]]

      -- delete all lines at end of buffer
      vim.cmd [[:keepjumps keeppatterns silent! 0;/^\%(\n*.\)\@!/,$d]]

      --[[
          if the row value in the original cursor
          position tuple is greater than the
          line count after empty line deletion
          (meaning that the cursor was inside of
          the group of empty lines at the end of
          the file when they were deleted), set
          the cursor row to the last line
      ]]

      -- get row count after line deletion
      local end_row = api.nvim_buf_line_count(0)

      if pos[1] > end_row then
        pos[1] = end_row
      end

      api.nvim_win_set_cursor(0, pos)
    end,
  },
})
----------------------------------------------------------------------------------------------------
-- Automatically create missing directories when saving file
----------------------------------------------------------------------------------------------------
--source: https://github.com/jghauser/mkdir.nvim
--credits: jghauser
young.augroup('Mkdir', {
  {
    event = 'BufWritePre',
    pattern = '*',
    command = function()
      local dir = fn.expand '<afile>:p:h'

      if fn.isdirectory(dir) == 0 then
        fn.mkdir(dir, 'p')
      end
    end,
    desc = 'automatically create missing directories when saving file',
  },
})

----------------------------------------------------------------------------------------------------
-- HLSEARCH
----------------------------------------------------------------------------------------------------
--source: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/plugin/autocommands.lua
--credits: akinsho
--[[
In order to get hlsearch working the way I like i.e. on when using /,?,N,n,*,#, etc. and off when
When I'm not using them, I need to set the following:
The mappings below are essentially faked user input this is because in order to automatically turn off
the search highlight just changing the value of 'hlsearch' inside a function does not work
read `:h nohlsearch`. So to have this work I check that the current mouse position is not a search
result, if it is we leave highlighting on, otherwise I turn it off on cursor moved by faking my input
using the expr mappings below.
This is based on the implementation discussed here:
https://github.com/neovim/neovim/issues/5581
--]]

vim.keymap.set({ 'n', 'v', 'o', 'i', 'c' }, '<Plug>(StopHL)', 'execute("nohlsearch")[-1]', { expr = true })

local function stop_hl()
  if vim.v.hlsearch == 0 or api.nvim_get_mode().mode ~= 'n' then
    return
  end
  api.nvim_feedkeys(api.nvim_replace_termcodes('<Plug>(StopHL)', true, true, true), 'm', false)
end

local function hl_search()
  local col = api.nvim_win_get_cursor(0)[2]
  local curr_line = api.nvim_get_current_line()
  local ok, match = pcall(fn.matchstrpos, curr_line, fn.getreg '/', 0)
  if not ok then
    return vim.notify(match, 'error', { title = 'HL SEARCH' })
  end
  local _, p_start, p_end = unpack(match)
  -- if the cursor is in a search result, leave highlighting on
  if col < p_start or col > p_end then
    stop_hl()
  end
end

young.augroup('VimrcIncSearchHighlight', {
  {
    event = { 'CursorMoved' },
    command = function()
      hl_search()
    end,
  },
  {
    event = { 'InsertEnter' },
    command = function()
      stop_hl()
    end,
  },
  {
    event = { 'OptionSet' },
    pattern = { 'hlsearch' },
    command = function()
      vim.schedule(function()
        vim.cmd 'redrawstatus'
      end)
    end,
  },
})
