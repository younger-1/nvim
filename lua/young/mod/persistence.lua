local keys = {
  c = {
    function()
      require('persistence').load()
    end,
    'Current session', -- restore the session for the current directory
  },
  l = {
    function()
      require('persistence').load { last = true }
    end,
    'Last session', -- restore the last session
  },
  s = {
    function()
      require('persistence').stop()
    end,
    'Stop session', -- stop Persistence => session won't be saved on exit
  },
}

return {
  keys = keys,
  once = function()
    xy.map.register {
      ['<leader>ps'] = keys,
    }
  end,
  done = function()
    require('persistence').setup {
      dir = vim.fn.expand(vim.fn.stdpath 'data' .. '/persistence/'), -- directory where session files are saved
      options = { 'buffers', 'curdir', 'tabpages', 'winsize' }, -- sessionoptions used for saving
      pre_save = nil, -- a function to call before saving the session
      save_empty = false, -- don't save if there are no open file buffers
    }
  end,
}
