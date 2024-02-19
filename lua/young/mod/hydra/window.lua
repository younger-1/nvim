local Hydra = require 'hydra'

local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd

local window_hint = [[
 ^^^^^^     Move    ^^^^^^  ^^    Size   ^^   ^^     Split
 ^^^^^^-------------^^^^^^  ^^-----------^^   ^^---------------
 ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally
 _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
 ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _c_: close
 ^^^focus^^^  ^^^window^^^  ^_=_: equalize^   _z_: maximize
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
 _b_: choose buffer
]]

Hydra {
  name = 'Windows',
  hint = window_hint,
  config = {
    invoke_on_body = true,
    hint = {
      float_opts = {
        border = 'double',
      },
      offset = -1,
    },
  },
  mode = 'n',
  body = '<C-w> ',
  heads = {
    { 'h', '<C-w>h' },
    { 'j', '<C-w>j' },
    { 'k', pcmd('wincmd k', 'E11', 'close') },
    { 'l', '<C-w>l' },

    {
      'H',
      function()
        vim.cmd 'WinShift left'
      end,
    },
    {
      'J',
      function()
        vim.cmd 'WinShift down'
      end,
    },
    {
      'K',
      function()
        vim.cmd 'WinShift up'
      end,
    },
    {
      'L',
      function()
        vim.cmd 'WinShift right'
      end,
    },

    {
      '<C-h>',
      function()
        require('smart-splits').resize_left(2)
      end,
    },
    {
      '<C-j>',
      function()
        require('smart-splits').resize_down(2)
      end,
    },
    {
      '<C-k>',
      function()
        require('smart-splits').resize_up(2)
      end,
    },
    {
      '<C-l>',
      function()
        require('smart-splits').resize_right(2)
      end,
    },
    { '=', '<C-w>=', { desc = 'equalize' } },

    { 's', pcmd('split', 'E36') },
    { '<C-s>', pcmd('split', 'E36'), { desc = false } },
    { 'v', pcmd('vsplit', 'E36') },
    { '<C-v>', pcmd('vsplit', 'E36'), { desc = false } },

    { 'w', '<C-w>w', { exit = true, desc = false } },
    { '<C-w>', '<C-w>w', { exit = true, desc = false } },

    { 'z', '<C-w>z', { desc = 'maximize', remap = true } },
    { '<C-z>', 'C-w>z', { exit = true, desc = false, remap = true } },
    -- { 'z', function() vim.cmd 'MaximizerToggle!' end, { desc = 'maximize' } },
    -- { '<C-z>', function() vim.cmd 'MaximizerToggle!' end, { exit = true, desc = false } },
    -- { 'z', '<Plug>(zoom-toggle)', { desc = 'maximize' } },
    -- { '<C-z>', '<Plug>(zoom-toggle)', { exit = true, desc = false } },

    { 'o', '<C-w>o', { exit = true, desc = 'remain only' } },
    { '<C-o>', '<C-w>o', { exit = true, desc = false } },

    { 'b', require 'young.mod.hydra.buffer', { exit = true, desc = 'choose buffer' } },

    { 'c', pcmd('close', 'E444'), { desc = 'close window' } },
    { '<C-c>', pcmd('close', 'E444'), { desc = false } },
    { '<C-q>', pcmd('close', 'E444'), { desc = false } },

    -- { '<Esc>', nil, { exit = true, desc = false } },
    { 'q', nil, { exit = true, desc = false } },
  },
}
