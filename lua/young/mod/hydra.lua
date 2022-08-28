local Hydra = require 'hydra'

Hydra {
  name = 'Side scroll',
  mode = 'n',
  body = 'z',
  heads = {
    { 'h', '5zh' },
    { 'l', '5zl', { desc = '←/→' } },
    { 'H', 'zH' },
    { 'L', 'zL', { desc = 'half screen ←/→' } },
  },
}

Hydra {
  name = 'Quick words',
  config = {
    color = 'pink',
    hint = { type = 'statusline' },
  },
  mode = { 'n', 'x', 'o' },
  body = ',',
  heads = {
    { 'w', '<Plug>(smartword-w)' },
    { 'b', '<Plug>(smartword-b)' },
    { 'e', '<Plug>(smartword-e)' },
    { 'ge', '<Plug>(smartword-ge)' },
    { '<Esc>', nil, { exit = true, mode = 'n' } },
  },
}

-- local splits = require 'smart-splits'
local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd

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

local window_hint = [[
 ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
 ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
 ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally
 _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
 ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _q_, _c_: close
 focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
 _b_: choose buffer
]]

Hydra {
  name = 'Windows',
  hint = window_hint,
  config = {
    invoke_on_body = true,
    hint = {
      border = 'rounded',
      offset = -1,
    },
  },
  mode = 'n',
  body = '<C-w>',
  heads = {
    { 'h', '<C-w>h' },
    { 'j', '<C-w>j' },
    { 'k', pcmd('wincmd k', 'E11', 'close') },
    { 'l', '<C-w>l' },

    { 'H', cmd 'WinShift left' },
    { 'J', cmd 'WinShift down' },
    { 'K', cmd 'WinShift up' },
    { 'L', cmd 'WinShift right' },

    {
      '<C-h>',
      function()
        splits.resize_left(2)
      end,
    },
    {
      '<C-j>',
      function()
        splits.resize_down(2)
      end,
    },
    {
      '<C-k>',
      function()
        splits.resize_up(2)
      end,
    },
    {
      '<C-l>',
      function()
        splits.resize_right(2)
      end,
    },
    { '=', '<C-w>=', { desc = 'equalize' } },

    { 's', pcmd('split', 'E36') },
    { '<C-s>', pcmd('split', 'E36'), { desc = false } },
    { 'v', pcmd('vsplit', 'E36') },
    { '<C-v>', pcmd('vsplit', 'E36'), { desc = false } },

    { 'w', '<C-w>w', { exit = true, desc = false } },
    { '<C-w>', '<C-w>w', { exit = true, desc = false } },

    { 'z', cmd 'MaximizerToggle!', { desc = 'maximize' } },
    { '<C-z>', cmd 'MaximizerToggle!', { exit = true, desc = false } },

    { 'o', '<C-w>o', { exit = true, desc = 'remain only' } },
    { '<C-o>', '<C-w>o', { exit = true, desc = false } },

    { 'b', choose_buffer, { exit = true, desc = 'choose buffer' } },

    { 'c', pcmd('close', 'E444') },
    { 'q', pcmd('close', 'E444'), { desc = 'close window' } },
    { '<C-c>', pcmd('close', 'E444'), { desc = false } },
    { '<C-q>', pcmd('close', 'E444'), { desc = false } },

    { '<Esc>', nil, { exit = true, desc = false } },
  },
}


local hint = [[
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  ^
       ^^^^                _<Esc>_
]]

Hydra {
  name = 'Options',
  hint = hint,
  config = {
    color = 'amaranth',
    invoke_on_body = true,
    hint = {
      border = 'rounded',
      position = 'middle',
    },
  },
  mode = { 'n', 'x' },
  body = '<leader>o',
  heads = {
    {
      'n',
      function()
        if vim.o.number == true then
          vim.o.number = false
        else
          vim.o.number = true
        end
      end,
      { desc = 'number' },
    },
    {
      'r',
      function()
        if vim.o.relativenumber == true then
          vim.o.relativenumber = false
        else
          vim.o.number = true
          vim.o.relativenumber = true
        end
      end,
      { desc = 'relativenumber' },
    },
    {
      'v',
      function()
        if vim.o.virtualedit == 'all' then
          vim.o.virtualedit = 'block'
        else
          vim.o.virtualedit = 'all'
        end
      end,
      { desc = 'virtualedit' },
    },
    {
      'i',
      function()
        if vim.o.list == true then
          vim.o.list = false
        else
          vim.o.list = true
        end
      end,
      { desc = 'show invisible' },
    },
    {
      's',
      function()
        if vim.o.spell == true then
          vim.o.spell = false
        else
          vim.o.spell = true
        end
      end,
      { exit = true, desc = 'spell' },
    },
    {
      'w',
      function()
        if vim.o.wrap ~= true then
          vim.o.wrap = true
          -- Dealing with word wrap:
          -- If cursor is inside very long line in the file than wraps
          -- around several rows on the screen, then 'j' key moves you to
          -- the next line in the file, but not to the next row on the
          -- screen under your previous position as in other editors. These
          -- bindings fixes this.
          vim.keymap.set('n', 'k', function()
            return vim.v.count > 0 and 'k' or 'gk'
          end, { expr = true, desc = 'k or gk' })
          vim.keymap.set('n', 'j', function()
            return vim.v.count > 0 and 'j' or 'gj'
          end, { expr = true, desc = 'j or gj' })
        else
          vim.o.wrap = false
          vim.keymap.del('n', 'k')
          vim.keymap.del('n', 'j')
        end
      end,
      { desc = 'wrap' },
    },
    {
      'c',
      function()
        if vim.o.cursorline == true then
          vim.o.cursorline = false
        else
          vim.o.cursorline = true
        end
      end,
      { desc = 'cursor line' },
    },
    { '<Esc>', nil, { exit = true } },
  },
}
