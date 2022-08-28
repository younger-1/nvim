local Hydra = require 'hydra'

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
        vim.cmd 'BufferMovePrevious'
      end,
    },
    {
      'L',
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
        vim.cmd 'BufferClose'
      end,
      { desc = 'close' },
    },
    {
      'c',
      function()
        vim.cmd 'BufferClose'
      end,
      { desc = false },
    },
    {
      'q',
      function()
        vim.cmd 'BufferClose'
      end,
      { desc = false },
    },

    {
      'od',
      function()
        vim.cmd 'BufferOrderByDirectory'
      end,
      { desc = 'by directory' },
    },
    {
      'ol',
      function()
        vim.cmd 'BufferOrderByLanguage'
      end,
      { desc = 'by language' },
    },
    { '<Esc>', nil, { exit = true } },
  },
}

local function choose_buffer()
  if #vim.fn.getbufinfo { buflisted = true } > 1 then
    buffer_hydra:activate()
  end
end

vim.keymap.set('n', 'gb', choose_buffer)

return choose_buffer
