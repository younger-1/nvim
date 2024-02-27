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
  -- [';'] = { function() vim.cmd 'Alpha' end, 'Dashboard' },
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
    name = '+help',
    ['?'] = {
      function()
        vim.cmd 'h reference_toc'
      end,
      '❓',
    },
    [' '] = {
      function()
        vim.cmd 'h api'
      end,
      'Api',
    },
    ['<tab>'] = {
      function()
        vim.cmd 'h news'
      end,
      'News',
    },
    A = {
      function()
        vim.cmd 'h vim-additions'
      end,
      'Vim additions',
    },
    C = {
      function()
        vim.cmd 'h cterm-colors'
      end,
      'Vim colors',
    },
    E = {
      function()
        vim.cmd 'h ex-edit-index'
      end,
      'Ex-edit index',
    },
    F = {
      function()
        vim.cmd 'h function-list'
      end,
      'Function list',
    },
    H = {
      function()
        vim.cmd 'h help-summary'
      end,
      'Help',
    },
    I = {
      function()
        vim.cmd 'h insert-index'
      end,
      'Insert index',
    },
    L = {
      function()
        vim.cmd 'h lsp'
      end,
      'LSP',
    },
    M = {
      function()
        vim.cmd 'h map-modes'
      end,
      'Map modes',
    },
    N = {
      function()
        vim.cmd 'h notation'
      end,
      'Notation',
    },
    O = {
      function()
        vim.cmd 'h option-list'
      end,
      'Option list',
    },
    T = {
      function()
        vim.cmd 'h tips'
      end,
      'Tips',
    },
    a = {
      function()
        vim.cmd 'h vim-arguments'
      end,
      'Vim arguments',
    },
    c = {
      function()
        vim.cmd 'h gui-colors'
      end,
      'Vim colors',
    },
    d = {
      function()
        vim.cmd 'h nvim-defaults'
      end,
      'Defaults',
    },
    e = {
      function()
        vim.cmd 'exu'
      end,
      'Ex-cmd index',
    },
    f = {
      function()
        vim.cmd 'h vim-function'
      end,
      'Functions',
    },
    g = {
      function()
        vim.cmd 'h g'
      end,
      'g-index',
    },
    h = {
      function()
        vim.cmd 'h help-tags'
      end,
      'Help tags',
    },
    i = {
      function()
        vim.cmd 'h index'
      end,
      'Index',
    },
    k = {
      function()
        vim.cmd 'h key-codes'
      end,
      'Key codes',
    },
    l = {
      function()
        vim.cmd 'h lua'
      end,
      'Lua',
    },
    m = {
      function()
        vim.cmd 'h vim-modes'
      end,
      'Modes',
    },
    n = {
      function()
        vim.cmd 'viu'
      end,
      'Normal index',
    },
    o = {
      function()
        vim.cmd 'options'
      end,
      'Options',
    },
    p = {
      function()
        vim.cmd 'h local-additions'
      end,
      'Plugin',
    },
    q = {
      function()
        vim.cmd 'h quickref'
      end,
      'Quick reference',
    },
    s = {
      function()
        vim.cmd 'h startup'
      end,
      'Startup',
    },
    t = {
      function()
        vim.cmd 'h objects'
      end,
      'Text objects',
    },
    u = {
      function()
        vim.cmd 'h user-manual'
      end,
      'User manual',
    },
    v = {
      function()
        vim.cmd 'h vim-variable'
      end,
      'Vim variable',
    },
    w = {
      function()
        vim.cmd 'h ctrl-w'
      end,
      'Windows index',
    },
    x = {
      function()
        vim.cmd 'h visual-index'
      end,
      'Visual index',
    },
    y = {
      function()
        vim.cmd 'h ['
      end,
      '[ ] index',
    },
    z = {
      function()
        vim.cmd 'h z'
      end,
      'z-index',
    },
  },
  a = {
    name = '+apps',
    [' '] = {
      function()
        vim.cmd 'Telescope command_palette'
      end,
      'Command palette',
    },
    e = { '+external' },
    g = {
      name = '+github',
      g = {
        function()
          vim.cmd 'Telescope gh gist'
        end,
        'Gist',
      },
      i = {
        function()
          vim.cmd 'Telescope gh issues'
        end,
        'Issues',
      },
      p = {
        function()
          vim.cmd 'Telescope gh pull_request'
        end,
        'Pull_request',
      },
      r = {
        function()
          vim.cmd 'Telescope gh run'
        end,
        'Run',
      },
    },
    m = {
      function()
        vim.cmd 'MarkdownPreviewToggle'
      end,
      'Markdown',
    },
    n = {
      name = '+nabla',
      n = {
        function()
          require('nabla').popup { border = 'rounded' }
        end,
        'ASCII LaTeX equations',
      },
      r = {
        function()
          require('nabla').replace_current()
        end,
        'Replace current LaTeX equations',
      },
      a = {
        function()
          require('nabla').replace_all()
        end,
        'Replace current LaTeX equations',
      },
      d = {
        function()
          require('nabla').draw_overlay()
        end,
        'Draw overlay',
      },
      t = {
        function()
          require('nabla').toggle_virt()
        end,
        'Toggle ASCII LaTeX',
      },
    },
    u = {
      function()
        xy.tool.open_url()
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
  b = {
    name = '+buffer',
    s = {
      name = '+sort',
    },
    -- A = { function() vim.cmd 'TablineToggleShowAllBuffers' end, 'Tabline toggle all' },
    -- U = { function() vim.cmd 'TablineBuffersClearBind' end, 'Tabline unbound' },
    -- B = { ':TablineBuffersBind ', 'Tabline bound' },
    -- R = { ':TablineTabRename ', 'Tabline rename' },
    -- N = { ':TablineTabNew ', 'Tabline new' },
    -- T = { ':TablineCustom ', 'Tabline++' },
  },
  c = {
    name = '+code',
    c = {
      name = '+lsp-extension',
    },
    n = {
      name = '+neogen',
    },
  },
  d = {
    name = '+debug',
    s = {
      name = '+telescope',
      [' '] = {
        function()
          vim.cmd 'Telescope dap configurations'
        end,
        'Dap configurations',
      },
      c = {
        function()
          vim.cmd 'Telescope dap commands'
        end,
        'Dap commands',
      },
      l = {
        function()
          vim.cmd 'Telescope dap list_breakpoints'
        end,
        'Dap list_breakpoints',
      },
      v = {
        function()
          vim.cmd 'Telescope dap variables'
        end,
        'Dap variables',
      },
      f = {
        function()
          vim.cmd 'Telescope dap frames'
        end,
        'Dap frames',
      },
    },
    [' '] = {
      function()
        require('dapui').toggle()
      end,
      ' UI',
    },
    ['<tab>'] = '+lang',
    f = {
      s = {
        function()
          vim.cmd 'DapScopesFloat'
        end,
        'Scopes float',
      },
      f = {
        function()
          vim.cmd 'DapFramesFloat'
        end,
        'Frames Float',
      },
      e = {
        function()
          vim.cmd 'DapExpressionFloat'
        end,
        'Expression float',
      },
      t = {
        function()
          vim.cmd 'DapThreadsFloat'
        end,
        'Threads float',
      },
    },
    -- h = { function() require'dap.ui.widgets'.hover() end, 'Hover' },
    h = {
      function()
        require('dapui').eval(nil, { enter = true })
      end,
      'Hover',
    },
    t = {
      function()
        vim.cmd 'DapVirtualTextToggle'
      end,
      'Virtual text',
    },
    ['['] = {
      function()
        require('persistent-breakpoints.api').load_breakpoints()
      end,
      'Load breakpoints',
    },
    [']'] = {
      function()
        require('persistent-breakpoints.api').store_breakpoints()
      end,
      'Store breakpoints',
    },

    L = {
      function()
        vim.cmd 'DapShowLog'
      end,
      'Show log',
    },

    -- s = { function() require'dap'.continue() end, ' Start' },
    c = {
      function()
        require('dap').continue()
      end,
      ' Continue',
    },
    a = {
      function()
        require('dap').run_to_cursor()
      end,
      '省 Run to cursor',
    },
    x = {
      function()
        require('dap').run_last()
      end,
      ' Run last',
    },
    v = {
      function()
        require('dap').goto_()
      end,
      'Jump/Skip to line',
    },
    z = {
      function()
        require('dap').pause()
      end,
      '懶 Pause',
    },

    d = {
      function()
        require('dap').toggle_breakpoint()
      end,
      'ﴫ Toggle breakpoint',
    },
    E = {
      function()
        require('dap').set_breakpoint(vim.fn.input 'Condition: ')
      end,
      ' Condition breakpoint',
    },
    F = {
      function()
        require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
      end,
      ' Log breakpoint',
    },
    H = {
      function()
        require('dap').set_breakpoint(nil, vim.fn.input 'Hit times: ')
      end,
      ' Hit breakpoint',
    },

    g = {
      function()
        require('dap').set_exception_breakpoints()
      end,
      'Ask exception breakpoints',
    },
    G = {
      function()
        require('dap').set_exception_breakpoints 'default'
      end,
      'Default exception breakpoints',
    },
    l = {
      function()
        require('dap').list_breakpoints(true)
      end,
      'List breakpoints',
    },
    C = {
      function()
        require('dap').clear_breakpoints()
      end,
      'Clear breakpoints',
    },

    r = {
      function()
        require('dap').repl.toggle()
      end,
      ' Toggle repl',
    },
    R = {
      function()
        require('dap').toggle()
      end,
      'Toggle Repl',
    },

    o = {
      function()
        require('dap').step_over()
      end,
      ' Step over',
    },
    i = {
      function()
        require('dap').step_into()
      end,
      ' Step into',
    },
    I = {
      function()
        require('dap').step_into { askForTargets = true }
      end,
      ' Step into',
    },
    u = {
      function()
        require('dap').step_out()
      end,
      ' Step out',
    },
    b = {
      function()
        require('dap').step_back()
      end,
      'Step back',
    },
    B = {
      function()
        require('dap').reverse_continue()
      end,
      'Reverse Continue',
    },
    j = {
      function()
        require('dap').down()
      end,
      'Stacktrace down',
    },
    k = {
      function()
        require('dap').up()
      end,
      'Stacktrace up',
    },

    q = {
      function()
        require('dap').terminate()
      end,
      'Terminate',
    },
    Q = {
      function()
        require('dap').disconnect()
      end,
      'Disconnect',
    },
    -- q = { function() require'dap'.close() end, 'Quit' },

    m = {
      function()
        pp(require('dap').status(), require('dap').session())
      end,
      'Print session',
    },
    J = {
      function()
        require('dap.ext.vscode').load_launchjs()
      end,
      'Load launch JSON',
    },
  },
  e = { name = 'explorer' },
  g = {
    name = '+git',
    [' '] = {
      function()
        vim.cmd 'tab Git'
      end,
      'Git',
    },
    m = {
      function()
        vim.cmd 'Flog'
      end,
      'Flog',
    },
    ['"'] = {
      function()
        vim.cmd 'Gitsigns toggle_current_line_blame'
      end,
      'Blames',
    },
    ["'"] = {
      function()
        vim.cmd 'Gitsigns toggle_linehl'
      end,
      'Line highlight',
    },
    ['`'] = {
      function()
        vim.cmd 'Gitsigns toggle_numhl'
      end,
      'Number highlight',
    },
    [';'] = {
      function()
        vim.cmd 'Gitsigns toggle_deleted'
      end,
      'Deleted lines',
    },
    [','] = {
      function()
        vim.cmd 'Gitsigns toggle_signs'
      end,
      'Sign highlight',
    },
    ['<C-q>'] = {
      name = '+quickfix',
      a = {
        function()
          require('gitsigns').setqflist 'all'
        end,
        'All git',
      },
      b = {
        function()
          require('gitsigns').setqflist 'attached'
        end,
        'Buffers',
      },
      c = {
        function()
          vim.cmd 'Gitsigns setqflist'
        end,
        'Current',
      },
    },
    ['<C-a>'] = {
      name = '+loclist',
      a = {
        function()
          require('gitsigns').setloclist(0, 'all')
        end,
        'All git',
      },
      b = {
        function()
          require('gitsigns').setloclist(0, 'attached')
        end,
        'Buffers',
      },
      c = {
        function()
          vim.cmd 'Gitsigns setloclist'
        end,
        'Current',
      },
    },
    b = {
      function()
        vim.cmd 'Telescope git_branches'
      end,
      'Branches',
    },
    c = {
      function()
        vim.cmd 'Telescope git_commits'
      end,
      'Commits',
    },
    C = {
      function()
        vim.cmd 'Telescope git_bcommits'
      end,
      'Commits(current file)',
    },
    e = {
      function()
        vim.cmd 'Telescope git_stash'
      end,
      'Stash',
    },
    f = {
      function()
        vim.cmd 'Telescope git_files'
      end,
      'Files',
    },
    o = {
      function()
        vim.cmd 'Telescope git_status'
      end,
      'Open changed file',
    },
    h = {
      function()
        vim.cmd 'Telescope git_bcommits_range'
      end,
      'Commits(current line)',
    },
    -- d = { function() vim.cmd 'Gitsigns diffthis ~1' end, 'Diff this' },
    d = {
      name = '+diff',
      [' '] = { ':DiffviewOpen ', 'Diffview open' },
      ['<tab>'] = { ':DiffviewFileHistory ', 'Diffview commits' },
      -- s = { function() vim.cmd 'DiffviewOpen --staged' end, 'Open staged' },
      -- c = { function() vim.cmd 'DiffviewClose' end, 'Close diff' },
      -- t = { function() vim.cmd 'DiffviewToggleFiles' end, 'Toggle files' },
      d = {
        function()
          vim.cmd 'DiffviewOpen'
        end,
        'Open diff',
      },
      h = {
        function()
          vim.cmd 'DiffviewFileHistory'
        end,
        'All commits',
      },
      f = {
        function()
          vim.cmd 'DiffviewFileHistory %'
        end,
        'File commits',
      },
      p = {
        function()
          vim.cmd 'DiffviewLog'
        end,
        'Log',
      },
      --
      a = { ':DiffviewFileHistory --author=', 'All commits (author)' },
      m = { ':DiffviewFileHistory --grep=', 'All commits (log message)' },
      l = {
        function()
          vim.cmd 'DiffviewFileHistory --base=LOCAL'
        end,
        'All commits (compare to local)',
      },
      y = {
        function()
          vim.cmd 'DiffviewFileHistory --merges'
        end,
        'All commits (merge)',
      },
      Y = {
        function()
          vim.cmd 'DiffviewFileHistory --no-merges'
        end,
        'All commits (no merge)',
      },
      --
      A = { ':DiffviewFileHistory % --author=', 'File commits (author)' },
      M = { ':DiffviewFileHistory % --grep=', 'File commits (log message)' },
      L = {
        function()
          vim.cmd 'DiffviewFileHistory % --base=LOCAL'
        end,
        'File commits (compare to local)',
      },
      R = { ':DiffviewFileHistory -L,:<Left><Left>', 'File commits (range)' },
      F = { ':DiffviewFileHistory -L::<Left>', 'File commits (func)' },
    },
    i = {
      name = '+gist',
      a = {
        function()
          vim.cmd 'Gist -b -a'
        end,
        'Create anon',
      },
      d = {
        function()
          vim.cmd 'Gist -d'
        end,
        'Delete',
      },
      f = {
        function()
          vim.cmd 'Gist -f'
        end,
        'Fork',
      },
      g = {
        function()
          vim.cmd 'Gist -b'
        end,
        'Create',
      },
      l = {
        function()
          vim.cmd 'Gist -l'
        end,
        'List',
      },
      p = {
        function()
          vim.cmd 'Gist -b -p'
        end,
        'Create private',
      },
    },
    j = {
      function()
        vim.cmd 'Gitsigns next_hunk'
      end,
      'Next hunk',
    },
    k = {
      function()
        vim.cmd 'Gitsigns prev_hunk'
      end,
      'Prev hunk',
    },
    l = {
      function()
        vim.cmd 'Gitsigns blame_line'
      end,
      'Blame',
    },
    L = {
      function()
        require('gitsigns').blame_line { full = true }
      end,
      'Blame',
    },
    n = {
      name = '+neogit',
      c = {
        function()
          require('neogit').open { 'commit' }
        end,
        'Commit',
      },
      n = {
        function()
          vim.cmd 'Neogit'
        end,
        '♐',
      },
      s = {
        function()
          require('neogit').open { kind = 'split' }
        end,
        'Commit',
      },
      v = {
        function()
          require('neogit').open { kind = 'vsplit' }
        end,
        'Commit',
      },
    },
    p = {
      function()
        vim.cmd 'Gitsigns preview_hunk_inline'
      end,
      'Preview hunk inline',
    },
    P = {
      function()
        vim.cmd 'Gitsigns preview_hunk'
      end,
      'Preview hunk',
    },
    r = { ':Gitsigns reset_hunk<CR>', 'Reset Hunk', mode = { 'n', 'x' } },
    R = {
      function()
        vim.cmd 'Gitsigns reset_buffer'
      end,
      'Reset buffer',
    },
    s = { ':Gitsigns stage_hunk<CR>', 'Stage Hunk', mode = { 'n', 'x' } },
    S = {
      function()
        vim.cmd 'Gitsigns stage_buffer'
      end,
      'Stage buffer',
    },
    u = { ':Gitsigns undo_stage_hunk<CR>', 'Undo stage Hunk', mode = { 'n', 'x' } },
    U = {
      function()
        vim.cmd 'Gitsigns reset_buffer_index'
      end,
      'Reset buffer index',
    },
    w = {
      function()
        vim.cmd 'Gitsigns toggle_word_diff'
      end,
      'Word diff',
    },
  },
  h = { '<cmd>nohlsearch<cr>', 'which_key_ignore' },
  j = {
    name = '+jump',
  },
  k = {
    name = '+kit',
  },
  l = {
    name = '+lsp',
  },
  L = {
    name = '+lua',
    -- impatient.nvim
    -- c = { '<cmd>LuaCacheClear<cr>', 'LuaCache clear' },
    -- l = { '<cmd>LuaCacheLog<cr>', 'LuaCache log' },
    -- p = { '<cmd>LuaCacheProfile<cr>', 'LuaCache profile' },
    L = {
      name = '+logs',
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
    name = '+mark',
  },
  n = {
    name = '+noice',
  },
  N = { '<cmd>tabnew | set nobuflisted<cr>', 'which_key_ignore' },
  o = {
    name = '+open',
    t = {
      function()
        vim.cmd 'TodoQuickFix'
      end,
      'Todo qf',
    },
    T = {
      function()
        vim.cmd 'TodoTelescope'
      end,
      'Todo telescope',
    },
  },
  p = {
    name = '+project',
    s = {
      name = '+sessions',
      l = {
        function()
          require('persistence').load()
        end,
        'Current session',
      },
      L = {
        function()
          require('persistence').load { last = true }
        end,
        'Last session',
      },
      s = {
        function()
          require('persistence').stop()
        end,
        'Stop session',
      },
    },
    S = {
      name = '+session-man',
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
  q = { '<cmd>QuitWindow<cr>', 'which_key_ignore' },
  Q = { '<cmd>q<cr>', 'which_key_ignore' },
  -- Q = { '<cmd>tabclose<cr>', 'which_key_ignore' },
  r = {
    name = '+replace',
  },
  s = {
    name = '+search',
  },
  t = {
    name = '+toggle',
    [':'] = { ':call wilder#toggle()<cr>', 'Wilder' },
    a = {
      name = '+autocmd',
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
    name = '+treesitter',
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
    name = '+ui',
  },
  v = {
    name = '+vim',
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
  x = {
    name = '+trouble',
  },
  y = {
    name = '+young',
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
