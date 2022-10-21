local cmd = require('young.key').cmd

local normal = {
  ['\\'] = {
    c = { cmd 'BufferClose!', 'Close buffer' },
    s = { cmd '.so', 'Source line' },
    d = { cmd 'DiffOrig', 'Show unsaved' },
  },
  [']'] = {
    -- [' '] = {},
    -- ['<Tab>'] = {},
    -- ['<CR>'] = {},
    e = { vim.diagnostic.goto_next, 'Prev diagnostic' },
    E = {
      function()
        vim.diagnostic.goto_next { severity = 'Error' }
      end,
      'Prev diagnostic',
    },
    -- c = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", 'Next hunk' },
    x = { [[<cmd>lua require('trouble').next({skip_groups=true, jump=true})<cr>]], 'Next trouble' },
    -- p = {
    --   function()
    --     require('young.tool').putline ']p'
    --   end,
    --   'Put line below',
    -- },
  },
  ['['] = {
    -- [' '] = {},
    -- ['<Tab>'] = {},
    -- ['<CR>'] = {},
    e = { vim.diagnostic.goto_prev, 'Prev diagnostic' },
    E = {
      function()
        vim.diagnostic.goto_prev { severity = 'Error' }
      end,
      'Prev diagnostic',
    },
    -- c = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", 'Prev hunk' },
    x = { [[<cmd>lua require('trouble').previous({skip_groups=true, jump=true})<cr>]], 'Prev trouble' },
    -- p = {
    --   function()
    --     require('young.tool').putline '[p'
    --   end,
    --   'Put line above',
    -- },
  },
  ['<C-x>'] = { cmd 'TroubleToggle', 'Open' },
  ['<C-w>'] = {
    z = { require('young.tool').toggle_zoom, 'Zoom' },
    w = { require('young.tool').set_cursor_floating_win, 'Goto float' },
    r = { '<cmd>SmartResizeMode<cr>', 'SmartResize mode' },
    -- ['<C-m>'] = { '<Cmd>WinShift<CR>', 'WinShift mode' },
    -- ['<C-x>'] = { '<Cmd>WinShift swap<CR>', 'Swap windows' },
    ['<CR>'] = { '<Cmd>WinShift<CR>', 'WinShift mode' },
    ['\\'] = { '<Cmd>WinShift swap<CR>', 'Swap windows mode' },
    -- [' '] = { "<cmd>FocusToggle<cr>", 'FocusToggle' },
    f = { cmd 'FocusToggle', 'FocusToggle' },
    p = { require('young.mod.window_picker').pick, 'Pick window' },

    -- e = "",
    -- t = "",
    -- b = "",
    -- a = "",
    -- d = "",
  },
  -- ['<tab>'] = {},
  -- ['<C-s>'] = {},
  -- ['<C-y>'] = {},
  -- ['<C-e>'] = {},
  -- ['<C-p>'] = {},
  -- ["<C-n>"] = {},
  -- ["<C-a>"] = {},
  -- ["<C-x>"] = {},
  -- ["<C-f>"] = {},
  -- ["<C-b>"] = {},
  -- ["<C-g>"] = { 'TODO: display buf&&git info' },
  ['<C-_>'] = { '<Cmd>Man<cr>', 'Man' },
  [','] = {
    f = {
      name = '+fzf',
      [' '] = { "<cmd>lua require('fzf-lua').live_grep_resume()<cr>", 'Grep' },
      ['<C-q>'] = { "<cmd>lua require('fzf-lua').quickfix()<cr>", 'Quickfix' },
      ['<C-a>'] = { "<cmd>lua require('fzf-lua').loclist()<cr>", 'Loclist' },
      f = { "<cmd>lua require('fzf-lua').files()<cr>", 'Files' },
      b = { "<cmd>lua require('fzf-lua').buffers()<cr>", 'Buffers' },
      r = { "<cmd>lua require('fzf-lua').files_resume()<cr>", 'Resume' },
      m = { "<cmd>lua require('fzf-lua').oldfiles()<cr>", 'MRU' },
      l = { "<cmd>lua require('fzf-lua').blines()<cr>", 'Lines' },
      L = { "<cmd>lua require('fzf-lua').lines()<cr>", 'Lines' },
      T = { "<cmd>lua require('fzf-lua').tab()<cr>", 'Tab' },
      g = { "<cmd>lua require('fzf-lua').live_grep()<cr>", 'Grep' },
      s = { "<cmd>lua require('fzf-lua').grep()<cr>", 'Grep' },
      o = { "<cmd>lua require('fzf-lua').git_status()<cr>", 'Git status' },
      c = { "<cmd>lua require('fzf-lua').git_commits()<cr>", 'Commits' },
      p = { "<cmd>lua require('fzf-lua').colorschemes()<cr>", 'Colorschemes' },
    },
    s = {
      name = '+seek',
      c = { '<cmd>Telescope cheat fd<cr>', 'Cheatsheet' },
      s = { '<cmd>Telescope fd<cr>', 'Why can not see , ' },
      v = { '<cmd>Cheatsheet<cr>', 'Vim cheatsheet' },
    },
  },
  c = {
    o = {
      name = '+quickcmd',
      r = { '<cmd>ProjectRoot<cr>', 'Project root' },
    },
  },
  g = {
    -- ['<C-l>'] = { '<cmd>nohl<CR><C-l>', 'Clear highlight'},
    ['"'] = {
      [[:<C-U><C-R><C-R>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-F><left>]],
      'Edit or select [R/r]egister',
    },
  },
  y = {
    c = {
      name = '+colorscheme',
      c = { "<cmd>lua require('young.theme').toggle_style()<cr>", 'Style' },
      m = { "<cmd>lua require('material.functions').toggle_style()<cr>", 'Material' },
    },
    o = {
      name = '+options',
      ['-'] = { '<cmd>set cursorline!<cr>', 'line' },
      ['|'] = { '<cmd>set cursorcolumn!<cr>', 'column' },
      ['<Left>'] = { ':call ArrowKeyToggle()<cr>', '🔥' },
      ['<Right>'] = { ':call ArrowKeyToggle()<cr>', '🔥' },
      ['<Tab>'] = { ':call TabToggle()<cr>', '🦊' },
      b = { [[:set background=<C-R>=&background == "dark" ? "light" : "dark"<cr><cr>]], 'background' },
      f = { require('young.tool').toggle_foldcolumn, 'foldcolumn' },
      F = { ':call FoldTextToggle()<cr>', 'Fold text' },
      h = { '<cmd>set hls!<cr>', 'hightlight' },
      l = { '<cmd>set list!<cr>', 'list' },
      m = { [[:set mouse=<C-R>=&mouse == "" ? "a" : ""<cr><cr>]], 'mouse' },
      M = { require('young.tool').toggle_mouse, 'mouse++' },
      n = { '<cmd>set number!<cr>', 'number' },
      r = { '<cmd>set relativenumber!<cr>', 'relativenumber' },
      s = { require('young.tool').toggle_signcolumn, 'signcolumn' },
      S = { '<cmd>set spell!<cr>', 'spell' },
      v = { require('young.tool').visualedit, 'virtualedit' },
      -- v = { [[:set ve=<C-R>=&ve == "" ? "all" : ""<cr><cr>]], 'virtualedit' },
      w = { '<cmd>set wrap!<cr>', 'wrap' },
    },
  },
  -- d = {
  --   ['<space>'] = {
  --     function()
  --       require('nabla').popup { border = 'rounded' }
  --     end,
  --     'ASCII LaTeX equations',
  --   },
  -- },
  z = {
    ['<CR>'] = { '<cmd>TSContextToggle<cr>', 'Toggle context' },
  },
}

normal['<leader>'] = require 'young.key.normal.leader'

return normal
