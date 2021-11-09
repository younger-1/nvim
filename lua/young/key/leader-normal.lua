local mappings = {
  ['/'] = { "<cmd>lua require('Comment').toggle()<CR>", 'Comment' },
  [';'] = { '<cmd>Dashboard<CR>', 'Dashboard' },
  ['?'] = {
    [' '] = { ':h api<CR>', 'Api' },
    ['?'] = { ':h reference_toc<CR>', '❓' },
    A = { ':h vim-additions<CR>', 'Vim Additions' },
    E = { ':h ex-edit-index<CR>', 'Ex-edit Index' },
    F = { ':h function-list<CR>', 'Function List' },
    H = { ':h help-summary<CR>', 'Help' },
    I = { ':h insert-index<CR>', 'Insert Index' },
    L = { ':h lsp<CR>', 'LSP' },
    M = { ':h map-modes<CR>', 'Map Modes' },
    N = { ':h notation<CR>', 'Notation' },
    O = { ':h option-list<CR>', 'Option List' },
    T = { ':h tips<CR>', 'Tips' },
    a = { ':h vim-arguments<CR>', 'Vim Arguments' },
    d = { ':h nvim-defaults<CR>', 'Defaults' },
    e = { ':exu<CR>', 'Ex-cmd Index' },
    f = { ':h vim-function<CR>', 'Functions' },
    g = { ':h g<CR>', 'g Index' },
    h = { ':h help-tags<CR>', 'Help tags' },
    i = { ':h index<CR>', 'Index' },
    k = { ':h key-codes<CR>', 'Key Codes' },
    l = { ':h lua<CR>', 'Lua' },
    m = { ':h vim-modes<CR>', 'Modes' },
    n = { ':viu<CR>', 'Normal Index' },
    name = '+Vim',
    o = { ':options<CR>', 'Options' },
    p = { ':h local-additions<CR>', 'Plugin' },
    q = { ':h quickref<CR>', 'Quick Reference' },
    s = { ':h startup<CR>', 'Startup' },
    t = { ':h objects<CR>', 'Text objects' },
    u = { ':h user-manual<CR>', 'User Manual' },
    v = { ':h vim-variable<CR>', 'Vim Variable' },
    w = { ':h ctrl-w<CR>', 'Windows Index' },
    x = { ':h visual-index<CR>', 'Visual Index' },
    y = { ':h [<CR>', '[ ] Index' },
    z = { ':h z<CR>', 'z Index' },
  },
  C = { ':call OpenLastClosed()<CR>', 'which_key_ignore' },
  L = {
    C = { '<cmd>LuaCacheClear<cr>', 'LuaCache Clear' },
    I = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>",
      "View LunarVim's changelog",
    },
    L = { '<cmd>LuaCacheLog<cr>', 'LuaCache Log' },
    P = { '<cmd>LuaCacheProfile<cr>', 'LuaCache Profile' },
    R = { '<cmd>LvimCacheReset<cr>', 'LvimCache Reset' },
    b = {
      "<cmd>lua require('telescope.builtin').git_commits { cwd = _G.get_runtime_dir() .. '/lvim' }<cr>",
      'LunarVim Git Branch',
    },
    c = { '<cmd>edit /home/young/.config/lvim/config.lua<cr>', 'Edit config.lua' },
    f = { "<cmd>lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>", 'Find LunarVim files' },
    g = { "<cmd>lua require('lvim.core.telescope.custom-finders').grep_lunarvim_files()<cr>", 'Grep LunarVim files' },
    i = { "<cmd>lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>", 'Toggle LunarVim Info' },
    k = { "<cmd>lua require('lvim.keymappings').print()<cr>", "View LunarVim's default keymappings" },
    l = {
      D = {
        "<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>",
        'Open the default logfile',
      },
      L = { "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", 'Open the LSP logfile' },
      N = { '<cmd>edit $NVIM_LOG_FILE<cr>', 'Open the Neovim logfile' },
      P = { "<cmd>exe 'edit '.stdpath('cache').'/packer.nvim.log'<cr>", 'Open the Packer logfile' },
      d = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>",
        'view default log',
      },
      l = { "<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>", 'view lsp log' },
      n = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>",
        'view neovim log',
      },
      name = '+logs',
      p = { "<cmd>lua require('lvim.core.terminal').toggle_log_view('packer.nvim')<cr>", 'view packer log' },
    },
    name = '+LunarVim',
    r = { '<cmd>LvimReload<cr>', "Reload LunarVim's configuration" },
    u = { '<cmd>LvimUpdate<cr>', 'Update LunarVim' },
  },
  Q = { ':tabclose<CR>', 'which_key_ignore' },
  T = {
    I = { ':TSModuleInfo<CR>', 'Telescope' },
    T = { '<cmd>TSHighlightCapturesUnderCursor<cr>', 'Highlight' },
    h = { ':TSBufToggle highlight<CR>', 'Toggle Highlight(Buffer)' },
    i = { ':TSConfigInfo<cr>', 'Info' },
    name = '+Treesitter',
    p = { ':TSPlaygroundToggle<cr>', 'Playground' },
    r = { ':TSBufToggle rainbow<CR>', 'Toggle Rainbow' },
    t = { '<cmd>Telescope treesitter<CR>', 'Telescope' },
  },
  b = {
    B = { '<cmd>BufferOrderByBufferNumber<cr>', 'Sort by BufferNumber' },
    D = { '<cmd>BufferOrderByDirectory<cr>', 'Sort by directory' },
    L = { '<cmd>BufferOrderByLanguage<cr>', 'Sort by language' },
    T = { ':TablineCustom ', 'Tabline+' },
    W = { '<cmd>BufferOrderByWindowNumber<cr>', 'Sort by WindowNumber' },
    a = { ':TablineToggleShowAllBuffers<cr>', 'Tabline Toggle All' },
    b = { '<cmd>b#<cr>', 'Previous' },
    d = { ':TablineBuffersBind ', 'Tabline Bound' },
    e = { '<cmd>BufferCloseAllButCurrent<cr>', 'Close all but current' },
    f = { '<cmd>Telescope buffers<cr>', 'Find' },
    h = { '<cmd>BufferCloseBuffersLeft<cr>', 'Close all to the left' },
    j = { '<cmd>BufferPick<cr>', 'Jump' },
    l = { '<cmd>BufferLast<cr>', 'Last' },
    name = '+Buffers',
    p = { '<cmd>BufferPin<cr>', 'Pin' },
    r = { ':TablineTabRename ', 'Tabline Rename' },
    t = { ':TablineTabNew ', 'Tabline New' },
    u = { ':TablineBuffersClearBind<cr>', 'Tabline Unbound' },
    w = { '<cmd>BufferWipeout<cr>', 'Wipeout' },
  },
  c = { '<cmd>BufferClose!<CR>', 'Close Buffer' },
  d = {
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", 'Run To Cursor' },
    b = { "<cmd>lua require'dap'.step_back()<cr>", 'Step Back' },
    c = { "<cmd>lua require'dap'.continue()<cr>", 'Continue' },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", 'Disconnect' },
    g = { "<cmd>lua require'dap'.session()<cr>", 'Get Session' },
    i = { "<cmd>lua require'dap'.step_into()<cr>", 'Step Into' },
    name = '+Debug',
    o = { "<cmd>lua require'dap'.step_over()<cr>", 'Step Over' },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", 'Pause' },
    q = { "<cmd>lua require'dap'.close()<cr>", 'Quit' },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", 'Toggle Repl' },
    s = { "<cmd>lua require'dap'.continue()<cr>", 'Start' },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", 'Toggle Breakpoint' },
    u = { "<cmd>lua require'dap'.step_out()<cr>", 'Step Out' },
  },
  e = { '<cmd>NvimTreeToggle<CR>', 'Explorer' },
  f = { "<cmd>lua require('lir.float').toggle()<cr>", 'Files' },
  g = {
    [' '] = {
      a = { '<cmd>Gist -b -a<cr>', 'Create Anon' },
      d = { '<cmd>Gist -d<cr>', 'Delete' },
      f = { '<cmd>Gist -f<cr>', 'Fork' },
      g = { '<cmd>Gist -b<cr>', 'Create' },
      l = { '<cmd>Gist -l<cr>', 'List' },
      name = '+gist',
      p = { '<cmd>Gist -b -p<cr>', 'Create Private' },
    },
    ['"'] = { '<cmd>Gitsigns toggle_current_line_blame<cr>', 'Blames' },
    ["'"] = { '<cmd>Gitsigns toggle_linehl<cr>', 'Highlight' },
    ['<C-e>'] = {
      a = { "<cmd>lua require 'gitsigns'.setloclist('all')<cr>", 'All Git' },
      b = { "<cmd>lua require 'gitsigns'.setloclist('attached')<cr>", 'Buffers' },
      c = { '<cmd>Gitsigns setloclist<cr>', 'Current' },
      name = '+loclist',
    },
    ['<C-q>'] = {
      a = { "<cmd>lua require 'gitsigns'.setqflist('all')<cr>", 'All Git' },
      b = { "<cmd>lua require 'gitsigns'.setqflist('attached')<cr>", 'Buffers' },
      c = { '<cmd>Gitsigns setqflist<cr>', 'Current' },
      name = '+quickfix',
    },
    C = { '<cmd>Telescope git_bcommits<cr>', 'Checkout commit(for current file)' },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", 'Reset Buffer' },
    S = { '<cmd>Gitsigns stage_buffer<cr>', 'Stage Buffer' },
    U = { '<cmd>Gitsigns reset_buffer_index<cr>', 'Reset Buffer Index' },
    Y = { "<cmd>lua require'gitlinker'.get_repo_url()<cr>", 'Link(Repo)' },
    a = { '<cmd>Telescope git_stash<CR>', 'Stash' },
    b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
    c = { '<cmd>Telescope git_commits<cr>', 'Checkout commit' },
    d = { '<cmd>Gitsigns diffthis HEAD<cr>', 'Git Diff' },
    f = { '<cmd>Telescope git_files<CR>', 'Files' },
    h = {
      g = { '<cmd>Telescope gh gist<cr>', 'Gist' },
      i = { '<cmd>Telescope gh issues<cr>', 'Issues' },
      name = '+github',
      p = { '<cmd>Telescope gh pull_request<cr>', 'Pull_request' },
      r = { '<cmd>Telescope gh run<cr>', 'Run' },
    },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", 'Next Hunk' },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", 'Prev Hunk' },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", 'Blame' },
    n = {
      c = { "<cmd>lua require('neogit').open({ 'commit' })<cr>", 'Commit' },
      n = { '<cmd>Neogit<cr>', '♐' },
      name = '+neogit',
      s = { "<cmd>lua require('neogit').open({ kind = 'split' })<cr>", 'Commit' },
      v = { "<cmd>lua require('neogit').open({ kind = 'vsplit' })<cr>", 'Commit' },
    },
    name = '+Git',
    o = { '<cmd>Telescope git_status<cr>', 'Open changed file' },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", 'Preview Hunk' },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", 'Reset Hunk' },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", 'Stage Hunk' },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", 'Undo Stage Hunk' },
    y = 'Link',
  },
  gg = 'LazyGit',
  h = { ':nohlsearch<CR>', 'which_key_ignore' },
  j = {
    name = '+justify',
  },
  k = {
    name = '+kit',
  },
  l = {
    [' '] = {
      d = { '<cmd>Telescope lsp_definitions<cr>', 'Def' },
      i = { '<cmd>Telescope lsp_implementations<cr>', 'Impl' },
      name = '+Telescope',
      r = { '<cmd>Telescope lsp_references<cr>', 'Ref' },
    },
    ['<C-e>'] = { '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', 'Diagnostics LocList' },
    A = { '<cmd>Telescope lsp_range_code_actions<cr>', 'Range Action' },
    F = {
      function()
        vim.lsp.buf.formatting_sync()
        vim.cmd 'write'
      end,
      'Format & Save',
    },
    I = { '<cmd>LspInstallInfo<cr>', 'Installer Info' },
    S = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Workspace Symbols' },
    W = { '<cmd>lua pp(vim.lsp.buf.list_workspace_folders())<cr>', 'Workspace folders' },
    ['['] = { '<Cmd>lua vim.lsp.buf.incoming_calls()<CR>', 'Incoming Calls' },
    [']'] = { '<Cmd>lua vim.lsp.buf.outgoing_calls()<CR>', 'Outgoing Calls' },
    a = { '<cmd>Telescope lsp_code_actions<cr>', 'Code Action' },
    c = { '<cmd>CodeActionMenu<cr>', 'Code Action' },
    d = { '<cmd>Telescope lsp_document_diagnostics<cr>', 'Document Diagnostics' },
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
    name = '+LSP',
    o = { '<cmd>SymbolsOutline<cr>', 'Outline' },
    p = {
      d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", 'Definition' },
      i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", 'Implementation' },
      name = '+Peek',
      t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", 'Type Definition' },
    },
    q = { '', 'which_key_ignore' },
    r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
    s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
    v = { '<cmd>Vista!!<cr>', 'Vista' },
    w = { '<cmd>Telescope lsp_workspace_diagnostics<cr>', 'Workspace Diagnostics' },
  },
  p = {
    C = { '<cmd>PackerCompile profile=true<cr>', 'Compile+' },
    I = { ':lua pp()<left>', 'Inspect' },
    P = { '<cmd>PackerProfile<cr>', 'Profile' },
    S = { '<cmd>PackerSync<cr>', 'Sync' },
    c = { '<cmd>PackerCompile<cr>', 'Compile' },
    i = { '<cmd>PackerInstall<cr>', 'Install' },
    name = '+Packer',
    p = {
      "<cmd>lua require('telescope').extensions.packer.plugins { layout_config = { preview_width = 0.5} }<cr>",
      'Telescope Packer',
    },
    r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", 'Re-compile' },
    s = { '<cmd>PackerStatus<cr>', 'Status' },
    u = { '<cmd>PackerUpdate<cr>', 'Update' },
  },
  q = { '<cmd>q!<CR>', 'Quit' },
  r = {
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", 'Replace Buffer' },
    name = '+replace',
    r = { "<cmd>lua require('spectre').open()<cr>", 'Replace' },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", 'Replace Word' },
  },
  s = {
    [' '] = { '<cmd>Telescope resume<CR>', '♻️' },
    ['"'] = { '<cmd>Telescope registers<CR>', 'Registers' },
    ["'"] = { '<cmd>Telescope marks<CR>', 'Marks' },
    ['.'] = { '<cmd>Telescope file_browser hidden=v:true<CR>', 'Browser' },
    ['/'] = { '<cmd>Telescope search_history<CR>', 'Search History' },
    [':'] = { '<cmd>Telescope command_history<CR>', 'Command History' },
    ['<C-e>'] = { '<cmd>Telescope loclist<CR>', 'LocList Bug' },
    ['<C-q>'] = { '<cmd>Telescope quickfix<CR>', 'QuickList' },
    ['<tab>'] = { '<cmd>Telescope<CR>', '🧙' },
    ['?'] = { '<cmd>Telescope help_tags<CR>', 'Help' },
    C = { '<cmd>Telescope commands<cr>', 'Commands' },
    G = { '<cmd>Telescope live_grep grep_open_files=v:true<cr>', 'Grep in opened buffer' },
    H = { '<cmd>Telescope highlights<cr>', 'Highlights' },
    M = { '<cmd>Telescope man_pages<cr>', 'Man Pages' },
    P = { '<cmd>Telescope pickers<CR>', '<Pickers>' },
    R = { '<cmd>Telescope reloader<CR>', 'Reload Module' },
    S = { '<cmd>Telescope spell_suggest<CR>', 'Spell' },
    T = { '<cmd>Telescope grep_string<CR>', 'Text under cursor' },
    a = { '<cmd>Telescope autocommands<CR>', 'Autocommands' },
    b = { '<cmd>Telescope current_buffer_fuzzy_find<CR>', 'Buffer String' },
    c = { "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", 'Colorscheme' },
    f = { '<cmd>Telescope find_files hidden=v:true no_ignore=v:true<cr>', 'Find files' },
    g = { '<cmd>Telescope live_grep <cr>', 'Grep' },
    h = { '<cmd>Telescope help_tags<cr>', 'Find Help' },
    j = { '<cmd>Telescope jumplist<cr>', 'Gump List' },
    k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
    m = {
      c = { "<Cmd>lua require('telescope').extensions.frecency.frecency{ default_text = ':CWD:' }<CR>", 'CWD' },
      l = { "<Cmd>lua require('telescope').extensions.frecency.frecency{ default_text = ':LSP:' }<CR>", 'LSP' },
      m = { "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", 'Frecency' },
      name = '+MRU',
    },
    n = { '<cmd>Telescope notify<cr>', 'Notify' },
    name = '+Search',
    o = {
      '<cmd>Telescope sessions layout_strategy=bottom_pane layout_config={"prompt_position":"top"}<CR>',
      'Sessions',
    },
    p = { '<cmd>Telescope projects<CR>', 'Projects' },
    r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
    s = {
      e = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'emoji'} }<CR>", 'Emoji' },
      g = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'gitmoji'} }<CR>", 'Git' },
      j = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'julia'} }<CR>", 'Julia' },
      k = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'kaomoji'} }<CR>", 'Kaomoji' },
      l = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'latex'} }<CR>", 'LaTeX' },
      m = { "<cmd>lua require'telescope.builtin'.symbols{ sources = {'math'} }<CR>", 'Math' },
      name = '+symbol',
      s = { '<cmd>Telescope symbols<CR>', 'Symbols' },
    },
    t = { '<cmd>TodoTelescope<CR>', 'Todo' },
    v = {
      T = { '<cmd>Telescope tags<CR>', 'All Tags' },
      c = { '<cmd>Telescope commands<cr>', 'Commands' },
      f = { '<cmd>Telescope filetypes<CR>', 'FileTypes' },
      name = '+vim',
      o = { '<cmd>Telescope vim_options<CR>', 'Options' },
      t = { '<cmd>Telescope current_buffer_tags<CR>', 'Tags' },
    },
    y = { '<cmd>Telescope neoclip<CR>', 'Clipboard' },
    z = { "<cmd>lua require'telescope'.extensions.zoxide.list{}<CR>", 'Z' },
  },
  t = {
    b = 'Biscuits',
    l = { ":lua require('user.tools').tabline_toggle()<cr>", 'Tabline' },
    m = { '<cmd>MinimapToggle<cr>', 'Minimap' },
    name = '+tog',
    t = { '<cmd>TodoQuickFix<cr>', 'Todo' },
  },
  w = { '<cmd>w!<CR>', 'Save' },
  x = {
    ['.'] = { '<cmd>Trouble telescope<cr>', 'Telescope' },
    ['<C-e>'] = { '<cmd>Trouble loclist<cr>', 'LocList' },
    ['<C-q>'] = { '<cmd>Trouble quickfix<cr>', 'QuickFix' },
    D = { '<cmd>Trouble lsp_definitions<cr>', 'Def' },
    I = { '<cmd>Trouble lsp_implementations<cr>', 'Impl' },
    R = { '<cmd>Trouble lsp_references<cr>', 'Ref' },
    d = { '<cmd>Trouble lsp_document_diagnostics<cr>', 'Diagnostics' },
    name = '+trouble',
    t = { '<cmd>TodoTrouble<cr>', 'Todo' },
    w = { '<cmd>Trouble lsp_workspace_diagnostics<cr>', 'Workspace Diagnostics' },
    x = { '<cmd>TroubleToggle<cr>', 'Open' },
  },
  z = { '<cmd>ZenMode<cr>', 'Zen' },
}

return mappings
