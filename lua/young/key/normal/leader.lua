local cmd = require('young.key').cmd
local lua = require('young.key').lua

-- TODO:add function instead of <cmd><cr>
return {
  [' '] = { ':', 'which_key_ignore', silent = false },
  -- ['`'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['~'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['0'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['-'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['='] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['<BS>'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['<Tab>'] = { '<cmd>Alpha<cr>', 'Alpha' },
  ['<CR>'] = { ':mes<cr>', 'which_key_ignore' },
  -- ['['] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- [']'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['{'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['}'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['<'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['>'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['\'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['|'] = { '<cmd>Alpha<cr>', 'Alpha' },
  [';'] = { cmd 'Alpha', 'Alpha' },
  -- [':'] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ["'"] = { '<cmd>Alpha<cr>', 'Alpha' },
  -- ['"'] = { '<cmd>Alpha<cr>', 'Alpha' },
  [','] = { '<cmd>Telescope buffers<cr>', 'Buffers' },
  ['.'] = { '<cmd>Telescope find_files layout_strategy=horizontal<cr>', 'Files' },
  ['/'] = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Buffer string' },
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
  -- ['<C-q>'] = { '<cmd>Telescope quickfix<cr>', 'QuickList' },
  -- ['<C-a>'] = { '<cmd>Telescope loclist<cr>', 'LocList' },
  C = { ':call OpenLastClosed()<cr>', 'which_key_ignore' },
  Q = { '<cmd>tabclose<cr>', 'which_key_ignore' },
  T = {
    name = '+treesitter',
    I = { '<cmd>TSModuleInfo<cr>', 'Telescope' },
    T = { '<cmd>TSHighlightCapturesUnderCursor<cr>', 'Highlight' },
    c = { '<cmd>TSContextToggle<cr>', 'Toggle context' },
    h = { '<cmd>TSBufToggle highlight<cr>', 'Toggle highlight(Buffer)' },
    i = { '<cmd>TSConfigInfo<cr>', 'Info' },
    p = { '<cmd>TSPlaygroundToggle<cr>', 'Playground' },
    r = { '<cmd>TSBufToggle rainbow<cr>', 'Toggle rainbow' },
    t = { '<cmd>Telescope treesitter<cr>', 'Telescope' },
  },
  a = {
    name = '+apps',
    [' '] = { '<cmd>Telescope command_palette<cr>', 'Command palette' },
    e = { '+external' },
    m = { '<cmd>MarkdownPreviewToggle<cr>', 'Markdown' },
    t = { '<cmd>TodoQuickFix<cr>', 'Todo qf' },
    T = { '<cmd>TodoTelescope<cr>', 'Todo telescope' },
    s = {
      name = '+sessions',
      l = { '<cmd>lua require("persistence").load()<cr>', 'Current session' },
      L = { '<cmd>lua require("persistence").load({ last = true })<cr>', 'Last session' },
      s = { '<cmd>lua require("persistence").stop()<cr>', 'Stop session' },
    },
    S = {
      name = '+session-man',
      l = { '<cmd>SessionManager load_current_dir_session<cr>', 'Current session' },
      L = { '<cmd>SessionManager load_last_session<cr>', 'Last session' },
      a = { '<cmd>SessionManager load_session<cr>', 'All sessions' },
      d = { '<cmd>SessionManager delete_session<cr>', 'Delete session' },
      S = { '<cmd>SessionManager save_current_session<cr>', 'Save session' },
    },
    u = { xy.tool.open_url, 'Open github url' },
  },
  b = {
    name = '+buffers',
    B = { '<cmd>BufferOrderByBufferNumber<cr>', 'Sort by bufnr' },
    D = { '<cmd>BufferOrderByDirectory<cr>', 'Sort by directory' },
    L = { '<cmd>BufferOrderByLanguage<cr>', 'Sort by language' },
    T = { ':TablineCustom ', 'Tabline++' },
    W = { '<cmd>BufferOrderByWindowNumber<cr>', 'Sort by windowNumber' },
    a = { '<cmd>TablineToggleShowAllBuffers<cr>', 'Tabline toggle all' },
    b = { '<cmd>b#<cr>', 'Previous' },
    d = { ':TablineBuffersBind ', 'Tabline bound' },
    e = { '<cmd>BufferCloseAllButCurrent<cr>', 'Close all but current' },
    s = {
      f = { cmd 'Telescope find_files cwd=%:p:h', 'Find files' },
      g = { cmd 'Telescope live_grep cwd=%:p:h', 'Grep' },
      t = { cmd 'Telescope grep_string cwd=%:p:h', 'Text under cursor' },
    },
    h = { '<cmd>BufferCloseBuffersLeft<cr>', 'Close all to the left' },
    j = { '<cmd>BufferPick<cr>', 'Jump' },
    l = { '<cmd>BufferLast<cr>', 'Last' },
    o = { '<cmd>BufferCloseAllButCurrent<cr>', 'Close all but current' },
    p = { '<cmd>BufferPin<cr>', 'Pin' },
    r = { ':TablineTabRename ', 'Tabline rename' },
    t = { ':TablineTabNew ', 'Tabline new' },
    u = { '<cmd>TablineBuffersClearBind<cr>', 'Tabline unbound' },
    w = { '<cmd>BufferWipeout<cr>', 'Wipeout' },
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
  e = { cmd 'NvimTreeToggle', 'Explorer' },
  f = { lua "require('lir.float').toggle()", 'Files' },
  g = {
    name = '+git',
    [' '] = {
      name = '+gist',
      a = { '<cmd>Gist -b -a<cr>', 'Create anon' },
      d = { '<cmd>Gist -d<cr>', 'Delete' },
      f = { '<cmd>Gist -f<cr>', 'Fork' },
      g = { '<cmd>Gist -b<cr>', 'Create' },
      l = { '<cmd>Gist -l<cr>', 'List' },
      p = { '<cmd>Gist -b -p<cr>', 'Create private' },
    },
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
      a = { "<cmd>lua require 'gitsigns'.setloclist(0, 'all')<cr>", 'All git' },
      b = { "<cmd>lua require 'gitsigns'.setloclist(0, 'attached')<cr>", 'Buffers' },
      c = { cmd 'Gitsigns setloclist', 'Current' },
    },
    b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
    c = { '<cmd>Telescope git_commits<cr>', 'Checkout commit' },
    C = { '<cmd>Telescope git_bcommits<cr>', 'Checkout commit(for current file)' },
    d = { cmd 'Gitsigns diffthis HEAD', 'Git diff' },
    e = { '<cmd>Telescope git_stash<cr>', 'Stash' },
    f = { '<cmd>Telescope git_files<cr>', 'Files' },
    h = {
      name = '+github',
      g = { '<cmd>Telescope gh gist<cr>', 'Gist' },
      i = { '<cmd>Telescope gh issues<cr>', 'Issues' },
      p = { '<cmd>Telescope gh pull_request<cr>', 'Pull_request' },
      r = { '<cmd>Telescope gh run<cr>', 'Run' },
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
    o = { '<cmd>Telescope git_status<cr>', 'Open changed file' },
    p = { cmd 'Gitsigns preview_hunk', 'Preview hunk' },
    r = { cmd 'Gitsigns reset_hunk', 'Reset hunk' },
    R = { cmd 'Gitsigns reset_buffer', 'Reset buffer' },
    s = { cmd 'Gitsigns stage_hunk', 'Stage hunk' },
    S = { cmd 'Gitsigns stage_buffer', 'Stage buffer' },
    u = { cmd 'Gitsigns undo_stage_hunk()', 'Undo stage hunk' },
    U = { cmd 'Gitsigns reset_buffer_index', 'Reset buffer index' },
    w = { cmd 'Gitsigns toggle_word_diff', 'Word diff' },
    y = 'Link',
    -- y = { 'Link', mode = { 'n', 'x' } },
    Y = { "<cmd>lua require'gitlinker'.get_repo_url()<cr>", 'Link(Repo)' },
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
    i = { cmd 'LspInfo', 'Info' },
    m = { cmd 'Mason', 'Mason' },
    n = { cmd 'NullLsInfo', 'Null LS' },
    c = { cmd 'CmpStatus', 'Cmp status' },
    C = { cmd 'Copilot status', 'Copilot status' },
    --
    ['['] = { vim.lsp.buf.incoming_calls, 'Incoming calls' },
    [']'] = { vim.lsp.buf.outgoing_calls, 'Outgoing calls' },
    ['<C-q>'] = { vim.diagnostic.setqflist, 'Diagnostics quickfix' },
    ['<C-a>'] = { vim.diagnostic.setloclist, 'Diagnostics locList' },
    a = { vim.lsp.buf.code_action, 'Code action' },
    A = { vim.lsp.buf.range_code_action, 'Range action' },
    s = { vim.lsp.buf.workspace_symbol, 'Goto type definition' },
    f = { vim.lsp.buf.formatting, 'Format' },
    F = {
      function()
        vim.lsp.buf.formatting_sync()
        vim.cmd 'write'
      end,
      'Format & Save',
    },
    j = { vim.diagnostic.goto_next, 'Next diagnostic' },
    k = { vim.diagnostic.goto_prev, 'Prev diagnostic' },
    l = { vim.lsp.codelens.run, 'CodeLens action' },
    r = { vim.lsp.buf.rename, 'Rename' },
    --
    t = { require('young.mod.lsp_lines').toggle, 'Toggle virtual text' },
    w = {
      name = '+workspace',
      w = { lua 'pp(vim.lsp.buf.list_workspace_folders())', 'Workspace folders' },
      a = { lua 'pp(vim.lsp.buf.add_workspace_folder())', 'Add folder' },
      r = { lua 'pp(vim.lsp.buf.remove_workspace_folder())', 'Remove folder' },
    },
  },
  c = {
    name = '+code',
    -- [' '] = {},
    d = { cmd 'Telescope lsp_definitions', 'Def' },
    y = { cmd 'Telescope lsp_type_definitions', 'Type' },
    i = { cmd 'Telescope lsp_implementations', 'Impl' },
    r = { cmd 'Telescope lsp_references', 'Ref' },
    s = { cmd 'Telescope lsp_document_symbols', 'Document symbols' },
    w = { cmd 'Telescope lsp_workspace_symbols', 'Workspace symbols' },
    S = { cmd 'Telescope lsp_dynamic_workspace_symbols', 'Dynamic Workspace symbols' },
    ['['] = { cmd 'Telescope lsp_incoming_calls', 'Incoming calls' },
    [']'] = { cmd 'Telescope lsp_outgoing_calls', 'Outgoing calls' },
    e = { cmd 'Telescope diagnostics bufnr=0', 'Diagnostics' },
    E = { cmd 'Telescope diagnostics', 'Diagnostics(All)' },
    --
    c = { cmd 'CodeActionMenu', 'Code action' },
    o = { cmd 'SymbolsOutline', 'Outline' },
    v = { cmd 'Vista!!', 'Vista' },
    -- p = {
    --   name = '+peek',
    --   d = { "<cmd>lua require('young.lsp.misc').Peek('definition')<cr>", 'Definition' },
    --   i = { "<cmd>lua require('young.lsp.misc').Peek('implementation')<cr>", 'Implementation' },
    --   t = { "<cmd>lua require('young.lsp.misc').Peek('typeDefinition')<cr>", 'Type definition' },
    -- },
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
  p = {
    name = '+packer',
    C = { '<cmd>PackerCompile profile=true<cr>', 'Compile++' },
    P = { '<cmd>PackerProfile<cr>', 'Profile' },
    S = { '<cmd>PackerSync<cr>', 'Sync' },
    c = { '<cmd>PackerCompile<cr>', 'Compile' },
    i = { '<cmd>PackerInstall<cr>', 'Install' },
    k = { '<cmd>PackerClean<cr>', 'Clean' },
    p = { '<cmd>Telescope packer<cr>', 'Telescope Packer' },
    r = { require('young.packer').recompile, 'Re-compile' },
    s = { '<cmd>PackerStatus<cr>', 'Status' },
    u = { '<cmd>PackerUpdate<cr>', 'Update' },
    b = { require('young.packer').rollback, 'Rollback' },
    n = { require('young.packer').snapshot, 'Snapshot' },
    m = { require('young.packer').snapshot_hook, 'Snapshot sort' },
  },
  q = { '<cmd>q!<cr>', 'Quit' },
  r = {
    name = '+replace',
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", 'Replace buffer' },
    r = { "<cmd>lua require('spectre').open()<cr>", 'Replace' },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", 'Replace word' },
  },
  s = {
    name = '+search',
    [' '] = { '<cmd>Telescope resume<cr>', '' },
    -- ['`'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['~'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['0'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['-'] = { '<cmd>Alpha<cr>', 'Alpha' },
    ['='] = {
      name = '+symbol',
      e = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'emoji'} }<cr>", 'Emoji' },
      g = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'gitmoji'} }<cr>", 'Git' },
      j = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'julia'} }<cr>", 'Julia' },
      k = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'kaomoji'} }<cr>", 'Kaomoji' },
      l = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'latex'} }<cr>", 'LaTeX' },
      m = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'math'} }<cr>", 'Math' },
      s = { '<cmd>Telescope symbols<cr>', 'Symbols' },
    },
    -- ['<BS>'] = { '<cmd>Alpha<cr>', 'Alpha' },
    ['<tab>'] = { '<cmd>Telescope<cr>', '' },
    -- ['<CR>'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['['] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- [']'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['{'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['}'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['<'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['>'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['\'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- ['|'] = { '<cmd>Alpha<cr>', 'Alpha' },
    -- [';'] = { '<cmd>Alpha<cr>', 'Alpha' },
    [':'] = { '<cmd>Telescope command_history<cr>', 'Command history' },
    ["'"] = { '<cmd>Telescope marks<cr>', 'Marks' },
    ['"'] = { '<cmd>Telescope registers<cr>', 'Registers' },
    [','] = { '<cmd>Telescope buffers<cr>', 'Find' },
    ['.'] = { '<cmd>Telescope file_browser hidden=v:true<cr>', 'Browser' },
    ['/'] = { '<cmd>Telescope search_history<cr>', 'Search history' },
    ['?'] = { '<cmd>Telescope help_tags<cr>', 'Help' },
    ['<C-q>'] = { '<cmd>Telescope quickfix<cr>', 'QuickList' },
    ['<C-a>'] = { '<cmd>Telescope loclist<cr>', 'LocList' },
    B = { '<cmd>Telescope bookmarks<cr>', 'Bookmarks' },
    C = { '<cmd>Telescope commands<cr>', 'Commands' },
    H = { '<cmd>Telescope highlights<cr>', 'Highlights' },
    M = { '<cmd>Telescope man_pages<cr>', 'Man pages' },
    P = { '<cmd>Telescope pickers<cr>', '<Pickers>' },
    R = { '<cmd>Telescope reloader<cr>', 'Reload module' },
    S = { '<cmd>Telescope spell_suggest<cr>', 'Spell' },
    a = { '<cmd>Telescope autocommands<cr>', 'Autocommands' },
    b = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Buffer string' },
    c = { "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", 'Colorscheme' },
    d = {
      name = '+dap',
      [' '] = { cmd 'Telescope dap configurations', 'Dap configurations' },
      c = { cmd 'Telescope dap commands', 'Dap commands' },
      l = { cmd 'Telescope dap list_breakpoints', 'Dap list_breakpoints' },
      v = { cmd 'Telescope dap variables', 'Dap variables' },
      f = { cmd 'Telescope dap frames', 'Dap frames' },
    },
    e = { '<cmd>Telescope env<cr>', 'Env' },
    f = { '<cmd>Telescope find_files<cr>', 'Find files' },
    F = { '<cmd>Telescope find_files no_ignore=1<cr>', 'Find files (more)' },
    g = { '<cmd>Telescope live_grep <cr>', 'Grep' },
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
    -- G = { '<cmd>Telescope live_grep grep_open_files=v:true<cr>', 'Grep in opened buffer' },
    h = { '<cmd>Telescope help_tags<cr>', 'Find help' },
    j = { '<cmd>Telescope jumplist<cr>', 'Gump list' },
    k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
    m = {
      name = '+mru',
      c = { "<cmd>lua require('telescope').extensions.frecency.frecency{ default_text = ':CWD:' }<cr>", 'CWD' },
      l = { "<cmd>lua require('telescope').extensions.frecency.frecency{ default_text = ':LSP:' }<cr>", 'LSP' },
      m = { "<cmd>lua require('telescope').extensions.frecency.frecency()<cr>", 'Frecency' },
    },
    n = { '<cmd>Telescope notify<cr>', 'Notify' },
    o = { '<cmd>Telescope heading<cr>', 'Heading' },
    p = { '<cmd>Telescope projects<cr>', 'Projects' },
    r = { '<cmd>Telescope oldfiles<cr>', 'Open recent file' },
    s = { '<cmd>Telescope<cr>', '' },
    t = { '<cmd>Telescope grep_string<cr>', 'Text under cursor' },
    u = { '<cmd>Telescope repo list<cr>', 'Repository' },
    v = {
      name = '+vim',
      T = { cmd 'Telescope tag', 'All tags' },
      c = { cmd 'Telescope commands', 'Commands' },
      f = { cmd 'Telescope filetypes', 'FileTypes' },
      o = { cmd 'Telescope vim_options', 'Options' },
      t = { cmd 'Telescope current_buffer_tags', 'Tags' },
    },
    y = { cmd 'Telescope neoclip', 'Clipboard' },
    Y = { cmd 'YankyRingHistory', 'Yanky Ring' },
    Z = { "<cmd>lua require'telescope'.extensions.zoxide.list{}<cr>", 'Z' },
  },
  t = {
    name = '+toggle',
    [':'] = { ':call wilder#toggle()<cr>', 'Wilder' },
    a = {
      name = '+autocmd',
      f = { require('young.autocmd').toggle_format_on_save, 'Format on save' },
      p = { require('young.autocmd').toggle_print_ascii, 'Print ASCII' },
      -- r = { require('young.autocmd').toggle_auto_chdir, 'Auto chdir' },
    },
    b = 'Biscuits',
    m = { cmd 'MinimapToggle', 'Minimap' },
    l = { require('young.tool').toggle_tabline, 'Tabline' },
    i = { require('young.tool').toggle_indent_style, 'Indent style' },
    n = { require('young.tool').toggle_notify_style, 'Nofity style' },
    N = { require('young.tool').toggle_notify, 'Toggle nofity' },
    t = { cmd 'TransparentToggle', 'Transparent' },
    u = { cmd 'UndotreeToggle', 'Undotree' },
  },
  w = { '<cmd>w!<cr>', 'Save' },
  x = {
    name = '+trouble',
    ['.'] = { cmd 'Trouble telescope', 'Telescope' },
    --
    e = { cmd 'TroubleToggle document_diagnostics', 'Diagnostics' },
    E = { cmd 'TroubleToggle workspace_diagnostics', 'Diagnostics(All)' },
    --
    ['<C-q>'] = { cmd 'TroubleToggle quickfix', 'QuickFix' },
    ['<C-a>'] = { cmd 'TroubleToggle loclist', 'LocList' },
    --
    x = { cmd 'TroubleToggle', 'Open' },
    d = { cmd 'TroubleToggle lsp_definitions', 'Def' },
    i = { cmd 'TroubleToggle lsp_implementations', 'Impl' },
    r = { cmd 'TroubleToggle lsp_references', 'Ref' },
    y = { cmd 'TroubleToggle lsp_type_definitions', 'Type' },
    t = { cmd 'TodoTrouble', 'Todo' },
  },
  y = {
    name = '+young',
    b = {
      "<cmd>lua require('telescope.builtin').git_commits { cwd = _G.get_runtime_dir() .. '/lvim' }<cr>",
      'LunarVim Git Branch',
    },
    c = { ':edit ' .. join_paths(vim.fn.stdpath 'config', 'init.lua') .. '<cr>', 'Edit init.lua' },
    f = {
      function()
        require('young.mod.telescope.finder').find_vim_config()
      end,
      'Find Config files',
    },
    g = {
      function()
        require('young.mod.telescope.finder').grep_vim_config()
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
        require('young.mod.telescope.finder').open_changed_vim_config()
      end,
      'Open changed Config files',
    },
    r = { require('young.cfg').reload, 'Reload configuration' },
    y = { ':edit ' .. require('young.cfg').reload_path .. '<cr>', 'Edit plugins' },
    -- y = { "<cmd>lua vim.fn.execute('edit ' .. require('young.cfg').reload_path)<cr>", 'Edit plugins' },
  },
  z = { '<cmd>ZenMode<cr>', 'Zen' },
}
