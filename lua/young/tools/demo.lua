-- https://teukka.tech/luanvim.html

-- vim.loop
-- https://github.com/luvit/luv/blob/master/docs.md

local M = {}
local handle, handle_1

function M.makeScratch()
  vim.api.nvim_command 'enew'
  vim.bo[0].buftype = 'nofile' -- set the current buffer's (buffer 0) buftype to nofile
  vim.bo[0].bufhidden = 'hide'
  vim.bo[0].swapfile = false
end

function M.convertFile()
  local shortname = vim.fn.expand '%:t:r'
  local fullname = vim.api.nvim_buf_get_name(0)
  -- loop logic goes here
  handle = vim.loop.spawn('pandoc', {
    args = {
      fullname,
      '--to=html5',
      '-o',
      string.format('%s.html', shortname),
      '-s',
      '--highlight-style',
      'tango',
      '-c',
      '--css=pandoc.css',
    },
  }, function()
    print 'DOCUMENT CONVERSION COMPLETE'
    handle:close()
  end)
end

local results = {}
-- Implement onread callback
local function onread(err, data)
  if err then
    print('ERROR: ', err)
    -- TODO handle err
  end
  if data then
    local vals = vim.split(data, '\n')
    for _, d in pairs(vals) do
      if d == '' then
        goto continue
      end
      table.insert(results, d)
      ::continue::
    end
  end
end
-- Use results to set the quickfix list
local function setQF()
  vim.fn.setqflist({}, 'r', { title = 'Search Results', lines = results })
  vim.api.nvim_command 'cwindow'
  for i = 0, #results do
    results[i] = nil
  end -- clear the table for next search
end

function M.asyncGrep(term)
  local stdout = vim.loop.new_pipe(false) -- create file descriptor for stdout
  local stderr = vim.loop.new_pipe(false) -- create file descriptor for stderr
  handle_1 = vim.loop.spawn(
    'rg',
    {
      args = { term, '--vimgrep', '--smart-case', '--block-buffered' },
      stdio = { nil, stdout, stderr },
    },
    vim.schedule_wrap(function()
      stdout:read_stop()
      stderr:read_stop()
      stdout:close()
      stderr:close()
      handle_1:close()
      setQF()
    end)
  )
  -- Start reading the output into our file descriptors
  -- , which will then call the onread callback
  vim.loop.read_start(stdout, onread)
  vim.loop.read_start(stderr, onread)
end

return M
