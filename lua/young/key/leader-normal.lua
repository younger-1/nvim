local mappings = {
  ['/'] = { '<cmd>Telescope find_files layout_strategy=horizontal<cr>', 'Files' },
  [';'] = { '<cmd>Alpha<cr>', 'Alpha' },
  ['?'] = {
    name = '+help',
    [' '] = { ':h api<cr>', 'Api' },
    ['?'] = { ':h reference_toc<cr>', '❓' },
    A = { ':h vim-additions<cr>', 'Vim Additions' },
    C = { ':h cterm-colors<cr>', 'Vim colors' },
    E = { ':h ex-edit-index<cr>', 'Ex-edit Index' },
    F = { ':h function-list<cr>', 'Function List' },
    H = { ':h help-summary<cr>', 'Help' },
    I = { ':h insert-index<cr>', 'Insert Index' },
    L = { ':h lsp<cr>', 'LSP' },
    M = { ':h map-modes<cr>', 'Map Modes' },
    N = { ':h notation<cr>', 'Notation' },
    O = { ':h option-list<cr>', 'Option List' },
    T = { ':h tips<cr>', 'Tips' },
    a = { ':h vim-arguments<cr>', 'Vim Arguments' },
    c = { ':h gui-colors<cr>', 'Vim colors' },
    d = { ':h nvim-defaults<cr>', 'Defaults' },
    e = { ':exu<cr>', 'Ex-cmd Index' },
    f = { ':h vim-function<cr>', 'Functions' },
    g = { ':h g<cr>', 'g Index' },
    h = { ':h help-tags<cr>', 'Help tags' },
    i = { ':h index<cr>', 'Index' },
    k = { ':h key-codes<cr>', 'Key Codes' },
    l = { ':h lua<cr>', 'Lua' },
    m = { ':h vim-modes<cr>', 'Modes' },
    n = { ':viu<cr>', 'Normal Index' },
    o = { ':options<cr>', 'Options' },
    p = { ':h local-additions<cr>', 'Plugin' },
    q = { ':h quickref<cr>', 'Quick Reference' },
    s = { ':h startup<cr>', 'Startup' },
    t = { ':h objects<cr>', 'Text objects' },
    u = { ':h user-manual<cr>', 'User Manual' },
    v = { ':h vim-variable<cr>', 'Vim Variable' },
    w = { ':h ctrl-w<cr>', 'Windows Index' },
    x = { ':h visual-index<cr>', 'Visual Index' },
    y = { ':h [<cr>', '[ ] Index' },
    z = { ':h z<cr>', 'z Index' },
  },
  C = { ':call OpenLastClosed()<cr>', 'which_key_ignore' },
  L = {
    name = '+lua',
    C = { '<cmd>LuaCacheClear<cr>', 'LuaCache Clear' },
    L = { '<cmd>LuaCacheLog<cr>', 'LuaCache Log' },
    P = { '<cmd>LuaCacheProfile<cr>', 'LuaCache Profile' },
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
    u = { '<cmd>LvimUpdate<cr>', 'Update LunarVim' },
  },
  Q = { '<cmd>tabclose<cr>', 'which_key_ignore' },
  T = {
    name = '+treesitter',
    I = { '<cmd>TSModuleInfo<cr>', 'Telescope' },
    T = { '<cmd>TSHighlightCapturesUnderCursor<cr>', 'Highlight' },
    h = { '<cmd>TSBufToggle highlight<cr>', 'Toggle Highlight(Buffer)' },
    i = { '<cmd>TSConfigInfo<cr>', 'Info' },
    p = { '<cmd>TSPlaygroundToggle<cr>', 'Playground' },
    r = { '<cmd>TSBufToggle rainbow<cr>', 'Toggle Rainbow' },
    t = { '<cmd>Telescope treesitter<cr>', 'Telescope' },
  },
  a = {
    name = '+apps',
    [' '] = { '<cmd>Telescope command_palette<cr>', 'Command Palette' },
    e = { '+external' },
    m = { '<cmd>MarkdownPreviewToggle<cr>', 'Markdown' },
    t = { '<cmd>TodoQuickFix<cr>', 'Todo' },
    s = {
      name = '+sessions',
      l = { '<cmd>lua require("persistence").load()<cr>', 'Current Session' },
      L = { '<cmd>lua require("persistence").load({ last = true })<cr>', 'Last Session' },
      s = { '<cmd>lua require("persistence").stop()<cr>', 'Stop Session' },
    },
    S = {
      name = '+session-man',
      l = { '<cmd>SessionManager load_current_dir_session<cr>', 'Current Session' },
      L = { '<cmd>SessionManager load_last_session<cr>', 'Last Session' },
      a = { '<cmd>SessionManager load_session<cr>', 'All Sessions' },
      d = { '<cmd>SessionManager delete_session<cr>', 'Delete Session' },
      S = { '<cmd>SessionManager save_current_session<cr>', 'Save Session' },
    },
  },
  b = {
    name = '+buffers',
    B = { '<cmd>BufferOrderByBufferNumber<cr>', 'Sort by BufferNumber' },
    D = { '<cmd>BufferOrderByDirectory<cr>', 'Sort by directory' },
    L = { '<cmd>BufferOrderByLanguage<cr>', 'Sort by language' },
    T = { ':TablineCustom ', 'Tabline++' },
    W = { '<cmd>BufferOrderByWindowNumber<cr>', 'Sort by WindowNumber' },
    a = { '<cmd>TablineToggleShowAllBuffers<cr>', 'Tabline Toggle All' },
    b = { '<cmd>b#<cr>', 'Previous' },
    d = { ':TablineBuffersBind ', 'Tabline Bound' },
    e = { '<cmd>BufferCloseAllButCurrent<cr>', 'Close all but current' },
    f = { '<cmd>Telescope buffers<cr>', 'Find' },
    h = { '<cmd>BufferCloseBuffersLeft<cr>', 'Close all to the left' },
    j = { '<cmd>BufferPick<cr>', 'Jump' },
    l = { '<cmd>BufferLast<cr>', 'Last' },
    o = { '<cmd>BufferCloseAllButCurrent<cr>', 'Close all but current' },
    p = { '<cmd>BufferPin<cr>', 'Pin' },
    r = { ':TablineTabRename ', 'Tabline Rename' },
    t = { ':TablineTabNew ', 'Tabline New' },
    u = { '<cmd>TablineBuffersClearBind<cr>', 'Tabline Unbound' },
    w = { '<cmd>BufferWipeout<cr>', 'Wipeout' },
  },
  c = { '<cmd>BufferClose!<cr>', 'Close Buffer' },
  d = {
    name = '+debug',
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", 'Run To Cursor' },
    b = { "<cmd>lua require'dap'.step_back()<cr>", 'Step Back' },
    c = { "<cmd>lua require'dap'.continue()<cr>", 'Continue' },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", 'Disconnect' },
    g = { "<cmd>lua require'dap'.session()<cr>", 'Get Session' },
    i = { "<cmd>lua require'dap'.step_into()<cr>", 'Step Into' },
    o = { "<cmd>lua require'dap'.step_over()<cr>", 'Step Over' },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", 'Pause' },
    q = { "<cmd>lua require'dap'.close()<cr>", 'Quit' },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", 'Toggle Repl' },
    s = { "<cmd>lua require'dap'.continue()<cr>", 'Start' },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", 'Toggle Breakpoint' },
    u = { "<cmd>lua require'dap'.step_out()<cr>", 'Step Out' },
  },
  f = { "<cmd>lua require('lir.float').toggle()<cr>", 'Files' },
  g = {
    name = '+git',
    [' '] = {
      name = '+gist',
      a = { '<cmd>Gist -b -a<cr>', 'Create Anon' },
      d = { '<cmd>Gist -d<cr>', 'Delete' },
      f = { '<cmd>Gist -f<cr>', 'Fork' },
      g = { '<cmd>Gist -b<cr>', 'Create' },
      l = { '<cmd>Gist -l<cr>', 'List' },
      p = { '<cmd>Gist -b -p<cr>', 'Create Private' },
    },
    ['"'] = { '<cmd>Gitsigns toggle_current_line_blame<cr>', 'Blames' },
    ["'"] = { '<cmd>Gitsigns toggle_linehl<cr>', 'Line Highlight' },
    ['`'] = { '<cmd>Gitsigns toggle_numhl<cr>', 'Number Highlight' },
    ['<C-e>'] = {
      name = '+loclist',
      a = { "<cmd>lua require 'gitsigns'.setloclist('all')<cr>", 'All Git' },
      b = { "<cmd>lua require 'gitsigns'.setloclist('attached')<cr>", 'Buffers' },
      c = { '<cmd>Gitsigns setloclist<cr>', 'Current' },
    },
    ['<C-q>'] = {
      name = '+quickfix',
      a = { "<cmd>lua require 'gitsigns'.setqflist('all')<cr>", 'All Git' },
      b = { "<cmd>lua require 'gitsigns'.setqflist('attached')<cr>", 'Buffers' },
      c = { '<cmd>Gitsigns setqflist<cr>', 'Current' },
    },
    a = { '<cmd>Telescope git_stash<cr>', 'Stash' },
    b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
    c = { '<cmd>Telescope git_commits<cr>', 'Checkout commit' },
    C = { '<cmd>Telescope git_bcommits<cr>', 'Checkout commit(for current file)' },
    d = { '<cmd>Gitsigns diffthis HEAD<cr>', 'Git Diff' },
    f = { '<cmd>Telescope git_files<cr>', 'Files' },
    h = {
      name = '+github',
      g = { '<cmd>Telescope gh gist<cr>', 'Gist' },
      i = { '<cmd>Telescope gh issues<cr>', 'Issues' },
      p = { '<cmd>Telescope gh pull_request<cr>', 'Pull_request' },
      r = { '<cmd>Telescope gh run<cr>', 'Run' },
    },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", 'Next Hunk' },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", 'Prev Hunk' },
    l = { "<cmd>lua require 'gitsigns'.blame_line { full=true }<cr>", 'Blame' },
    n = {
      name = '+neogit',
      c = { "<cmd>lua require('neogit').open({ 'commit' })<cr>", 'Commit' },
      n = { '<cmd>Neogit<cr>', '♐' },
      s = { "<cmd>lua require('neogit').open({ kind = 'split' })<cr>", 'Commit' },
      v = { "<cmd>lua require('neogit').open({ kind = 'vsplit' })<cr>", 'Commit' },
    },
    o = { '<cmd>Telescope git_status<cr>', 'Open changed file' },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", 'Preview Hunk' },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", 'Reset Hunk' },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", 'Reset Buffer' },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", 'Stage Hunk' },
    S = { '<cmd>Gitsigns stage_buffer<cr>', 'Stage Buffer' },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", 'Undo Stage Hunk' },
    U = { '<cmd>Gitsigns reset_buffer_index<cr>', 'Reset Buffer Index' },
    w = { '<cmd>Gitsigns toggle_word_diff<cr>', 'Word diff' },
    y = 'Link',
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
    },
    ['<C-e>'] = { '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', 'Diagnostics LocList' },
    A = { '<cmd>Telescope lsp_range_code_actions<cr>', 'Range Action' },
    C = { '<cmd>CmpStatus<cr>', 'Cmp Status' },
    D = { '<cmd>Telescope diagnostics<cr>', 'Workspace Diagnostics' },
    F = {
      function()
        vim.lsp.buf.formatting_sync()
        vim.cmd 'write'
      end,
      'Format & Save',
    },
    I = { '<cmd>LspInstallInfo<cr>', 'Installer Info' },
    S = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Workspace Symbols' },
    ['['] = { '<cmd>lua vim.lsp.buf.incoming_calls()<cr>', 'Incoming Calls' },
    [']'] = { '<cmd>lua vim.lsp.buf.outgoing_calls()<cr>', 'Outgoing Calls' },
    a = { '<cmd>Telescope lsp_code_actions<cr>', 'Code Action' },
    c = { '<cmd>CodeActionMenu<cr>', 'Code Action' },
    d = { '<cmd>Telescope diagnostics bufnr=0<cr>', 'Document Diagnostics' },
    f = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format' },
    i = { '<cmd>LspInfo<cr>', 'Info' },
    j = {
      '<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>',
      'Next Diagnostic',
    },
    k = {
      '<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>',
      'Prev Diagnostic',
    },
    l = { '<cmd>lua vim.lsp.codelens.run()<cr>', 'CodeLens Action' },
    n = { '<cmd>NullLsInfo<cr>', 'Null LS' },
    o = { '<cmd>SymbolsOutline<cr>', 'Outline' },
    p = {
      name = '+peek',
      d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", 'Definition' },
      i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", 'Implementation' },
      t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", 'Type Definition' },
    },
    q = { '', 'which_key_ignore' },
    r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
    s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
    v = { '<cmd>Vista!!<cr>', 'Vista' },
    w = {
      w = { '<cmd>lua pp(vim.lsp.buf.list_workspace_folders())<cr>', 'Workspace folders' },
      a = { '<cmd>lua pp(vim.lsp.buf.add_workspace_folder())<cr>', 'Add folder' },
      r = { '<cmd>lua pp(vim.lsp.buf.remove_workspace_folder())<cr>', 'Remove folder' },
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
    r = { "<cmd>lua require('young.plugin-loader').recompile()<cr>", 'Re-compile' },
    s = { '<cmd>PackerStatus<cr>', 'Status' },
    u = { '<cmd>PackerUpdate<cr>', 'Update' },
  },
  q = { '<cmd>q!<cr>', 'Quit' },
  r = {
    name = '+replace',
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", 'Replace Buffer' },
    r = { "<cmd>lua require('spectre').open()<cr>", 'Replace' },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", 'Replace Word' },
  },
  s = {
    name = '+search',
    [' '] = { '<cmd>Telescope resume<cr>', '' },
    ['"'] = { '<cmd>Telescope registers<cr>', 'Registers' },
    ["'"] = { '<cmd>Telescope marks<cr>', 'Marks' },
    ['.'] = { '<cmd>Telescope file_browser hidden=v:true<cr>', 'Browser' },
    ['/'] = { '<cmd>Telescope search_history<cr>', 'Search History' },
    [':'] = { '<cmd>Telescope command_history<cr>', 'Command History' },
    ['<C-e>'] = { '<cmd>Telescope loclist<cr>', 'LocList Bug' },
    ['<C-q>'] = { '<cmd>Telescope quickfix<cr>', 'QuickList' },
    ['<tab>'] = { '<cmd>Telescope<cr>', '' },
    ['?'] = { '<cmd>Telescope help_tags<cr>', 'Help' },
    B = { '<cmd>Telescope bookmarks<cr>', 'Bookmarks' },
    C = { '<cmd>Telescope commands<cr>', 'Commands' },
    G = { '<cmd>Telescope live_grep grep_open_files=v:true<cr>', 'Grep in opened buffer' },
    H = { '<cmd>Telescope highlights<cr>', 'Highlights' },
    M = { '<cmd>Telescope man_pages<cr>', 'Man Pages' },
    P = { '<cmd>Telescope pickers<cr>', '<Pickers>' },
    R = { '<cmd>Telescope reloader<cr>', 'Reload Module' },
    S = { '<cmd>Telescope spell_suggest<cr>', 'Spell' },
    T = { '<cmd>Telescope grep_string<cr>', 'Text under cursor' },
    a = { '<cmd>Telescope autocommands<cr>', 'Autocommands' },
    b = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Buffer String' },
    c = { "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", 'Colorscheme' },
    e = { '<cmd>Telescope env<cr>', 'Env' },
    f = { '<cmd>Telescope find_files<cr>', 'Find files' },
    F = { '<cmd>Telescope find_files no_ignore=1<cr>', 'Find files (more)' },
    g = { '<cmd>Telescope live_grep <cr>', 'Grep' },
    h = { '<cmd>Telescope help_tags<cr>', 'Find Help' },
    j = { '<cmd>Telescope jumplist<cr>', 'Gump List' },
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
    r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
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
      T = { '<cmd>Telescope tags<cr>', 'All Tags' },
      c = { '<cmd>Telescope commands<cr>', 'Commands' },
      f = { '<cmd>Telescope filetypes<cr>', 'FileTypes' },
      o = { '<cmd>Telescope vim_options<cr>', 'Options' },
      t = { '<cmd>Telescope current_buffer_tags<cr>', 'Tags' },
    },
    y = { '<cmd>Telescope neoclip<cr>', 'Clipboard' },
    z = { "<cmd>lua require'telescope'.extensions.zoxide.list{}<cr>", 'Z' },
  },
  t = {
    name = '+toggle',
    [':'] = { ':call wilder#toggle()<cr>', 'Wilder' },
    a = {
      name = '+autocmd',
      f = { '<cmd>lua require("young.autocmd").toggle_format_on_save()<cr>', 'Format On Save' },
      p = { '<cmd>lua require("young.autocmd").toggle_print_ascii()<cr>', 'Print ASCII' },
      r = { '<cmd>lua require("young.autocmd").toggle_auto_chdir()<cr>', 'Auto Chdir' },
    },
    b = 'Biscuits',
    l = { "<cmd>lua require('user.tools').toggle_tabline()<cr>", 'Tabline' },
    m = { '<cmd>MinimapToggle<cr>', 'Minimap' },
    i = { '<cmd>lua require("young.mod.indent-blankline").hot()<cr>', 'Indent Style' },
    n = { '<cmd>lua require("young.mod.notify").hot()<cr>', 'Nofity Style' },
    N = { '<cmd>lua require("young.mod.notify").toggle()<cr>', 'Toggle Nofity' },
  },
  w = { '<cmd>w!<cr>', 'Save' },
  x = {
    name = '+trouble',
    ['.'] = { '<cmd>Trouble telescope<cr>', 'Telescope' },
    ['<C-e>'] = { '<cmd>Trouble loclist<cr>', 'LocList' },
    ['<C-q>'] = { '<cmd>Trouble quickfix<cr>', 'QuickFix' },
    D = { '<cmd>Trouble lsp_definitions<cr>', 'Def' },
    I = { '<cmd>Trouble lsp_implementations<cr>', 'Impl' },
    R = { '<cmd>Trouble lsp_references<cr>', 'Ref' },
    d = { '<cmd>Trouble lsp_document_diagnostics<cr>', 'Diagnostics' },
    t = { '<cmd>TodoTrouble<cr>', 'Todo' },
    w = { '<cmd>Trouble lsp_workspace_diagnostics<cr>', 'Workspace Diagnostics' },
    x = { '<cmd>TroubleToggle<cr>', 'Open' },
  },
  y = {
    name = '+young',
    b = {
      "<cmd>lua require('telescope.builtin').git_commits { cwd = _G.get_runtime_dir() .. '/lvim' }<cr>",
      'LunarVim Git Branch',
    },
    c = { ':edit ' .. join_paths(vim.fn.stdpath 'config', 'init.lua') .. '<cr>', 'Edit init.lua' },
    f = { "<cmd>lua require('young.mod.telescope.finder').find_vim_config()<cr>", 'Find Config files' },
    g = { "<cmd>lua require('young.mod.telescope.finder').grep_vim_config()<cr>", 'Grep Config files' },
    -- i = { "<cmd>lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>", 'Toggle LunarVim Info' },
    -- I = {
    --   "<cmd>lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>",
    --   "View LunarVim's changelog",
    -- },
    -- k = { "<cmd>lua require('lvim.keymappings').print()<cr>", "View LunarVim's default keymappings" },
    r = { "<cmd>lua require('young.cfg').reload()<cr>", 'Reload configuration' },
    y = { ':edit ' .. require('young.cfg').get_reload_path() .. '<cr>', 'Edit plugins' },
  },
  z = { '<cmd>ZenMode<cr>', 'Zen' },
}

return mappings
