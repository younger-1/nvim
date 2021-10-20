-- [[What i have done]]
-- this plugin is designed to show the files from git commits.
-- https://dev.to/2nit/how-to-write-neovim-plugins-in-lua-5cca

local api = vim.api
local buf, win
local position = 0

local function center(str)
  local width = api.nvim_win_get_width(0)
  local shift = math.floor(width / 2) - math.floor(string.len(str) / 2)
  return string.rep(' ', shift) .. str
end

local function open_window()
  -- Created as not listed buffer (first argument) and "scratch-buffer" (second argument)
  buf = api.nvim_create_buf(false, true) -- create new emtpy buffer
  -- Set it to be deleted when hidden
  api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  api.nvim_buf_set_option(buf, 'filetype', 'whid')
  -- Get dimensions
  local width = api.nvim_get_option 'columns'
  local height = api.nvim_get_option 'lines'
  -- Calculate our floating window size
  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)
  -- and its starting position
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)
  -- Set some options
  local opts = {
    style = 'minimal',
    relative = 'editor',
    width = win_width,
    height = win_height,
    row = row,
    col = col,
  }

  -- Neovim currently doesn't support widgets like border, so we should create one by ourselves
  local border_buf = api.nvim_create_buf(false, true)
  local border_opts = {
    style = 'minimal',
    relative = 'editor',
    width = win_width + 2,
    height = win_height + 2,
    row = row - 1,
    col = col - 1,
  }
  -- We will fill border with "box-drawing" characters.
  local border_lines = { '╔' .. string.rep('═', win_width) .. '╗' }
  local middle_line = '║' .. string.rep(' ', win_width) .. '║'
  for i = 1, win_height do
    table.insert(border_lines, middle_line)
  end
  table.insert(border_lines, '╚' .. string.rep('═', win_width) .. '╝')
  -- Set border_buf's lines from first line (0) to last (-1)
  -- ignoring out-of-bounds error (false) with lines (border_lines)
  api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

  -- Create new window with previously created buffer attached to it.
  local border_win = api.nvim_open_win(border_buf, true, border_opts)
  win = api.nvim_open_win(buf, true, opts)
  -- It highlight line with the cursor on it
  api.nvim_win_set_option(win, 'cursorline', true)

  -- Close buf and border_buf together
  api.nvim_command('au BufWipeout <buffer> exe "silent bwipeout! "' .. border_buf)
end

local function update_view(direction)
  -- Is nice to prevent user from editing interface, so
  -- we should enabled it before updating view and disabled after it.
  api.nvim_buf_set_option(buf, 'modifiable', true)

  position = position + direction
  if position < 0 then
    position = 0
  end
  -- We will use vim systemlist function which run shell command and return result as list
  local result = vim.fn.systemlist('git diff-tree --no-commit-id --name-only -r HEAD~' .. position)
  -- Add  an empty line to preserve layout if there is no results
  if #result == 0 then
    table.insert(result, '')
  end
  -- With small indentation results will look better
  for k, _ in pairs(result) do
    result[k] = '  ' .. result[k]
  end
  -- Add centered title and subtitle
  api.nvim_buf_set_lines(buf, 0, 3, false, {
    center 'What have i done?',
    center('HEAD~' .. position),
    '',
  })
  -- Add result to buf
  api.nvim_buf_set_lines(buf, 3, -1, false, result)

  -- We add highlights to buf as ungrouped highlight (second argument -1).
  api.nvim_buf_add_highlight(buf, -1, 'WhidHeader', 0, 0, -1)
  api.nvim_buf_add_highlight(buf, -1, 'WhidSubHeader', 1, 0, -1)

  api.nvim_buf_set_option(buf, 'modifiable', false)
end

local function close_window()
  api.nvim_win_close(win, true)
end

-- Our file list start at line 4, so we can prevent reaching above it
-- from bottm the end of the buffer will limit movment
local function move_up()
  local new_pos = math.max(4, api.nvim_win_get_cursor(win)[1] - 1)
  api.nvim_win_set_cursor(win, { new_pos, 0 })
end

-- Open file under cursor
-- We can get line number (or even column) and then, based on it, trigger specific action.
-- It will allow to separate view form logic. But for our purposes it is enough.
local function open_file()
  local str = api.nvim_get_current_line()
  close_window()
  api.nvim_command('edit ' .. str)
end

-- User input
-- Pressing a key will trigger certain action, which is local to buf
local function set_mappings()
  local mappings = {
    ['['] = 'update_view(-1)',
    [']'] = 'update_view(1)',
    ['<cr>'] = 'open_file()',
    h = 'update_view(-1)',
    l = 'update_view(1)',
    q = 'close_window()',
    k = 'move_up()',
  }

  for k, v in pairs(mappings) do
    api.nvim_buf_set_keymap(buf, 'n', k, ':lua require"whid".' .. v .. '<cr>', {
      nowait = true,
      noremap = true,
      silent = true,
    })
  end

  -- We can also disable not used keys (or not, whichever you like).
  local other_chars = {
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'i',
    'n',
    'o',
    'p',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
  }
  for _, v in ipairs(other_chars) do
    api.nvim_buf_set_keymap(buf, 'n', v, '', { nowait = true, noremap = true, silent = true })
    api.nvim_buf_set_keymap(buf, 'n', v:upper(), '', { nowait = true, noremap = true, silent = true })
    api.nvim_buf_set_keymap(buf, 'n', '<c-' .. v .. '>', '', { nowait = true, noremap = true, silent = true })
  end
end

-- main function
local function main()
  position = 0 -- if you want to preserve last displayed state just omit this line
  open_window()
  set_mappings()
  update_view(0)
  api.nvim_win_set_cursor(win, { 4, 0 }) -- set cursor on first list entry
end

return {
  whid = main,
  update_view = update_view,
  open_file = open_file,
  move_up = move_up,
  close_window = close_window,
}
