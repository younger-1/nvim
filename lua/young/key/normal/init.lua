local normal = {
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
  -- ["<C-x>"] = {},
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
  -- ['<C-x>'] = { function() vim.cmd 'TroubleToggle' end, 'Open' },
  ['<C-w>'] = {
    z = {
      function()
        require('young.tool').toggle_zoom()
      end,
      'Zoom',
    },
    w = {
      function()
        require('young.tool').set_cursor_floating_win()
      end,
      'Goto float',
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
    f = {
      name = '+fzf',
      [' '] = {
        function()
          require('fzf-lua').live_grep_resume()
        end,
        'Grep',
      },
      ['<C-q>'] = {
        function()
          require('fzf-lua').quickfix()
        end,
        'Quickfix',
      },
      ['<C-a>'] = {
        function()
          require('fzf-lua').loclist()
        end,
        'Loclist',
      },
      f = {
        function()
          require('fzf-lua').files()
        end,
        'Files',
      },
      b = {
        function()
          require('fzf-lua').buffers()
        end,
        'Buffers',
      },
      r = {
        function()
          require('fzf-lua').files_resume()
        end,
        'Resume',
      },
      m = {
        function()
          require('fzf-lua').oldfiles()
        end,
        'MRU',
      },
      l = {
        function()
          require('fzf-lua').blines()
        end,
        'Lines',
      },
      L = {
        function()
          require('fzf-lua').lines()
        end,
        'Lines',
      },
      T = {
        function()
          require('fzf-lua').tab()
        end,
        'Tab',
      },
      g = {
        function()
          require('fzf-lua').live_grep()
        end,
        'Grep',
      },
      s = {
        function()
          require('fzf-lua').grep()
        end,
        'Grep',
      },
      o = {
        function()
          require('fzf-lua').git_status()
        end,
        'Git status',
      },
      c = {
        function()
          require('fzf-lua').git_commits()
        end,
        'Commits',
      },
      p = {
        function()
          require('fzf-lua').colorschemes()
        end,
        'Colorschemes',
      },
    },
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

      ['<Left>'] = { ':call ArrowKeyToggle()<cr>', '👈' },
      ['<Right>'] = { ':call ArrowKeyToggle()<cr>', '👉' },
      ['<Tab>'] = { ':call TabToggle()<cr>', '🦊' },
      f = {
        function()
          require('young.tool').toggle_foldcolumn()
        end,
        'foldcolumn',
      },
      F = { ':call FoldTextToggle()<cr>', 'Fold text' },
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

normal['<leader>'] = require 'young.key.normal.leader'

return normal
