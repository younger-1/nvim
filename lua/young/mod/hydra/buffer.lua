local Hydra = require 'hydra'
local cmd = require('young.key').cmd

local buffer_hydra = Hydra {
  name = 'Barbar',
  config = {
    on_key = function()
      -- Preserve animation
      vim.wait(200, function()
        vim.cmd 'redraw'
      end, 30, false)
    end,
  },
  heads = {
    {
      'h',
      function()
        vim.cmd 'BufferPrevious'
      end,
      { on_key = false },
    },
    {
      'l',
      function()
        vim.cmd 'BufferNext'
      end,
      { desc = 'choose', on_key = false },
    },

    {
      'H',
      function()
        vim.cmd 'BufferScrollLeft 20'
      end,
    },
    {
      'L',
      function()
        vim.cmd 'BufferScrollRight 20'
      end,
      { desc = 'move' },
    },

    {
      '<',
      function()
        vim.cmd 'BufferMovePrevious'
      end,
    },
    {
      '<',
      function()
        vim.cmd 'BufferMoveNext'
      end,
      { desc = 'move' },
    },

    {
      'p',
      cmd 'BufferPin',
      { desc = 'pin' },
    },

    {
      'd',
      cmd 'BufferWipeout',
    },
    {
      'c',
      cmd 'BufferClose',
      { desc = 'close' },
    },

    {
      'ob',
      cmd 'BufferOrderByBufferNumber',
    },
    {
      'ow',
      cmd 'BufferOrderByWindowNumber',
      { desc = 'by bufferNum/windowNum' },
    },
    {
      'od',
      cmd 'BufferOrderByDirectory',
    },
    {
      'ol',
      cmd 'BufferOrderByLanguage',
      { desc = 'by directory/language' },
    },
    { '<Esc>', nil, { exit = true } },
  },
}

local function choose_buffer()
  if #vim.fn.getbufinfo { buflisted = true } > 1 then
    buffer_hydra:activate()
  end
end

xy.map.n { 'gb', choose_buffer, '[Hydra] Choose buffer' }

return choose_buffer
