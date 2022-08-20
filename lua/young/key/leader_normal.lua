local mappings = {
  ['/'] = { '<cmd>Telescope find_files layout_strategy=horizontal<cr>', 'Files' },
  [';'] = { '<cmd>Alpha<cr>', 'Alpha' },
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
  T = {
    name = '+treesitter',
    I = { '<cmd>TSModuleInfo<cr>', 'Telescope' },
    T = { '<cmd>TSHighlightCapturesUnderCursor<cr>', 'Highlight' },
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
    t = { '<cmd>TodoQuickFix<cr>', 'Todo' },
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
    f = { '<cmd>Telescope buffers<cr>', 'Find' },
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
  c = { '<cmd>BufferClose!<cr>', 'Close buffer' },
  d = {
    name = '+debug',
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", 'Run to cursor' },
    b = { "<cmd>lua require'dap'.step_back()<cr>", 'Step back' },
    c = { "<cmd>lua require'dap'.continue()<cr>", 'Continue' },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", 'Disconnect' },
    g = { "<cmd>lua require'dap'.session()<cr>", 'Get session' },
    i = { "<cmd>lua require'dap'.step_into()<cr>", 'Step into' },
    o = { "<cmd>lua require'dap'.step_over()<cr>", 'Step over' },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", 'Pause' },
    q = { "<cmd>lua require'dap'.close()<cr>", 'Quit' },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", 'Toggle repl' },
    s = { "<cmd>lua require'dap'.continue()<cr>", 'Start' },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", 'Toggle breakpoint' },
    u = { "<cmd>lua require'dap'.step_out()<cr>", 'Step out' },
  },
  f = { "<cmd>lua require('lir.float').toggle()<cr>", 'Files' },
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
    ['"'] = { '<cmd>Gitsigns toggle_current_line_blame<cr>', 'Blames' },
    ["'"] = { '<cmd>Gitsigns toggle_linehl<cr>', 'Line highlight' },
    ['`'] = { '<cmd>Gitsigns toggle_numhl<cr>', 'Number highlight' },
    ['<C-q>'] = {
      name = '+quickfix',
      a = { "<cmd>lua require 'gitsigns'.setqflist('all')<cr>", 'All git' },
      b = { "<cmd>lua require 'gitsigns'.setqflist('attached')<cr>", 'Buffers' },
      c = { '<cmd>Gitsigns setqflist<cr>', 'Current' },
    },
    ['<C-a>'] = {
      name = '+loclist',
      a = { "<cmd>lua require 'gitsigns'.setloclist(0, 'all')<cr>", 'All git' },
      b = { "<cmd>lua require 'gitsigns'.setloclist(0, 'attached')<cr>", 'Buffers' },
      c = { '<cmd>Gitsigns setloclist<cr>', 'Current' },
    },
    b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
    c = { '<cmd>Telescope git_commits<cr>', 'Checkout commit' },
    C = { '<cmd>Telescope git_bcommits<cr>', 'Checkout commit(for current file)' },
    d = { '<cmd>Gitsigns diffthis HEAD<cr>', 'Git diff' },
    e = { '<cmd>Telescope git_stash<cr>', 'Stash' },
    f = { '<cmd>Telescope git_files<cr>', 'Files' },
    h = {
      name = '+github',
      g = { '<cmd>Telescope gh gist<cr>', 'Gist' },
      i = { '<cmd>Telescope gh issues<cr>', 'Issues' },
      p = { '<cmd>Telescope gh pull_request<cr>', 'Pull_request' },
      r = { '<cmd>Telescope gh run<cr>', 'Run' },
    },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", 'Next hunk' },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", 'Prev hunk' },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", 'Blame' },
    L = { "<cmd>lua require 'gitsigns'.blame_line { full=true }<cr>", 'Blame' },
    n = {
      name = '+neogit',
      c = { "<cmd>lua require('neogit').open({ 'commit' })<cr>", 'Commit' },
      n = { '<cmd>Neogit<cr>', '♐' },
      s = { "<cmd>lua require('neogit').open({ kind = 'split' })<cr>", 'Commit' },
      v = { "<cmd>lua require('neogit').open({ kind = 'vsplit' })<cr>", 'Commit' },
    },
    o = { '<cmd>Telescope git_status<cr>', 'Open changed file' },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", 'Preview hunk' },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", 'Reset hunk' },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", 'Reset buffer' },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", 'Stage hunk' },
    S = { '<cmd>Gitsigns stage_buffer<cr>', 'Stage buffer' },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", 'Undo stage hunk' },
    U = { '<cmd>Gitsigns reset_buffer_index<cr>', 'Reset buffer index' },
    w = { '<cmd>Gitsigns toggle_word_diff<cr>', 'Word diff' },
    y = 'Link',
    -- y = { 'Link', mode = { 'n', 'v' } },
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
    [' '] = {
      name = '+telescope',
      d = { '<cmd>Telescope lsp_definitions<cr>', 'Def' },
      i = { '<cmd>Telescope lsp_implementations<cr>', 'Impl' },
      r = { '<cmd>Telescope lsp_references<cr>', 'Ref' },
      s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document symbols' },
      S = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Workspace symbols' },
    },
    ['['] = { vim.lsp.buf.incoming_calls, 'Incoming calls' },
    [']'] = { vim.lsp.buf.outgoing_calls, 'Outgoing calls' },
    --
    e = { '<cmd>Telescope diagnostics bufnr=0<cr>', 'Diagnostics' },
    E = { '<cmd>Telescope diagnostics<cr>', 'Diagnostics(All)' },
    --
    ['<C-q>'] = { vim.diagnostic.setqflist, 'Diagnostics quickfix' },
    ['<C-a>'] = { vim.diagnostic.setloclist, 'Diagnostics locList' },
    --
    a = { vim.lsp.buf.code_action, 'Code action' },
    A = { vim.lsp.buf.range_code_action, 'Range action' },
    c = { '<cmd>CodeActionMenu<cr>', 'Code action' },
    d = { vim.lsp.buf.type_definition, 'Goto type definition' },
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
    o = { '<cmd>SymbolsOutline<cr>', 'Outline' },
    -- p = {
    --   name = '+peek',
    --   d = { "<cmd>lua require('young.lsp.misc').Peek('definition')<cr>", 'Definition' },
    --   i = { "<cmd>lua require('young.lsp.misc').Peek('implementation')<cr>", 'Implementation' },
    --   t = { "<cmd>lua require('young.lsp.misc').Peek('typeDefinition')<cr>", 'Type definition' },
    -- },
    r = { vim.lsp.buf.rename, 'Rename' },
    t = {
      function()
        require('young.mod.lsp_lines').toggle()
      end,
      'Toggle LSP lines',
    },
    v = { '<cmd>Vista!!<cr>', 'Vista' },
    w = {
      w = { '<cmd>lua pp(vim.lsp.buf.list_workspace_folders())<cr>', 'Workspace folders' },
      a = { '<cmd>lua pp(vim.lsp.buf.add_workspace_folder())<cr>', 'Add folder' },
      r = { '<cmd>lua pp(vim.lsp.buf.remove_workspace_folder())<cr>', 'Remove folder' },
    },
    --
    i = { '<cmd>LspInfo<cr>', 'Info' },
    m = { '<cmd>Mason<cr>', 'Mason' },
    n = { '<cmd>NullLsInfo<cr>', 'Null LS' },
    N = { '<cmd>Copilot status<cr>', 'Copilot status' },
    C = { '<cmd>CmpStatus<cr>', 'Cmp status' },
  },
  L = {
    name = '+lua',
    C = { '<cmd>LuaCacheClear<cr>', 'LuaCache clear' },
    L = { '<cmd>LuaCacheLog<cr>', 'LuaCache log' },
    P = { '<cmd>LuaCacheProfile<cr>', 'LuaCache profile' },
    l = {
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
    ['"'] = { '<cmd>Telescope registers<cr>', 'Registers' },
    ["'"] = { '<cmd>Telescope marks<cr>', 'Marks' },
    ['.'] = { '<cmd>Telescope file_browser hidden=v:true<cr>', 'Browser' },
    ['/'] = { '<cmd>Telescope search_history<cr>', 'Search history' },
    [':'] = { '<cmd>Telescope command_history<cr>', 'Command history' },
    ['<C-q>'] = { '<cmd>Telescope quickfix<cr>', 'QuickList' },
    ['<C-a>'] = { '<cmd>Telescope loclist<cr>', 'LocList' },
    ['<tab>'] = { '<cmd>Telescope<cr>', '' },
    ['?'] = { '<cmd>Telescope help_tags<cr>', 'Help' },
    B = { '<cmd>Telescope bookmarks<cr>', 'Bookmarks' },
    C = { '<cmd>Telescope commands<cr>', 'Commands' },
    G = { '<cmd>Telescope live_grep grep_open_files=v:true<cr>', 'Grep in opened buffer' },
    H = { '<cmd>Telescope highlights<cr>', 'Highlights' },
    M = { '<cmd>Telescope man_pages<cr>', 'Man pages' },
    P = { '<cmd>Telescope pickers<cr>', '<Pickers>' },
    R = { '<cmd>Telescope reloader<cr>', 'Reload module' },
    S = { '<cmd>Telescope spell_suggest<cr>', 'Spell' },
    T = { '<cmd>Telescope grep_string<cr>', 'Text under cursor' },
    a = { '<cmd>Telescope autocommands<cr>', 'Autocommands' },
    b = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Buffer string' },
    c = { "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", 'Colorscheme' },
    e = { '<cmd>Telescope env<cr>', 'Env' },
    f = { '<cmd>Telescope find_files<cr>', 'Find files' },
    F = { '<cmd>Telescope find_files no_ignore=1<cr>', 'Find files (more)' },
    g = { '<cmd>Telescope live_grep <cr>', 'Grep' },
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
    s = {
      name = '+symbol',
      e = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'emoji'} }<cr>", 'Emoji' },
      g = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'gitmoji'} }<cr>", 'Git' },
      j = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'julia'} }<cr>", 'Julia' },
      k = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'kaomoji'} }<cr>", 'Kaomoji' },
      l = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'latex'} }<cr>", 'LaTeX' },
      m = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'math'} }<cr>", 'Math' },
      s = { '<cmd>Telescope symbols<cr>', 'Symbols' },
    },
    t = { '<cmd>TodoTelescope<cr>', 'Todo' },
    u = { '<cmd>Telescope repo list<cr>', 'Repository' },
    v = {
      name = '+vim',
      T = { '<cmd>Telescope tags<cr>', 'All tags' },
      c = { '<cmd>Telescope commands<cr>', 'Commands' },
      f = { '<cmd>Telescope filetypes<cr>', 'FileTypes' },
      o = { '<cmd>Telescope vim_options<cr>', 'Options' },
      t = { '<cmd>Telescope current_buffer_tags<cr>', 'Tags' },
    },
    y = { '<cmd>Telescope neoclip<cr>', 'Clipboard' },
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
    m = { '<cmd>MinimapToggle<cr>', 'Minimap' },
    l = { require('young.tool').toggle_tabline, 'Tabline' },
    i = { require('young.tool').toggle_indent_style, 'Indent style' },
    n = { require('young.tool').toggle_notify_style, 'Nofity style' },
    N = { require('young.tool').toggle_notify, 'Toggle nofity' },
  },
  w = { '<cmd>w!<cr>', 'Save' },
  x = {
    name = '+trouble',
    ['.'] = { '<cmd>Trouble telescope<cr>', 'Telescope' },
    --
    e = { '<cmd>Trouble document_diagnostics<cr>', 'Diagnostics' },
    E = { '<cmd>Trouble workspace_diagnostics<cr>', 'Diagnostics(All)' },
    --
    ['<C-q>'] = { '<cmd>Trouble quickfix<cr>', 'QuickFix' },
    ['<C-a>'] = { '<cmd>Trouble loclist<cr>', 'LocList' },
    --
    x = { '<cmd>TroubleToggle<cr>', 'Open' },
    t = { '<cmd>TodoTrouble<cr>', 'Todo' },
    d = { '<cmd>Trouble lsp_definitions<cr>', 'Def' },
    i = { '<cmd>Trouble lsp_implementations<cr>', 'Impl' },
    r = { '<cmd>Trouble lsp_references<cr>', 'Ref' },
    D = { '<cmd>Trouble lsp_type_definitions<cr>', 'Type' },
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
    l = { ':edit ' .. require('young.cfg').get_local_config() .. '<cr>', 'Edit local config' },
    o = {
      function()
        require('young.mod.telescope.finder').open_changed_vim_config()
      end,
      'Open changed Config files',
    },
    r = { require('young.cfg').reload, 'Reload configuration' },
    y = { ':edit ' .. require('young.cfg').get_reload_path() .. '<cr>', 'Edit plugins' },
    -- y = { "<cmd>lua vim.fn.execute('edit ' .. require('young.cfg').get_reload_path())<cr>", 'Edit plugins' },
  },
  z = { '<cmd>ZenMode<cr>', 'Zen' },
}

return mappings
