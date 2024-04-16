return {
  ['<leader>'] = require 'young.key.normal.leader',

  -- ['<C-c>'] = function()
  --   vim.cmd 'nohl'
  --   vim.fn.feedkeys(xy.util.t '<C-c>', 'n')
  -- end,

  ['\\'] = {
    -- c = { function() vim.cmd 'BufferClose!' end, 'Close buffer' },
    w = {
      function()
        vim.cmd 'w'
      end,
      'Write',
    },
    s = {
      function()
        vim.cmd '.so'
      end,
      'Source line',
    },
    d = {
      function()
        vim.cmd 'DiffOrig'
      end,
      'Show unsaved',
    },
    m = {
      function()
        vim.cmd 'echo mode()'
      end,
      'Show mode',
    },
    z = {
      function()
        vim.cmd 'stop'
      end,
      'Stop(C-z)',
    },
  },
  [']'] = {
    -- [' '] = {},
    -- ['<Tab>'] = {},
    -- ['<CR>'] = {},
    -- c = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", 'Next hunk' },
    -- x = { [[<cmd>lua require('trouble').next({skip_groups=true, jump=true})<cr>]], 'Next trouble' },
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
    -- c = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", 'Prev hunk' },
    -- x = { [[<cmd>lua require('trouble').previous({skip_groups=true, jump=true})<cr>]], 'Prev trouble' },
    -- p = {
    --   function()
    --     require('young.tool').putline '[p'
    --   end,
    --   'Put line above',
    -- },
  },
  -- ['<tab>'] = {},
  -- ['<C-s>'] = {},
  -- ['<C-y>'] = {},
  -- ['<C-e>'] = {},
  -- ['<C-p>'] = {},
  -- ["<C-n>"] = {},
  -- ["<C-a>"] = {},
  -- ["<C-f>"] = {},
  -- ["<C-b>"] = {},
  -- TODO: display buf&&git info
  ['<C-g>'] = {
    function()
      require('young.tool.file_info').setup()
    end,
    'Info',
  },
  ['<C-_>'] = {
    function()
      vim.cmd 'tab Man'
    end,
    'Man',
  },
  ['<C-w>'] = {
    -- w = {
    --   function()
    --     require('young.tool').set_cursor_floating_win()
    --   end,
    --   'Goto float',
    -- },
    O = {
      function()
        require('young.tool').close_all_floating_win()
      end,
      'Close all float',
    },
    -- ['<C-m>']
    -- ['<C-x>']
    -- ['<CR>']
    -- ['\\']
    -- [' ']

    -- e = "",
    -- t = "",
    -- b = "",
    -- a = "",
    -- d = "",
  },
  [','] = {
    s = {
      name = '+seek',
      c = {
        function()
          vim.cmd 'Telescope cheat fd'
        end,
        'Cheatsheet',
      },
      v = {
        function()
          vim.cmd 'Cheatsheet'
        end,
        'Vim cheatsheet',
      },
    },
  },
  c = {
    d = {
      name = '+cmd',
      o = {
        function()
          xy.tool.buf_git_root 'tcd'
        end,
        'Buf git root (tab)',
      },
      O = {
        function()
          xy.tool.buf_git_root 'cd'
        end,
        'Buf git root',
      },
    },
  },
  g = {
    -- ['<C-l>'] = { '<cmd>nohl<CR><C-l>', 'Clear highlight'},
    ['"'] = {
      [[:<C-U><C-R><C-R>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-F><left>]],
      'Edit or select [R/r]egister',
    },
    p = {
      -- "p" makes sense, gv selects the last Visual selection, so this one selects the last pasted text.
      function()
        vim.api.nvim_feedkeys('`[' .. vim.fn.strpart(vim.fn.getregtype(), 0, 1) .. '`]', 'n', false)
      end,
      'Switch to VISUAL using last paste/change',
    },
  },
  y = {
    c = {
      name = '+colorscheme',
      c = {
        function()
          require('young.theme').toggle_style()
        end,
        'Style',
      },
      m = {
        function()
          require('material.functions').toggle_style()
        end,
        'Material',
      },
    },
    o = {
      name = '+options',
      ['-'] = 'line',
      ['|'] = 'column',
      n = 'number',
      r = 'relative number',
      l = 'list',
      s = 'spell',
      w = 'wrap',
      b = 'background',
      m = 'mouse',
      h = 'hls',
      d = 'diff',

      f = {
        function()
          require('young.tool').toggle_foldcolumn()
        end,
        'foldcolumn',
      },
      M = {
        function()
          require('young.tool').toggle_mouse()
        end,
        'mouse++',
      },
      S = {
        function()
          require('young.tool').toggle_signcolumn()
        end,
        'signcolumn',
      },
      v = {
        function()
          require('young.tool').visualedit()
        end,
        'virtualedit',
      },
      -- v = { [[:set ve=<C-R>=&ve == "" ? "all" : ""<cr><cr>]], 'virtualedit' },
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
    ['<CR>'] = {
      function()
        vim.cmd 'TSContextToggle'
      end,
      'Toggle context',
    },
    [' '] = {
      function()
        require('young.tool').blink_cursor()
      end,
      'Blink cursor',
    },
  },
}
