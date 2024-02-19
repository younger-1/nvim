local Hydra = require 'hydra'

local buffer_hydra = Hydra {
  -- name = 'barbar',
  config = {
    hint = {
      type = 'window',
      float_opts = {
        border = 'rounded',
      },
    },
    on_key = function()
      -- Preserve animation
      vim.wait(200, function()
        vim.cmd 'redraw'
      end, 30, false)
    end,
  },
  heads = {
    {
      '[',
      function()
        vim.cmd 'BufferPrevious'
      end,
      { desc = false },
    },
    {
      ']',
      function()
        vim.cmd 'BufferNext'
      end,
      { desc = false },
    },

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
      { desc = 'scroll' },
    },

    {
      '<',
      function()
        vim.cmd 'BufferMovePrevious'
      end,
    },
    {
      '>',
      function()
        vim.cmd 'BufferMoveNext'
      end,
      { desc = 'move' },
    },

    {
      'p',
      function()
        vim.cmd 'BufferPin'
      end,
      { desc = 'pin' },
    },

    {
      'd',
      function()
        vim.cmd 'BufferWipeout'
      end,
    },
    {
      'c',
      function()
        vim.cmd 'BufferClose'
      end,
      { desc = 'close' },
    },
    {
      'r',
      function()
        vim.cmd 'BufferRestore'
      end,
      { desc = 'restore' },
    },

    {
      'ob',
      function()
        vim.cmd 'BufferOrderByBufferNumber'
      end,
    },
    {
      'ow',
      function()
        vim.cmd 'BufferOrderByWindowNumber'
      end,
      { desc = 'by bufferNum/windowNum' },
    },
    {
      'od',
      function()
        vim.cmd 'BufferOrderByDirectory'
      end,
    },
    {
      'ol',
      function()
        vim.cmd 'BufferOrderByLanguage'
      end,
      { desc = 'by directory/language' },
    },

    {
      'f',
      function()
        vim.cmd 'Telescope buffers'
      end,
      { desc = 'find' },
    },

    -- { '<Esc>', nil, { exit = true, desc = false } },
    { 'q', nil, { exit = true, desc = false } },
  },
}

local function choose_buffer()
  -- if #vim.fn.getbufinfo { buflisted = true } > 1 then
  buffer_hydra:activate()
  -- end
end

xy.map.n { 'gb', choose_buffer, '[Hydra] Choose buffer' }
xy.map.n { '<leader>bb', choose_buffer, '[Hydra] Choose buffer' }

return choose_buffer
