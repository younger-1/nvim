-- TODO:add function instead of <cmd><cr>
return {
  -- [' '] = { ':', 'which_key_ignore', mode = { 'n', 'x' } },
  ['`'] = { '<cmd>intro<cr>', 'Intro' },
  -- ['~'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['0'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['-'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['='] = { '<cmd>Alpha<cr>', 'Alpha' },
  ['<BS>'] = { '<cmd>Alpha<cr>', 'Dashboard' },
  -- ['<Tab>'] = { '<cmd>CellularAutomaton make_it_rain<cr>', 'Rain' },
  ['<CR>'] = { '<cmd>message<cr>', 'which_key_ignore' },
  -- ['['] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- [']'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['{'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['}'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['<'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['>'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['\'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['|'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- [';'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- [':'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['"'] = { '<cmd>Alpha<cr>', 'Alpha' },
  [','] = {
    function()
      vim.cmd 'Telescope buffers'
    end,
    'Buffers',
  },
  ['.'] = {
    function()
      vim.cmd 'Telescope find_files layout_strategy=horizontal'
    end,
    'Files',
  },
  -- ['/'] = {
  --   function()
  --     vim.cmd 'Telescope current_buffer_fuzzy_find'
  --   end,
  --   'Buffer string',
  -- },
  ['?'] = {
    group = '+help',
  },
  a = {
    group = '+apps',
    u = {
      function()
        xy.tool.open_github_url()
      end,
      'Open github url',
    },
    v = {
      function()
        vim.cmd 'OpenInVSCode'
      end,
      'Open in vscode',
    },
  },
  -- b = {
  --   A = { function() vim.cmd 'TablineToggleShowAllBuffers' end, 'Tabline toggle all' },
  --   U = { function() vim.cmd 'TablineBuffersClearBind' end, 'Tabline unbound' },
  --   B = { ':TablineBuffersBind ', 'Tabline bound' },
  --   R = { ':TablineTabRename ', 'Tabline rename' },
  --   N = { ':TablineTabNew ', 'Tabline new' },
  --   T = { ':TablineCustom ', 'Tabline++' },
  -- },
  c = {
    group = '+code',
  },
  e = {
    group = '+explorer',
  },
  h = {
    group = '+hunk',
  },
  g = {
    group = '+git',
  },
  j = {
    group = '+jump',
  },
  k = {
    group = '+kit',
  },
  l = {
    group = '+lsp',
  },
  L = {
    group = '+lua',
    -- impatient.nvim
    -- c = { '<cmd>LuaCacheClear<cr>', 'LuaCache clear' },
    -- l = { '<cmd>LuaCacheLog<cr>', 'LuaCache log' },
    -- p = { '<cmd>LuaCacheProfile<cr>', 'LuaCache profile' },
    L = {
      group = '+logs',
      d = {
        function()
          require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())
        end,
        'view default log',
      },
      D = {
        function()
          vim.fn.execute('edit ' .. require('lvim.core.log').get_path())
        end,
        'Open the default logfile',
      },
      l = {
        function()
          require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())
        end,
        'view lsp log',
      },
      L = {
        function()
          vim.fn.execute('edit ' .. vim.lsp.get_log_path())
        end,
        'Open the LSP logfile',
      },
      n = {
        function()
          require('lvim.core.terminal').toggle_log_view(os.getenv 'NVIM_LOG_FILE')
        end,
        'view neovim log',
      },
      N = { '<cmd>edit $NVIM_LOG_FILE<cr>', 'Open the Neovim logfile' },
      p = {
        function()
          require('lvim.core.terminal').toggle_log_view 'packer.nvim'
        end,
        'view packer log',
      },
      P = { "<cmd>exe 'edit '.stdpath('cache').'/packer.nvim.log'<cr>", 'Open the Packer logfile' },
    },
  },
  m = {
    group = '+mark',
  },
  n = {
    group = '+noice',
  },
  N = { '<cmd>tabnew | set nobuflisted<cr>', 'which_key_ignore' },
  o = {
    group = '+open',
  },
  p = {
    group = '+project',
    S = {
      group = '+session-man',
      l = {
        function()
          vim.cmd 'SessionManager load_current_dir_session'
        end,
        'Current session',
      },
      L = {
        function()
          vim.cmd 'SessionManager load_last_session'
        end,
        'Last session',
      },
      a = {
        function()
          vim.cmd 'SessionManager load_session'
        end,
        'All sessions',
      },
      d = {
        function()
          vim.cmd 'SessionManager delete_session'
        end,
        'Delete session',
      },
      S = {
        function()
          vim.cmd 'SessionManager save_current_session'
        end,
        'Save session',
      },
    },
    -- C = { function() vim.cmd 'PackerCompile profile=true' end, 'Compile++' },
    -- P = { function() vim.cmd 'PackerProfile' end, 'Profile' },
    -- S = { function() vim.cmd 'PackerSync' end, 'Sync' },
    -- c = { function() vim.cmd 'PackerCompile' end, 'Compile' },
    -- i = { function() vim.cmd 'PackerInstall' end, 'Install' },
    -- k = { function() vim.cmd 'PackerClean' end, 'Clean' },
    -- p = { function() vim.cmd 'Telescope packer' end, 'Telescope Packer' },
    -- r = { require('young.packer').recompile, 'Re-compile' },
    -- s = { function() vim.cmd 'PackerStatus' end, 'Status' },
    -- u = { function() vim.cmd 'PackerUpdate' end, 'Update' },
    -- U = { function() vim.cmd 'PackerUpdate --preview' end, 'Update (preview)' },
    -- b = { require('young.packer').rollback, 'Rollback' },
    -- n = { require('young.packer').snapshot, 'Snapshot' },
    -- m = { require('young.packer').snapshot_hook, 'Snapshot sort' },
    -- v = { require('young.packer').loaded, 'Loaded' },
  },
  q = {
    function()
      vim.cmd.QuitWindowOrBuffer()
    end,
    'which_key_ignore',
  },
  Q = {
    function()
      vim.cmd.q()
    end,
    'which_key_ignore',
  },
  s = {
    group = '+search',
  },
  -- Q = { '<cmd>tabclose<cr>', 'which_key_ignore' },
  t = {
    group = '+toggle',
    [':'] = { ':call wilder#toggle()<cr>', 'Wilder' },
    a = {
      group = '+autocmd',
      f = {
        function()
          require('young.autocmd').toggle_format_on_save()
        end,
        'Format on save',
      },
      p = {
        function()
          require('young.autocmd').toggle_print_ascii()
        end,
        'Print ASCII',
      },
      -- r = { require('young.autocmd').toggle_auto_chdir, 'Auto chdir' },
      -- c = { require('young.autocmd').toggle_auto_cursorline, 'Cursorline' },
    },
    b = 'Biscuits',
    l = {
      function()
        require('young.tool').toggle_tabline()
      end,
      'Tabline',
    },
    n = {
      function()
        require('young.mod.notify').hot()
      end,
      'Nofity style',
    },
    N = {
      function()
        require('young.mod.notify').toggle()
      end,
      'Toggle nofity',
    },
  },
  T = {
    group = '+treesitter',
    t = {
      function()
        vim.cmd 'Telescope treesitter'
      end,
      'Telescope',
    },
    i = {
      function()
        vim.cmd 'TSConfigInfo'
      end,
      'Config',
    },
    I = {
      function()
        vim.cmd 'TSModuleInfo'
      end,
      'Module',
    },
    --
    h = {
      function()
        vim.cmd 'TSBufToggle highlight'
      end,
      'Toggle highlight(Buffer)',
    },
    r = {
      function()
        vim.cmd 'TSBufToggle rainbow'
      end,
      'Toggle rainbow',
    },
    -- Playground
    c = {
      function()
        vim.cmd 'TSCaptureUnderCursor'
      end,
      'Highlight',
    },
    n = {
      function()
        vim.cmd 'TSNodeUnderCursor'
      end,
      'Node',
    },
    p = {
      function()
        vim.cmd 'TSPlaygroundToggle'
      end,
      'Playground',
    },
    -- Context
    C = {
      function()
        vim.cmd 'TSContextToggle'
      end,
      'Toggle context',
    },
  },
  u = {
    group = '+ui',
  },
  v = {
    group = '+vim',
    v = {
      function()
        vim.cmd 'Inspect'
      end,
      'Inspect',
    },
    t = {
      function()
        vim.cmd 'InspectTree'
      end,
      'Inspect tree',
    },
  },
  -- w = { '<cmd>w!<cr>', 'Save' },
  w = {
    function()
      vim.cmd 'update'
    end,
    'which_key_ignore',
  },
  W = {
    function()
      vim.cmd 'wa'
    end,
    'which_key_ignore',
  },
  y = {
    group = '+young',
    ['1'] = {
      function()
        pp('[young] relative path', vim.fn.expand '%')
        vim.fn.setreg('+', vim.fn.expand '%')
      end,
      'Copy path',
    },
    ['2'] = {
      function()
        pp('[young] full path', vim.fn.expand '%:p')
        vim.fn.setreg('+', vim.fn.expand '%:p')
      end,
      'Copy full path',
    },
    b = {
      function()
        require('telescope.builtin').git_commits {
          cwd = vim.fn.stdpath 'config',
        }
      end,
      'Git commit',
    },
    c = {
      function()
        local file = join_paths(vim.fn.stdpath 'config', 'init.lua')
        xy.tool.open_file(file)
      end,
      'Open init.lua',
    },
    f = {
      function()
        require('young.mod.telescope.finder').find_config()
      end,
      'Find Config files',
    },
    g = {
      function()
        require('young.mod.telescope.finder').grep_config()
      end,
      'Grep Config files',
    },
    -- i = { "<cmd>lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>", 'Toggle LunarVim Info' },
    -- I = {
    --   "<cmd>lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>",
    --   "View LunarVim's changelog",
    -- },
    -- k = { "<cmd>lua require('lvim.keymappings').print()<cr>", "View LunarVim's default keymappings" },
    l = {
      function()
        local file = require('young.cfg').create_local_config()
        xy.tool.open_file(file)
      end,
      'Edit local config',
    },
    o = {
      function()
        require('young.mod.telescope.finder').open_changed_config()
      end,
      'Open changed Config files',
    },
    r = {
      function()
        require('young.cfg').reload()
      end,
      'Reload configuration',
    },
    y = {
      function()
        local file = require('young.cfg').lazy_path
        xy.tool.open_file(file)
      end,
      'Open plugins',
    },
    -- y = { cmd('edit ' .. require('young.cfg').reload_path), 'Edit plugins' },
    -- y = { "<cmd>lua vim.fn.execute('edit ' .. require('young.cfg').reload_path)<cr>", 'Edit plugins' },
  },
}
