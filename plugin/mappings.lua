local M = {}

local mode_adapters = {
  insert_command_mode = '!',
  insert_mode = 'i',
  command_mode = 'c',
  map_mode = '',
  normal_mode = 'n',
  visual_mode = 'x',
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
    -- ['jk'] = '<ESC>',
    -- 'jj' for quitting insert mode
    -- ['jj'] = '<ESC>',

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
    -- navigate tab completion with <c-j> and <c-k> runs conditionally
    -- cnoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
    -- cnoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
    ['<C-j>'] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', expr = true },
    ['<C-k>'] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', expr = true },

    -- search older command-line from history
    ['<A-n>'] = { 'pumvisible() ? "\\<C-n>" : "\\<Down>"', expr = true },
    ['<A-p>'] = { 'pumvisible() ? "\\<C-p>" : "\\<Up>"', expr = true },
    -- recall older command-line from history
    -- ['<A-n>'] = '<S-Down>',
    -- ['<A-p>'] = '<S-Up>',
    --
    ['<C-V>'] = '<C-R>+',
    --
    -- ['('] = '()<Left>',
    -- ['['] = '[]<Left>',
    -- ['{'] = '{}<Left>',
  },

  map_mode = {
    -- Remap for dealing with word wrap
    j = { "v:count == 0 ? 'gj' : 'j'", expr = true },
    k = { "v:count == 0 ? 'gk' : 'k'", expr = true },

    -- gj = { '' },
    -- gk = { '' },

    -- gJ = { 'L' },
    -- gK = { 'H' },

    gH = { 'H' },
    gL = { 'L' },

    -- ['<Up>'] = '<C-Y>',
    -- ['<Down>'] = '<C-E>',
    -- ['<Left>'] = '2zh',
    -- ['<Right>'] = '2zl',

    -- @see https://github.com/neovim/neovim/issues/14090#issuecomment-1113090354
    -- Windows Terminal: https://github.com/microsoft/terminal/issues/13792
    -- ['<Tab>'] = { '%', { noremap = false } },
    -- ['<C-I>'] = { '<C-I>', { noremap = false } },

    -- <https://github.com/yuki-yano/zero.nvim>
    -- ['0'] = { "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", { expr = true } },
    ['0'] = ':call FirstCharOrFirstCol()<cr>', -- FIXME:not work in visual_mode

    ['+'] = '<C-a>',
    ['-'] = '<C-x>',
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
    ['<C-q>'] = ':call QuickFixToggle()<CR>',
    [']q'] = ':cnext<CR>',
    ['[q'] = ':cprev<CR>',
    [']Q'] = ':clast<CR>',
    ['[Q'] = ':cfirst<CR>',

    ['<C-a>'] = ':call LocListToggle()<CR>',
    [']a'] = ':lnext<CR>',
    ['[a'] = ':lprev<CR>',
    [']A'] = ':llast<CR>',
    ['[A'] = ':lfirst<CR>',

    [']t'] = ':tnext<CR>',
    ['[t'] = ':tprev<CR>',
    [']T'] = ':tlast<CR>',
    ['[T'] = ':tfirst<CR>',

    -- [nvim-default]
    -- Y = 'y$',
    Q = '@q', -- qq to record, Q to replay
    -- n = 'nzz',
    -- N = 'Nzz',
    ZA = '<cmd>wqa<CR>',

    ['<BS>'] = '<C-^>',
    ['<ESC>'] = '<cmd>nohl<CR>',
    ['<C-c>'] = function()
      vim.cmd 'nohl'
      vim.fn.feedkeys(xy.util.t '<C-c>', 'n')
    end,
    -- ['<S-CR>'] = '<cmd>wqa<CR>', -- windows terminal not recognize
    -- ['<CR>'] = { "(&buftype is# '' ? ':w<CR>' : '<CR>')", { expr = true } },

    --
    -- B = '^',
    -- E = '$',
    -- gH = 'H',
    -- gL = 'L',
    -- ['/'] = { '/\\v', silent = false },

    -- ['<C-o>'] = '<C-o>zz',
    -- ['<C-i>'] = '<C-i>zz',
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
    L = 'g_',

    -- /\%>'<\%<'>
    -- /\%>2c\%<7c
    -- /\%>2l\%<7l
    -- /\%>2l\%>4c\%<5l\%<7c
    ['/'] = { '<ESC>/\\%V', silent = false },
    ['?'] = { '<ESC>?\\%V', silent = false },

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
    L = 'g_',
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

M.done = function()
  for mode_name, mappings in pairs(M.keys) do
    local mode = mode_adapters[mode_name]
    for k, v in pairs(mappings) do
      if type(v) ~= 'table' then
        v = { v }
      end
      table.insert(v, 1, k)
      xy.map[mode](v)
    end
  end
end

M.done()
