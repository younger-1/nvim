local cmd = require('young.key').cmd
local lua = require('young.key').lua

-- TODO:add function instead of <cmd><cr>
return {
  [' '] = { ':', 'which_key_ignore', mode = { 'n', 'x' } },
  ['`'] = { '<cmd>intro<cr>', 'Intro' },
  -- ['~'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['0'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['-'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['='] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['<BS>'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['<Tab>'] = { '<cmd>CellularAutomaton make_it_rain<cr>', 'Rain' },
  ['<CR>'] = { '<cmd>mes<cr>', 'which_key_ignore' },
  -- ['['] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- [']'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['{'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['}'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['<'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['>'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['\'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['|'] = { '<cmd>Alpha<cr>', 'Alpha' },
  [';'] = { cmd 'Alpha', 'Dashboard' },
  -- [':'] = { '<cmd>Alpha<cr>', 'Alpha' },
  ["'"] = { cmd 'Telescope live_grep_args', 'Grep' },
  -- ['"'] = { '<cmd>Alpha<cr>', 'Alpha' },
  [','] = { cmd 'Telescope buffers', 'Buffers' },
  -- ['.'] = { cmd 'Telescope find_files layout_strategy=horizontal', 'Files' },
  -- ['/'] = { cmd 'Telescope current_buffer_fuzzy_find', 'Buffer string' },
  ['?'] = {
    name = '+help',
    [' '] = { ':h api<cr>', 'Api' },
    ['?'] = { ':h reference_toc<cr>', '❓' },
    A = { ':h vim-additions<cr>', 'Vim additions' },
    C = { ':h cterm-colors<cr>', 'Vim colors' },
    E = { ':h ex-edit-index<cr>', 'Ex-edit index' },
    F = { ':h function-list<cr>', 'Function list' },
    H = { ':h help-summary<cr>', 'Help' },
    I = { ':h insert-index<cr>', 'Insert index' },
    L = { ':h lsp<cr>', 'LSP' },
    M = { ':h map-modes<cr>', 'Map modes' },
    N = { ':h notation<cr>', 'Notation' },
    O = { ':h option-list<cr>', 'Option list' },
    T = { ':h tips<cr>', 'Tips' },
    a = { ':h vim-arguments<cr>', 'Vim arguments' },
    c = { ':h gui-colors<cr>', 'Vim colors' },
    d = { ':h nvim-defaults<cr>', 'Defaults' },
    e = { ':exu<cr>', 'Ex-cmd index' },
    f = { ':h vim-function<cr>', 'Functions' },
    g = { ':h g<cr>', 'g-index' },
    h = { ':h help-tags<cr>', 'Help tags' },
    i = { ':h index<cr>', 'Index' },
    k = { ':h key-codes<cr>', 'Key codes' },
    l = { ':h lua<cr>', 'Lua' },
    m = { ':h vim-modes<cr>', 'Modes' },
    n = { ':viu<cr>', 'Normal index' },
    o = { ':options<cr>', 'Options' },
    p = { ':h local-additions<cr>', 'Plugin' },
    q = { ':h quickref<cr>', 'Quick reference' },
    s = { ':h startup<cr>', 'Startup' },
    t = { ':h objects<cr>', 'Text objects' },
    u = { ':h user-manual<cr>', 'User manual' },
    v = { ':h vim-variable<cr>', 'Vim variable' },
    w = { ':h ctrl-w<cr>', 'Windows index' },
    x = { ':h visual-index<cr>', 'Visual index' },
    y = { ':h [<cr>', '[ ] index' },
    z = { ':h z<cr>', 'z-index' },
  },
  C = { ':call OpenLastClosed()<cr>', 'which_key_ignore' },
  Q = { '<cmd>tabclose<cr>', 'which_key_ignore' },
  N = { '<cmd>tabnew | set nobuflisted<cr>', 'which_key_ignore' },
  T = {
    name = '+treesitter',
    t = { cmd 'Telescope treesitter', 'Telescope' },
    i = { cmd 'TSConfigInfo', 'Info' },
    I = { cmd 'TSModuleInfo', 'Telescope' },
    --
    h = { cmd 'TSBufToggle highlight', 'Toggle highlight(Buffer)' },
    r = { cmd 'TSBufToggle rainbow', 'Toggle rainbow' },
    -- Playground
    c = { cmd 'TSCaptureUnderCursor', 'Highlight' },
    n = { cmd 'TSNodeUnderCursor', 'Node' },
    p = { cmd 'TSPlaygroundToggle', 'Playground' },
    -- Context
    C = { cmd 'TSContextToggle', 'Toggle context' },
  },
  a = {
    name = '+apps',
    [' '] = { cmd 'Telescope command_palette', 'Command palette' },
    e = { '+external' },
    m = { cmd 'MarkdownPreviewToggle', 'Markdown' },
    n = {
      name = '+nabla',
      n = { lua "require('nabla').popup { border = 'rounded' }", 'ASCII LaTeX equations' },
      r = { lua "require('nabla').replace_current()", 'Replace current LaTeX equations' },
      a = { lua "require('nabla').replace_all()", 'Replace current LaTeX equations' },
      d = { lua "require('nabla').draw_overlay()", 'Draw overlay' },
      t = { lua "require('nabla').toggle_virt()", 'Toggle ASCII LaTeX' },
    },
    t = { cmd 'TodoQuickFix', 'Todo qf' },
    T = { cmd 'TodoTelescope', 'Todo telescope' },
    s = {
      name = '+sessions',
      l = { lua 'require("persistence").load()', 'Current session' },
      L = { lua 'require("persistence").load({ last = true })', 'Last session' },
      s = { lua 'require("persistence").stop()', 'Stop session' },
    },
    S = {
      name = '+session-man',
      l = { cmd 'SessionManager load_current_dir_session', 'Current session' },
      L = { cmd 'SessionManager load_last_session', 'Last session' },
      a = { cmd 'SessionManager load_session', 'All sessions' },
      d = { cmd 'SessionManager delete_session', 'Delete session' },
      S = { cmd 'SessionManager save_current_session', 'Save session' },
    },
    u = { xy.tool.open_url, 'Open github url' },
    v = { cmd 'OpenInVSCode', 'Open in vscode' },
  },
  b = {
    name = '+buffers',
    s = {
      f = { cmd 'Telescope find_files cwd=%:p:h', 'Find files' },
      g = { cmd 'Telescope live_grep cwd=%:p:h', 'Grep' },
      t = { cmd 'Telescope grep_string cwd=%:p:h', 'Text under cursor' },
    },
    --
    T = { ':TablineCustom ', 'Tabline++' },
    a = { cmd 'TablineToggleShowAllBuffers', 'Tabline toggle all' },
    u = { cmd 'TablineBuffersClearBind', 'Tabline unbound' },
    m = { ':TablineBuffersBind ', 'Tabline bound' },
    r = { ':TablineTabRename ', 'Tabline rename' },
    t = { ':TablineTabNew ', 'Tabline new' },
  },
  -- c = { '<cmd>BufferClose!<cr>', 'Close buffer' },
  d = {
    name = '+debug',
    [' '] = { lua "require'dapui'.toggle()", ' UI' },
    ['<tab>'] = '+lang',
    f = {
      s = { cmd 'DapScopesFloat', 'Scopes float' },
      f = { cmd 'DapFramesFloat', 'Frames Float' },
      e = { cmd 'DapExpressionFloat', 'Expression float' },
      t = { cmd 'DapThreadsFloat', 'Threads float' },
    },
    -- h = { lua "require'dap.ui.widgets'.hover()", 'Hover' },
    h = { lua "require'dapui'.eval(nil, { enter = true })", 'Hover' },
    t = { cmd 'DapVirtualTextToggle', 'Virtual text' },
    ['['] = { lua "require('persistent-breakpoints.api').load_breakpoints()", 'Load breakpoints' },
    [']'] = { lua "require('persistent-breakpoints.api').store_breakpoints()", 'Store breakpoints' },

    L = { cmd 'DapShowLog', 'Show log' },

    s = { lua "require'dap'.continue()", ' Start' },
    c = { lua "require'dap'.continue()", ' Continue' },
    a = { lua "require'dap'.run_to_cursor()", '省 Run to cursor' },
    x = { lua "require'dap'.run_last()", ' Run last' },
    v = { lua "require'dap'.goto_()", 'Jump/Skip to line' },
    z = { lua "require'dap'.pause()", '懶 Pause' },

    d = { lua "require'dap'.toggle_breakpoint()", 'ﴫ Toggle breakpoint' },
    E = { lua "require'dap'.set_breakpoint(vim.fn.input('Condition: '))", ' Condition breakpoint' },
    F = { lua "require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))", ' Log breakpoint' },
    H = { lua "require'dap'.set_breakpoint(nil, vim.fn.input('Hit times: '))", ' Hit breakpoint' },

    g = { lua "require'dap'.set_exception_breakpoints()", 'Ask exception breakpoints' },
    G = { lua "require'dap'.set_exception_breakpoints('default')", 'Default exception breakpoints' },
    l = { lua "require'dap'.list_breakpoints(true)", 'List breakpoints' },
    C = { lua "require'dap'.clear_breakpoints()", 'Clear breakpoints' },

    r = { lua "require'dap'.repl.toggle()", ' Toggle repl' },
    R = { lua "require'dap'.toggle()", 'Toggle Repl' },

    o = { lua "require'dap'.step_over()", ' Step over' },
    i = { lua "require'dap'.step_into()", ' Step into' },
    I = { lua "require'dap'.step_into { askForTargets = true }", ' Step into' },
    u = { lua "require'dap'.step_out()", ' Step out' },
    b = { lua "require'dap'.step_back()", 'Step back' },
    B = { lua "require'dap'.reverse_continue()", 'Reverse Continue' },
    j = { lua "require'dap'.down()", 'Stacktrace down' },
    k = { lua "require'dap'.up()", 'Stacktrace up' },

    q = { lua "require'dap'.terminate()", 'Terminate' },
    Q = { lua "require'dap'.disconnect()", 'Disconnect' },
    -- q = { lua "require'dap'.close()", 'Quit' },

    m = { lua "pp(require'dap'.status(), require'dap'.session())", 'Print session' },
    J = { lua "require('dap.ext.vscode').load_launchjs()", 'Load launch JSON' },
  },
  f = { lua "require('lir.float').toggle()", 'Files' },
  g = {
    name = '+git',
    [' '] = { cmd 'tab Git', 'Git' },
    m = { cmd 'Flog', 'Flog' },
    ['"'] = { cmd 'Gitsigns toggle_current_line_blame', 'Blames' },
    ["'"] = { cmd 'Gitsigns toggle_linehl', 'Line highlight' },
    ['`'] = { cmd 'Gitsigns toggle_numhl', 'Number highlight' },
    [';'] = { cmd 'Gitsigns toggle_deleted', 'Deleted lines' },
    [','] = { cmd 'Gitsigns toggle_signs', 'Deleted lines' },
    ['<C-q>'] = {
      name = '+quickfix',
      a = { "<cmd>lua require 'gitsigns'.setqflist('all')<cr>", 'All git' },
      b = { "<cmd>lua require 'gitsigns'.setqflist('attached')<cr>", 'Buffers' },
      c = { cmd 'Gitsigns setqflist', 'Current' },
    },
    ['<C-a>'] = {
      name = '+loclist',
      a = { lua "require 'gitsigns'.setloclist(0, 'all')", 'All git' },
      b = { lua "require 'gitsigns'.setloclist(0, 'attached')", 'Buffers' },
      c = { cmd 'Gitsigns setloclist', 'Current' },
    },
    b = { cmd 'Telescope git_branches', 'Checkout branch' },
    c = { cmd 'Telescope git_commits', 'Checkout commit' },
    C = { cmd 'Telescope git_bcommits', 'Checkout commit(for current file)' },
    e = { cmd 'Telescope git_stash', 'Stash' },
    f = { cmd 'Telescope git_files', 'Files' },
    -- d = { cmd 'Gitsigns diffthis ~1', 'Diff this' },
    d = {
      name = '+diff',
      [' '] = { ':DiffviewOpen ', 'Diffview open' },
      ['<tab>'] = { ':DiffviewFileHistory ', 'Diffview commits' },
      -- s = { cmd 'DiffviewOpen --staged', 'Open staged' },
      -- c = { cmd 'DiffviewClose', 'Close diff' },
      -- t = { cmd 'DiffviewToggleFiles', 'Toggle files' },
      d = { cmd 'DiffviewOpen', 'Open diff' },
      h = { cmd 'DiffviewFileHistory', 'All commits' },
      f = { cmd 'DiffviewFileHistory %', 'File commits' },
      p = { cmd 'DiffviewLog', 'Log' },
      --
      a = { ':DiffviewFileHistory --author=', 'All commits (author)' },
      m = { ':DiffviewFileHistory --grep=', 'All commits (log message)' },
      l = { cmd 'DiffviewFileHistory --base=LOCAL', 'All commits (compare to local)' },
      y = { cmd 'DiffviewFileHistory --merges', 'All commits (merge)' },
      Y = { cmd 'DiffviewFileHistory --no-merges', 'All commits (no merge)' },
      --
      A = { ':DiffviewFileHistory % --author=', 'File commits (author)' },
      M = { ':DiffviewFileHistory % --grep=', 'File commits (log message)' },
      L = { cmd 'DiffviewFileHistory % --base=LOCAL', 'File commits (compare to local)' },
      R = { ':DiffviewFileHistory -L,:<Left><Left>', 'File commits (range)' },
      F = { ':DiffviewFileHistory -L::<Left>', 'File commits (func)' },
    },
    h = {
      name = '+github',
      g = { 'Telescope gh gist', 'Gist' },
      i = { 'Telescope gh issues', 'Issues' },
      p = { 'Telescope gh pull_request', 'Pull_request' },
      r = { 'Telescope gh run', 'Run' },
    },
    t = {
      name = '+gist',
      a = { '<cmd>Gist -b -a<cr>', 'Create anon' },
      d = { '<cmd>Gist -d<cr>', 'Delete' },
      f = { '<cmd>Gist -f<cr>', 'Fork' },
      g = { '<cmd>Gist -b<cr>', 'Create' },
      l = { '<cmd>Gist -l<cr>', 'List' },
      p = { '<cmd>Gist -b -p<cr>', 'Create private' },
    },
    j = { cmd 'Gitsigns next_hunk', 'Next hunk' },
    k = { cmd 'Gitsigns prev_hunk', 'Prev hunk' },
    l = { cmd 'Gitsigns blame_line', 'Blame' },
    L = { "<cmd>lua require 'gitsigns'.blame_line { full=true }<cr>", 'Blame' },
    n = {
      name = '+neogit',
      c = { "<cmd>lua require('neogit').open({ 'commit' })<cr>", 'Commit' },
      n = { '<cmd>Neogit<cr>', '♐' },
      s = { "<cmd>lua require('neogit').open({ kind = 'split' })<cr>", 'Commit' },
      v = { "<cmd>lua require('neogit').open({ kind = 'vsplit' })<cr>", 'Commit' },
    },
    o = { cmd 'Telescope git_status', 'Open changed file' },
    p = { cmd 'Gitsigns preview_hunk', 'Preview hunk' },
    i = { cmd 'Gitsigns preview_hunk_inline', 'Preview hunk inline' },
    r = { ':Gitsigns reset_hunk<CR>', 'Reset Hunk', mode = { 'n', 'x' } },
    R = { cmd 'Gitsigns reset_buffer', 'Reset buffer' },
    s = { ':Gitsigns stage_hunk<CR>', 'Stage Hunk', mode = { 'n', 'x' } },
    S = { cmd 'Gitsigns stage_buffer', 'Stage buffer' },
    u = { ':Gitsigns undo_stage_hunk<CR>', 'Undo stage Hunk', mode = { 'n', 'x' } },
    U = { cmd 'Gitsigns reset_buffer_index', 'Reset buffer index' },
    w = { cmd 'Gitsigns toggle_word_diff', 'Word diff' },
    y = {
      function()
        require('gitlinker').get_buf_range_url(fn.mode(), {
          -- remote = "origin", -- force the use of a specific remote
          -- add_current_line_on_normal_mode = true, -- if true adds the line nr in the url for normal mode
          -- action_callback = require("gitlinker.actions").copy_to_clipboard, -- callback for what to do with the url
          -- print_url = true, -- print the url after action
          action_callback = vim.v.count ~= 0 and require('gitlinker.actions').open_in_browser or nil,
        })
      end,
      'Link',
      mode = { 'n', 'x' },
    },
    Y = {
      function()
        require('gitlinker').get_repo_url {
          action_callback = vim.v.count ~= 0 and require('gitlinker.actions').open_in_browser or nil,
        }
      end,
      'Link(Repo)',
    },
  },
  h = { '<cmd>nohlsearch<cr>', 'which_key_ignore' },
  j = {
    name = '+justify',
  },
  k = {
    name = '+kit',
  },
  l = {
    name = '+lsp',
  },
  c = {
    name = '+code',
  },
  L = {
    name = '+lua',
    c = { '<cmd>LuaCacheClear<cr>', 'LuaCache clear' },
    l = { '<cmd>LuaCacheLog<cr>', 'LuaCache log' },
    p = { '<cmd>LuaCacheProfile<cr>', 'LuaCache profile' },
    L = {
      name = '+logs',
      d = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>",
        'view default log',
      },
      D = {
        "<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>",
        'Open the default logfile',
      },
      l = { "<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>", 'view lsp log' },
      L = { "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", 'Open the LSP logfile' },
      n = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>",
        'view neovim log',
      },
      N = { '<cmd>edit $NVIM_LOG_FILE<cr>', 'Open the Neovim logfile' },
      p = { "<cmd>lua require('lvim.core.terminal').toggle_log_view('packer.nvim')<cr>", 'view packer log' },
      P = { "<cmd>exe 'edit '.stdpath('cache').'/packer.nvim.log'<cr>", 'Open the Packer logfile' },
    },
  },
  n = {
    name = '+neogen',
    f = { cmd 'Neogen func', 'Function' },
    F = { cmd 'Neogen file', 'File' },
    c = { cmd 'Neogen class', 'Class' },
    t = { cmd 'Neogen type', 'Type' },
  },
  -- p = {
  --   name = '+packer',
  --   C = { cmd 'PackerCompile profile=true', 'Compile++' },
  --   P = { cmd 'PackerProfile', 'Profile' },
  --   S = { cmd 'PackerSync', 'Sync' },
  --   c = { cmd 'PackerCompile', 'Compile' },
  --   i = { cmd 'PackerInstall', 'Install' },
  --   k = { cmd 'PackerClean', 'Clean' },
  --   p = { cmd 'Telescope packer', 'Telescope Packer' },
  --   r = { require('young.packer').recompile, 'Re-compile' },
  --   s = { cmd 'PackerStatus', 'Status' },
  --   u = { cmd 'PackerUpdate', 'Update' },
  --   U = { cmd 'PackerUpdate --preview', 'Update (preview)' },
  --   b = { require('young.packer').rollback, 'Rollback' },
  --   n = { require('young.packer').snapshot, 'Snapshot' },
  --   m = { require('young.packer').snapshot_hook, 'Snapshot sort' },
  --   v = { require('young.packer').loaded, 'Loaded' },
  -- },
  q = { '<cmd>q!<cr>', 'Quit' },
  r = {
    name = '+replace',
    f = { lua "require('spectre').open_file_search()", 'Replace buffer' },
    r = { lua "require('spectre').open()", 'Replace' },
    w = { lua "require('spectre').open_visual({select_word=true})", 'Replace word' },
  },
  s = {
    name = '+search',
    -- ['`'] = { 'TODO', 'Terminal' },
    -- ['~'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['0'] = { cmd 'Telescope pickers', 'Resume pickers' },
    u = { cmd 'Telescope pickers', 'Resume pickers' },
    [' '] = {
      function()
        require('telescope.builtin').resume { cache_index = vim.v.count1 }
      end,
      '',
    },
    -- ['1'] = { cmd 'Telescope resume cache_index=1', 'Resume 1' },
    -- ['2'] = { cmd 'Telescope resume cache_index=2', 'Resume 2' },
    -- ['3'] = { cmd 'Telescope resume cache_index=3', 'Resume 3' },
    -- ['4'] = { cmd 'Telescope resume cache_index=4', 'Resume 4' },
    -- ['5'] = { cmd 'Telescope resume cache_index=5', 'Resume 5' },
    -- ['6'] = { cmd 'Telescope resume cache_index=6', 'Resume 6' },
    -- ['7'] = { cmd 'Telescope resume cache_index=7', 'Resume 7' },
    -- ['8'] = { cmd 'Telescope resume cache_index=8', 'Resume 8' },
    -- ['9'] = { cmd 'Telescope resume cache_index=9', 'Resume 9' },
    ['-'] = { cmd 'Telescope reloader', 'Reload module' },
    ['='] = { cmd 'Telescope spell_suggest', 'Spell' },
    -- ['<BS>'] = { '<cmd>Alpha<cr>', 'Alpha' },
    ['<TAB>'] = { cmd 'Telescope builtin', '' },
    ['<CR>'] = { cmd 'Telescope builtin include_extensions=true', '' },
    -- ['['] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- [']'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['{'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['}'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['<'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['>'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['\'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['|'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- [';'] = { '<cmd>Alpha<cr>', 'Alpha' },
    [':'] = {
      function()
        local command_history_ignore = vim.regex 'edit\\|write\\|lua\\s='
        require('telescope.builtin').command_history {
          prompt_prefix = '$ ',
          filter_fn = function(item)
            if #item < 3 then
              return false
            else
              return not command_history_ignore:match_str(item)
            end
          end,
        }
      end,
      'Command history',
    },
    ["'"] = { cmd 'Telescope marks', 'Marks' },
    ['"'] = { cmd 'Telescope registers', 'Registers' },
    [','] = { cmd 'Telescope buffers', 'Find' },
    ['.'] = { cmd 'Telescope file_browser hidden=true', 'Browser' },
    ['/'] = { cmd 'Telescope search_history', 'Search history' },
    ['?'] = { cmd 'Telescope help_tags', 'Help' },
    ['<C-q>'] = { cmd 'Telescope quickfix', 'QuickList' },
    ['<C-a>'] = { cmd 'Telescope loclist', 'LocList' },
    ['q'] = { cmd 'Telescope quickfixhistory', 'QuickList history' },
    -- ['Q'] = { cmd 'Telescope loclisthistory', 'LocList' },
    a = { cmd 'Telescope autocommands', 'Autocommands' },
    b = { cmd 'Telescope current_buffer_fuzzy_find', 'Buffer string' },
    B = { cmd 'Telescope bookmarks', 'Bookmarks' },
    -- c = { cmd 'Telescope colorscheme', 'Colorscheme' },
    -- c = { cmd "lua require('telescope.builtin').colorscheme({enable_preview = true})", 'Colorscheme' },
    -- c = { cu('Telescope colorscheme enable_preview=' .. '<C-R>=v:count==0 ? "false" : "true"<CR>'), 'Colorscheme' },
    c = {
      function()
        require('telescope.builtin').colorscheme { enable_preview = vim.v.count ~= 0 }
      end,
      'Colorscheme',
    },
    C = { cmd 'Telescope commands', 'Commands' },
    d = {
      name = '+dap',
      [' '] = { cmd 'Telescope dap configurations', 'Dap configurations' },
      c = { cmd 'Telescope dap commands', 'Dap commands' },
      l = { cmd 'Telescope dap list_breakpoints', 'Dap list_breakpoints' },
      v = { cmd 'Telescope dap variables', 'Dap variables' },
      f = { cmd 'Telescope dap frames', 'Dap frames' },
    },
    e = { cmd 'Telescope env', 'Env' },
    f = { cmd 'Telescope find_files', 'Find files' },
    F = { cmd 'Telescope find_files no_ignore=true', 'Find files (more)' },
    g = {
      function()
        require('telescope.builtin').live_grep {
          -- grep_open_files = vim.v.count ~= 0,
          -- Like how fzf handles spaces with wildcards in rg
          on_input_filter_cb = vim.v.count ~= 0 and function(prompt)
            return { prompt = prompt:gsub('%s', '.*') }
          end,
        }
      end,
      'Grep',
    },
    G = {
      function()
        require('telescope.builtin').live_grep {
          additional_args = function()
            return { '-F' } --fixed-string
          end,
        }
      end,
      'Grep fixed string',
    },
    h = { cmd 'Telescope help_tags', 'Find help' },
    H = { cmd 'Telescope highlights', 'Highlights' },
    j = { cmd 'Telescope jumplist', 'Gump list' },
    k = {
      function()
        require('telescope.builtin').keymaps {
          modes = { 'n', 'i', 'c', 'x', 'o' },
          show_plug = vim.v.count ~= 0,
          only_buf = vim.v.count == 1, -- @see https://github.com/nvim-telescope/telescope.nvim/pull/2246
          lhs_filter = function(lhs)
            -- gg(lhs)
            return not string.find(lhs, 'Þ')
          end,
        }
      end,
      'Keymaps',
    },
    m = {
      name = '+mru',
      c = { lua "require('telescope').extensions.frecency.frecency{ default_text = ':CWD:' }", 'CWD' },
      l = { lua "require('telescope').extensions.frecency.frecency{ default_text = ':LSP:' }", 'LSP' },
      m = { lua "require('telescope').extensions.frecency.frecency()", 'Frecency' },
    },
    M = { cmd 'Telescope man_pages', 'Man pages' },
    n = { cmd 'Telescope notify', 'Notify' },
    O = { cmd 'Telescope heading', 'Heading' },
    p = { cmd 'Telescope projects', 'Projects' },
    r = { cmd 'Telescope oldfiles only_cwd=true', 'Open recent file (cwd)' },
    R = { cmd 'Telescope oldfiles', 'Open recent file' },
    s = {
      name = '+symbol',
      e = { lua "require'telescope.builtin'.symbols{ sources = {'emoji'} }", 'Emoji' },
      g = { lua "require'telescope.builtin'.symbols{ sources = {'gitmoji'} }", 'Git' },
      j = { lua "require'telescope.builtin'.symbols{ sources = {'julia'} }", 'Julia' },
      k = { lua "require'telescope.builtin'.symbols{ sources = {'kaomoji'} }", 'Kaomoji' },
      l = { lua "require'telescope.builtin'.symbols{ sources = {'latex'} }", 'LaTeX' },
      m = { lua "require'telescope.builtin'.symbols{ sources = {'math'} }", 'Math' },
      n = { lua "require'telescope.builtin'.symbols{ sources = {'nerd'} }", 'Nerd' },
      s = { cmd 'Telescope symbols', 'Symbols' },
    },
    t = { cmd 'Telescope grep_string', 'Text under cursor' },
    T = { cmd 'Telescope tagstack', 'Tag stack' },
    -- u = { cmd 'Telescope repo list', 'Repository' },
    v = {
      name = '+vim',
      f = { cmd 'Telescope filetypes', 'FileTypes' },
      o = { cmd 'Telescope vim_options', 'Options' },
      t = { cmd 'Telescope current_buffer_tags', 'Tags' },
      T = { cmd 'Telescope tag', 'All tags' },
    },
    y = { cmd 'Telescope neoclip', 'Clipboard' },
    Y = { cmd 'YankyRingHistory', 'Yanky Ring' },
    Z = { lua "require'telescope'.extensions.zoxide.list{}", 'Z' },
  },
  t = {
    name = '+toggle',
    [':'] = { ':call wilder#toggle()<cr>', 'Wilder' },
    a = {
      name = '+autocmd',
      f = { require('young.autocmd').toggle_format_on_save, 'Format on save' },
      p = { require('young.autocmd').toggle_print_ascii, 'Print ASCII' },
      -- r = { require('young.autocmd').toggle_auto_chdir, 'Auto chdir' },
      -- c = { require('young.autocmd').toggle_auto_cursorline, 'Cursorline' },
    },
    b = 'Biscuits',
    m = { cmd 'MinimapToggle', 'Minimap' },
    l = { require('young.tool').toggle_tabline, 'Tabline' },
    n = { require('young.tool').toggle_notify_style, 'Nofity style' },
    N = { require('young.tool').toggle_notify, 'Toggle nofity' },
    -- t = { cmd 'TransparentToggle', 'Transparent' },
    x = { cmd 'Hexmode', 'Hex mode' },
    u = { cmd 'UndotreeToggle', 'Undotree' },
  },
  -- w = { '<cmd>w!<cr>', 'Save' },
  w = { cmd 'update', 'Save' },
  x = {
    name = '+trouble',
    x = { cmd 'TroubleToggle', 'Open' },
    t = { cmd 'TodoTrouble', 'Todo' },
    ['.'] = { cmd 'Trouble telescope', 'Telescope' },
    ['<C-q>'] = { cmd 'TroubleToggle quickfix', 'QuickFix' },
    ['<C-a>'] = { cmd 'TroubleToggle loclist', 'LocList' },
    --
    d = { cmd 'TroubleToggle lsp_definitions', 'Def' },
    r = { cmd 'TroubleToggle lsp_references', 'Ref' },
    y = { cmd 'TroubleToggle lsp_type_definitions', 'Type' },
    i = { cmd 'TroubleToggle lsp_implementations', 'Impl' },
    e = { cmd 'TroubleToggle document_diagnostics', 'Diagnostics' },
    E = { cmd 'TroubleToggle workspace_diagnostics', 'Diagnostics(All)' },
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
    c = { cmd('edit ' .. join_paths(vim.fn.stdpath 'config', 'init.lua')), 'Edit init.lua' },
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
    l = { require('young.cfg').open_local_config, 'Edit local config' },
    o = {
      function()
        require('young.mod.telescope.finder').open_changed_config()
      end,
      'Open changed Config files',
    },
    r = { require('young.cfg').reload, 'Reload configuration' },
    y = { cmd('edit ' .. require('young.cfg').lazy_path), 'Edit plugins' },
    -- y = { cmd('edit ' .. require('young.cfg').reload_path), 'Edit plugins' },
    -- y = { "<cmd>lua vim.fn.execute('edit ' .. require('young.cfg').reload_path)<cr>", 'Edit plugins' },
  },
  -- z = { cmd 'ZenMode', 'Zen' },
}
