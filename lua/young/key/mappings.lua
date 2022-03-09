local M = {}
-- local Log = require 'lvim.core.log'

local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
  insert_command_mode = { noremap = true },
  insert_mode = generic_opts_any,
  command_mode = { noremap = true },
  map_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  operator_mode = generic_opts_any,
  term_mode = { nowait = true },
}

local mode_adapters = {
  insert_command_mode = '!',
  insert_mode = 'i',
  command_mode = 'c',
  map_mode = '',
  normal_mode = 'n',
  visual_mode = 'v',
  visual_block_mode = 'x',
  operator_mode = 'o',
  term_mode = 't',
}

M.keys = {
  insert_command_mode = {
    ['<C-a>'] = '<Home>',
    ['<C-e>'] = '<End>',
    --
    ['<A-f>'] = '<S-Right>',
    ['<A-b>'] = '<S-Left>',
    -- ["<C-b>"] = "<Left>",
    -- ["<C-f>"] = "<Right>",
  },

  -- ---@usage change or add keymappings for insert mode
  insert_mode = {
    -- 'jk' for quitting insert mode
    ['jk'] = '<ESC>',
    -- 'jj' for quitting insert mode
    ['jj'] = '<ESC>',

    ['<C-d>'] = '<Del>',

    -- Move current line / block with Alt-j/k ala vscode.
    ['<A-k>'] = '<C-o>:m .-2<CR>',
    ['<A-j>'] = '<C-o>:m .+1<CR>',

    -- Navigation
    -- ['<A-Up>'] = '<C-\\><C-N><C-w>k',
    -- ['<A-Down>'] = '<C-\\><C-N><C-w>j',
    -- ['<A-Left>'] = '<C-\\><C-N><C-w>h',
    -- ['<A-Right>'] = '<C-\\><C-N><C-w>l',

    -- [nvim-default] Break undo sequence, start new change
    -- ['<C-U>'] = '<C-G>u<C-U>',
    -- ['<C-W>'] = '<C-G>u<C-W>',

    ['<C-v>'] = '<C-G>u<C-R><C-O>+',
  },

  ---@usage change or add keymappings for command mode
  command_mode = {
    -- navigate tab completion with <c-j> and <c-k>
    -- runs conditionally
    ['<C-j>'] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true } },
    ['<C-k>'] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true } },

    ['<C-n>'] = { 'pumvisible() ? "\\<Down>" : "\\<C-n>"', { expr = true } },
    ['<C-p>'] = { 'pumvisible() ? "\\<Up>" : "\\<C-p>"', { expr = true } },
    --
    ['<A-n>'] = '<Down>',
    ['<A-p>'] = '<Up>',
    --
    ['<C-V>'] = '<C-R>+',
    --
    -- ['('] = '()<Left>',
    -- ['['] = '[]<Left>',
    -- ['{'] = '{}<Left>',
  },

  map_mode = {
    -- Remap for dealing with word wrap
    k = { "v:count == 0 ? 'gk' : 'k'", { expr = true } },
    j = { "v:count == 0 ? 'gj' : 'j'", { expr = true } },

    -- ['<Up>'] = '<C-Y>',
    -- ['<Down>'] = '<C-E>',
    -- ['<Left>'] = '2zh',
    -- ['<Right>'] = '2zl',

    -- ['<Tab>'] = { '%', { noremap = false } },

    -- <https://github.com/yuki-yano/zero.nvim>
    -- ['0'] = { "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", { expr = true } },
    ['0'] = ':call FirstCharOrFirstCol()<cr>',
  },

  ---@usage change or add keymappings for normal mode
  normal_mode = {
    -- Better window movement
    ['<C-h>'] = '<C-w>h',
    ['<C-j>'] = '<C-w>j',
    ['<C-k>'] = '<C-w>k',
    ['<C-l>'] = '<C-w>l',

    -- Resize with arrows
    ['<C-Up>'] = ':resize -5<CR>',
    ['<C-Down>'] = ':resize +5<CR>',
    ['<C-Left>'] = ':vertical resize -8<CR>',
    ['<C-Right>'] = ':vertical resize +8<CR>',

    ['<S-Up>'] = ':resize -1<CR>',
    ['<S-Down>'] = ':resize +1<CR>',
    ['<S-Left>'] = ':vertical resize -1<CR>',
    ['<S-Right>'] = ':vertical resize +1<CR>',

    -- Vertical/Horizontal Scrolling
    ['<A-h>'] = 'zh',
    ['<A-l>'] = 'zl',
    ['<A-j>'] = '<C-e>',
    ['<A-k>'] = '<C-y>',

    -- Move current line / block with Alt-j/k a la vscode.
    -- ['<A-j>'] = ':m .+1<CR>==',
    -- ['<A-k>'] = ':m .-2<CR>==',

    -- QuickFix
    [']q'] = ':cnext<CR>',
    ['[q'] = ':cprev<CR>',
    ['<C-q>'] = ':call QuickFixToggle()<CR>',

    [']e'] = ':lnext<CR>',
    ['[e'] = ':lprev<CR>',
    ['<C-e>'] = ':call LocListToggle()<CR>',

    -- [nvim-default]
    -- Y = 'y$',
    Q = '@q', -- qq to record, Q to replay
    -- n = 'nzz',
    -- N = 'Nzz',
    ZA = '<cmd>wqa<CR>',

    ['<BS>'] = '<C-^>',
    ['<ESC>'] = '<cmd>nohl<CR>',
    -- ['<S-CR>'] = '<cmd>wqa<CR>', -- windows terminal not recognize
    -- ['<CR>'] = { "(&buftype is# '' ? ':w<CR>' : '<CR>')", { expr = true } },
  },

  ---@usage change or add keymappings for visual mode
  visual_mode = {
    -- Better indenting
    ['<'] = '<gv',
    ['>'] = '>gv',

    d = [["_d]], -- Use `x` to cut
    X = [["+x]], -- Use `X` for system-cut
    Y = [["+y]], -- Use `Y` for system-copy

    -- Select to start and end quickly
    H = '^',
    L = '$',
  },

  ---@usage change or add keymappings for visual block mode
  visual_block_mode = {
    -- Move selected line / block of text in visual mode
    ['K'] = ":move '<-2<CR>gv-gv",
    ['J'] = ":move '>+1<CR>gv-gv",

    -- Move current line / block with Alt-j/k ala vscode.
    -- ['<A-j>'] = ":m '>+1<CR>gv-gv",
    -- ['<A-k>'] = ":m '<-2<CR>gv-gv",
  },

  operator_mode = {
    -- Operate to start and end quickly
    H = '^',
    L = '$',
  },

  ---@usage change or add keymappings for terminal mode
  term_mode = {
    -- Terminal window navigation
    ['<C-h>'] = '<C-\\><C-N><C-w>h',
    ['<C-j>'] = '<C-\\><C-N><C-w>j',
    ['<C-k>'] = '<C-\\><C-N><C-w>k',
    ['<C-l>'] = '<C-\\><C-N><C-w>l',

    -- quitting insert mode
    ['<Esc><Esc>'] = '<C-\\><C-N>',
    -- ['<C-o>'] = '<C-\\><C-N>',
    JJ = '<C-\\><C-N>',
  },
}

-- Append key mappings to lunarvim's defaults for a given mode
-- @param keymaps The table of key mappings containing a list per mode (normal_mode, insert_mode, ..)
-- function M.append_to_defaults(keymaps)
--   for mode, mappings in pairs(keymaps) do
--     for k, v in pairs(mappings) do
--       M.keys[mode][k] = v
--     end
--   end
-- end

-- Set key mappings individually
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param key The key of keymap
-- @param val Can be form as a mapping or tuple of mapping and user defined opt
function M.set_keymap(mode, key, val)
  local opt = generic_opts[mode] or generic_opts_any
  mode = mode_adapters[mode] or mode
  if type(val) == 'table' then
    -- opt = val[2]
    opt = vim.tbl_extend('keep', val[2], opt)
    val = val[1]
  end
  vim.api.nvim_set_keymap(mode, key, val, opt)
end

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
local load_mode = function(mode, keymaps)
  for k, v in pairs(keymaps) do
    M.set_keymap(mode, k, v)
  end
end

-- Load key mappings for all provided modes
-- @param keymaps A list of key mappings for each mode
function M.load(keymaps)
  keymaps = keymaps or M.keys
  for mode, mappings in pairs(keymaps) do
    load_mode(mode, mappings)
  end
end

function M.ice()
  local keys = M.keys
  if vim.fn.has 'mac' == 1 then
    keys.normal_mode['<A-Up>'] = keys.normal_mode['<C-Up>']
    keys.normal_mode['<A-Down>'] = keys.normal_mode['<C-Down>']
    keys.normal_mode['<A-Left>'] = keys.normal_mode['<C-Left>']
    keys.normal_mode['<A-Right>'] = keys.normal_mode['<C-Right>']
    -- Log:debug 'Activated mac keymappings'
  end
end

function M.print(mode)
  print "Younger's default keymappings (not including which-key)"
  if mode then
    print(vim.inspect(M.keys[mode]))
  else
    print(vim.inspect(M.keys))
  end
end

M.done = function()
  M.ice()
  M.load(M.keys)
end

return M
