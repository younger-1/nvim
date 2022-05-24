local M = {}
local mods = {}

setmetatable(mods, {
  __index = function(t, k)
    error(k .. ' is not a valid module section!')
  end,
})

mods.basic = {
  -- { 'wbthomason/packer.nvim' },
  { 'younger-1/packer.nvim', branch = 'mydev' },
  { 'lewis6991/impatient.nvim' },
  { 'antoinemadec/FixCursorHold.nvim' }, -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  -- {
  --   'nathom/filetype.nvim',
  --   -- opt = true,
  --   setup = function() end,
  --   config = [[
  --     require('young.mod.filetype').done()
  --   ]],
  -- },
}

mods.theme = {
  -- { 'rktjmp/lush.nvim' },

  vim = {
    -- 'joshdick/onedark.vim',
    'sainnhe/sonokai',
    'sainnhe/edge',
    'sainnhe/everforest',
    'sainnhe/gruvbox-material',
  },

  lua = {
    {
      'shaunsingh/nord.nvim',
      setup = [[
        vim.g.nord_borders = true
      ]],
    },
    'tanvirtin/monokai.nvim',
    'rebelot/kanagawa.nvim',
    'ellisonleao/gruvbox.nvim',
    'projekt0n/github-nvim-theme',
    'mvpopuk/inspired-github.vim',
    'EdenEast/nightfox.nvim',
    'Mofiqul/dracula.nvim',
    {
      'marko-cerovac/material.nvim',
      setup = [[
        vim.g.material_style = 'palenight'
      ]],
    },
    'rmehri01/onenord.nvim',
    'daschw/leaf.nvim',
    'Mofiqul/vscode.nvim',
  },
}

mods.appearance = {
  icon = {
    { 'kyazdani42/nvim-web-devicons' },
  },
  color = {
    {
      'norcalli/nvim-colorizer.lua',
      event = 'BufRead',
      config = [[
        require 'young.mod.colorizer'
      ]],
    },
  },
  indent = {
    {
      'lukas-reineke/indent-blankline.nvim',
      event = 'BufRead',
      config = [[
        require('young.mod.indent-blankline').done()
      ]],
    },
  },
  line = {
    {
      'RRethy/vim-illuminate',
      disable = require('young.lsp.config').document_highlight,
      -- opt = true,
      event = 'BufWinEnter',
      config = [[require 'young.mod.illuminate']],
    },
    {
      'edluffy/specs.nvim',
      event = 'BufRead',
      config = [[
        require('young.mod.specs').done()
      ]],
    },
  },
}

mods.edit = {
  motion = {
    {
      'haya14busa/vim-asterisk',
      config = [[
        require 'young.mod.asterisk'
      ]],
    },
    {
      'chaoren/vim-wordmotion',
      event = 'CursorMoved',
      setup = [[
        vim.g.wordmotion_prefix = ';'
      ]],
    },
    {
      'ggandor/lightspeed.nvim',
      event = 'BufWinEnter',
      config = [[
        require 'young.mod.lightspeed'
      ]],
    },
    {
      'andymass/vim-matchup',
      event = 'CursorMoved',
      config = [[
        require 'young.mod.matchup'
      ]],
    },
    -- {
    --   'abecodes/tabout.nvim',
    --   config = [[
    --     require('tabout').setup()
    --   ]],
    -- },
    -- {
    --   'karb94/neoscroll.nvim',
    --   event = 'BufWinEnter',
    --   config = [[
    --     require 'young.mod.neoscroll'
    --   ]],
    -- },
    { -- Smooth scrolling for ANY movement command
      'declancm/cinnamon.nvim',
      event = 'BufWinEnter',
      config = [[
        require 'young.mod.cinnamon'
      ]],
    },
  },
  -- textobject = {
  -- },
  treesitter = {
    {
      'nvim-treesitter/nvim-treesitter',
      branch = vim.fn.has 'nvim-0.6' == 1 and 'master' or '0.5-compat',
      run = ':TSUpdate',
      config = [[
        require('young.mod.treesitter').done()
      ]],
    },
    { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
    { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' },
    { 'nvim-treesitter/playground', after = 'nvim-treesitter' },
  },
}

mods.change = {
  core = {
    { 'tpope/vim-surround' },
    { 'tpope/vim-repeat' },
    { 'tpope/vim-abolish' },
  },
  pair = {
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = [[
        require 'young.mod.autopairs'
      ]],
    },
  },
  comment = {
    {
      'numToStr/Comment.nvim',
      event = 'BufRead',
      config = [[
        require 'young.mod.comment'
      ]],
    },
  },
  other = {
    {
      'arthurxavierx/vim-caser',
      setup = [[
        vim.g.caser_prefix = ';c'
      ]],
    },
    {
      'junegunn/vim-easy-align',
      cmd = { 'EasyAlign', 'LiveEasyAlign' },
      keys = { '<Plug>(EasyAlign)', '<Plug>(LiveEasyAlign)' },
      setup = [[
        require 'young.mod.easy-align'
      ]],
    },
    {
      'mg979/vim-visual-multi',
      cmd = { 'VMDebug', 'VMLive', 'VMRegisters', 'VMSearch' },
      setup = [[
        vim.g.VM_default_mappings = 0
      ]],
    },
    {
      'monaqa/dial.nvim',
      event = 'BufRead',
      -- FIXME:
      commit = '3b70b2a',
      config = [[
        require('young.mod.dial').done()
      ]],
    },
  },
}

mods.neovim = {
  profile = {
    {
      'dstein64/vim-startuptime',
      cmd = 'StartupTime',
      setup = [[
        vim.g.startuptime_use_blocks = 0
      ]],
    },
  },
  { 'gpanders/editorconfig.nvim' },
  {
    'nacro90/numb.nvim',
    event = 'CmdlineEnter',
    config = [[
      require('numb').setup()
    ]],
  },
  {
    'winston0410/range-highlight.nvim',
    event = 'CmdlineEnter',
    requires = { { 'winston0410/cmd-parser.nvim', module = 'cmd-parser' } },
    config = [[
      require('range-highlight').setup {}
    ]],
  },
  {
    'lambdalisue/suda.vim',
    config = [[
      vim.g['suda#prompt'] = '🔑: '
    ]],
  },
  -- {
  --   'jdhao/better-escape.vim',
  --   event = 'InsertEnter',
  --   setup = [[
  --     vim.g.better_escape_shortcut = 'jk'
  --   ]],
  -- }
  {
    'TheBlob42/houdini.nvim',
    config = [[
      require('houdini').setup()
    ]],
  },
}

mods.BWT = {
  window = {
    {
      'luukvbaal/stabilize.nvim',
      config = [[
        require('stabilize').setup {}
      ]],
    },
    { 'dhruvasagar/vim-zoom' },
    {
      'mrjones2014/smart-splits.nvim',
      disable = not vim.fn.has 'nvim-0.7',
      event = 'CursorMoved',
      -- module = 'smart-splits',
      config = [[
        require 'young.mod.smart-splits'
      ]],
    },
    {
      's1n7ax/nvim-window-picker',
      event = 'CursorMoved',
      -- module = 'window-picker',
      config = [[
        require 'young.mod.window-picker'
      ]],
    },
  },
  -- tab = {},
  quickfix = {
    {
      'kevinhwang91/nvim-bqf',
      -- event = "BufRead",
      ft = 'qf',
      -- lua pp((require('bqf.config'))
      config = [[
        require('young.mod.bqf').done()
      ]],
    },
  },
}

mods.file = {
  project = {
    {
      -- 'ahmedkhalf/project.nvim',
      'younger-1/project.nvim',
      branch = 'add-patterns-fallback',
      config = [[
        require 'young.mod.project'
      ]],
    },
  },
  session = {
    {
      'folke/persistence.nvim',
      event = 'BufRead',
      module = 'persistence',
      config = [[
        require 'young.mod.persistence'
      ]],
    },
  },
  dir = {
    {
      'tamago324/lir.nvim',
      config = [[
        require 'young.mod.lir'
      ]],
    },
    {
      'ZSaberLv0/ZFVimDirDiff',
      cmd = { 'ZFDirDiff', 'ZFDirDiffMark' },
      setup = [[
        vim.g.ZFDirDiffUI_dirExpandable = '+'
      ]],
    },
  },
}

mods.find = {
  core = {
    {
      'windwp/nvim-spectre',
      event = 'BufRead',
      config = [[
        -- require("user.spectre").config()
      ]],
    },
    {
      'VonHeikemen/searchbox.nvim',
      requires = { { 'MunifTanjim/nui.nvim' } },
      -- module = 'searchbox',
      event = 'BufRead',
      config = [[
        require 'young.mod.searchbox'
      ]],
    },
  },
  fzf = {
    {
      'ibhagwan/fzf-lua',
      module = 'fzf-lua',
      config = [[
        require 'young.mod.fzf'
      ]],
      disable = is_windows,
    },
  },
}

mods.telescope = {
  core = {
    {
      'nvim-telescope/telescope.nvim',
      requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
      config = [[
        require('young.mod.telescope').done()
      ]],
    },
    {
      'natecraddock/telescope-zf-native.nvim',
      config = [[
        require('telescope').load_extension 'zf-native'
      ]],
    },
    {
      'nvim-telescope/telescope-file-browser.nvim',
      config = [[
        require('telescope').load_extension 'file_browser'
      ]],
    },
    { 'nvim-telescope/telescope-symbols.nvim' },
  },
  other = {
    {
      'nvim-telescope/telescope-packer.nvim',
      config = [[
        require('telescope').load_extension 'packer'
      ]],
    },
    {
      'jvgrootveld/telescope-zoxide',
      config = [[
        require('telescope').load_extension 'zoxide'
        require('telescope._extensions.zoxide.config').setup {
          prompt_title = '[ Z⏫ ]',
        }
      ]],
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      requires = { { 'tami5/sqlite.lua', module = 'sqlite' } },
    },
    {
      'AckslD/nvim-neoclip.lua',
      requires = { { 'tami5/sqlite.lua', module = 'sqlite' } },
      config = [[
        require 'young.mod.neoclip'
      ]],
    },
    {
      'dhruvmanila/telescope-bookmarks.nvim',
      requires = { { 'tami5/sqlite.lua', module = 'sqlite' } },
      config = [[
        require('telescope').load_extension 'bookmarks'
      ]],
    },
    {
      'LinArcX/telescope-env.nvim',
      config = [[
        require('telescope').load_extension 'env'
      ]],
    },
    {
      'LinArcX/telescope-command-palette.nvim',
      config = [[
        require('telescope').load_extension 'command_palette'
      ]],
    },
    {
      'cljoly/telescope-repo.nvim',
      config = [[
        require('telescope').load_extension 'repo'
      ]],
    },
  },
}

mods.git = {
  {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    event = 'BufRead',
    config = [[
      require('young.mod.gitsigns').done()
    ]],
  },
  {
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    module = 'neogit',
    config = [[
      require('neogit').setup {}
    ]],
  },
  {
    'tpope/vim-fugitive',
  },
  -- {
  --   'tanvirtin/vgit.nvim',
  --   event = 'BufWinEnter',
  --   config = [[
  --       require('vgit').setup()
  --   ]],
  --   disable = is_windows,
  -- },
  {
    'nvim-telescope/telescope-github.nvim',
    config = [[
      require('telescope').load_extension 'gh'
    ]],
  },
  {
    'ruifm/gitlinker.nvim',
    event = 'BufRead',
    config = [[
      require('young.mod.gitlinker').done()
    ]],
  },
  {
    'akinsho/git-conflict.nvim',
    config = [[require('young.mod.git-conflict')]],
  },
}

mods.UI = {
  core = {
    {
      'kyazdani42/nvim-tree.lua',
      event = 'BufWinEnter',
      config = [[
        require('young.mod.nvim-tree').done()
      ]],
    },
    {
      'rcarriga/nvim-notify',
      -- event = 'BufWinEnter',
      after = 'telescope.nvim',
      config = [[
        require('young.mod.notify').done()
      ]],
    },
    {
      'folke/which-key.nvim',
      event = 'BufWinEnter',
      config = [[
        require('young.key.which-key').done()
      ]],
    },
    {
      'folke/trouble.nvim',
      event = 'BufRead',
      config = [[
        require('young.mod.trouble').done()
      ]],
    },
    { 'stevearc/dressing.nvim' },
    -- {
    --   'nvim-telescope/telescope-ui-select.nvim',
    --   config = [[
    --     require("telescope").load_extension("ui-select")
    --   ]],
    -- },
    -- { 'sidebar-nvim/sidebar.nvim',
    --   branch = 'dev',
    --   config = [[
    --     require("sidebar-nvim").setup {}
    --   ]],
    -- },
  },
  bufferline = {
    {
      'romgrk/barbar.nvim',
      event = 'BufWinEnter',
      config = [[
        require('young.mod.barbar').hot()
      ]],
    },
  },
  statusline = {
    -- { 'NTBBloodbath/galaxyline.nvim', config = require('plug-config.galaxyline')}
    {
      'nvim-lualine/lualine.nvim',
      config = [[
        require 'young.mod.lualine'
      ]],
    },
    -- {
    --   'feline-nvim/feline.nvim',
    --   config = [[
    --     require 'young.mod.feline'
    --   ]],
    -- },
    -- {
    --   'SmiteshP/nvim-gps',
    --   requires = 'nvim-treesitter/nvim-treesitter',
    --   config = [[
    --     require 'young.mod.gps'
    --   ]],
    -- },
  },
  cmdline = {
    {
      'VonHeikemen/fine-cmdline.nvim',
      requires = { { 'MunifTanjim/nui.nvim' } },
      -- cmd = 'FineCmdline',
      event = 'BufRead',
      config = [[
        require 'young.mod.fine-cmd'
      ]],
    },
    -- {
    --   'gelguy/wilder.nvim',
    --   event = 'CmdlineEnter',
    --   config = [[
    --     require 'young.mod.wilder'
    --   ]],
    -- },
  },
  terminal = {
    {
      'akinsho/toggleterm.nvim',
      event = 'BufWinEnter',
      config = [[
        require('young.mod.toggleterm').done()
      ]],
    },
  },
  screen = {
    {
      'goolord/alpha-nvim',
      config = [[
        -- require('alpha').setup(require('young.mod.alpha.screen').opts)
        require('young.mod.alpha').done()
      ]],
    },
  },
  other = {
    -- {
    --   'wfxr/minimap.vim',
    --   cmd = { 'MinimapToggle' },
    --   -- event = 'BufWinEnter',
    --   config = [[
    --     require 'young.mod.minimap'
    --   ]],
    -- },
    -- {
    --   'dstein64/nvim-scrollview',
    --   event = 'BufWinEnter',
    --   config = [[
    --     require 'young.mod.scrollview'
    --   ]],
    -- },
    {
      'petertriho/nvim-scrollbar',
      event = 'BufWinEnter',
      config = [[
        require('scrollbar').setup()
        -- require('scrollbar.handlers.search').setup()
      ]],
    },
  },
}

mods.code = {
  completion = {
    {
      'hrsh7th/nvim-cmp',
      config = [[
        require('young.mod.cmp').done()
      ]],
      requires = {
        -- [luasnip]
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        -- [vsnip]
        -- 'hrsh7th/cmp-vsnip',
        -- 'hrsh7th/vim-vsnip',
        -- [ultisnips]
        -- 'SirVer/ultisnips'
        -- 'quangnguyen30192/cmp-nvim-ultisnips'
        -- [source]
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-cmdline',
        --
        {
          'petertriho/cmp-git',
          config = [[
            require('cmp_git').setup()
          ]],
        },
      },
    },
    { 'onsails/lspkind-nvim' },
    { 'rafamadriz/friendly-snippets' },
    {
      'github/copilot.vim',
      -- requires = { { 'hrsh7th/cmp-copilot', after = 'copilot.vim' } },
      -- event = 'InsertEnter',
      cmd = 'Copilot',
      setup = [[
        require('young.mod.copilot').setup_vim()
      ]],
    },
    -- {
    --   'zbirenbaum/copilot.lua',
    --   requires = { { 'zbirenbaum/copilot-cmp', after = { 'copilot.lua', 'nvim-cmp' } } },
    --   event = 'InsertEnter',
    --   config = [[require('young.mod.copilot').setup_lua()]],
    -- }
  },
  task = {
    -- { 'tpope/vim-dispatch' },
    -- { 'pianocomposer321/yabs.nvim', config = require 'young.mod.yabs' },
    -- {
    --   'skywind3000/asynctasks.vim',
    --   cmd = { 'AsyncTask' },
    --   config = [[
    --     vim.g.asyncrun_open = 25
    --     vim.g.asyncrun_bell = 1
    --     vim.g.asyncrun_rootmarks = { '.svn', '.git', '.root', '_darcs', 'build.xml' }
    --     vim.g.asynctasks_term_pos = 'floaterm'
    --     vim.g.asynctasks_term_reuse = 0
    --   ]],
    --   requires = {
    --     {
    --       'skywind3000/asyncrun.vim',
    --       opt = true,
    --     }
    --   },
    -- },
  },
}

mods.LSP = {
  core = {
    { 'neovim/nvim-lspconfig' },
    {
      'williamboman/nvim-lsp-installer',
      config = [[require('young.lsp').done()]],
    },
    { 'jose-elias-alvarez/null-ls.nvim' },
    { 'b0o/SchemaStore.nvim' },
    {
      'ray-x/lsp_signature.nvim',
      event = 'BufRead',
      config = [[
        require 'young.mod.lsp-signature'
      ]],
    },
  },
  lua = {
    { 'folke/lua-dev.nvim' },
    { 'nanotee/luv-vimdocs' },
    { 'milisims/nvim-luaref' },
  },
  ui = {
    { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' },
    {
      'kosayoda/nvim-lightbulb',
      event = 'BufRead',
      config = [[
        require 'young.mod.lightbulb'
      ]],
    },
    {
      'j-hui/fidget.nvim',
      config = [[
        require('young.mod.fidget').done()
      ]],
    },
    -- { -- TODO:
    --   'ErichDonGubler/lsp_lines.nvim',
    --   config = [[
    --     require('lsp_lines').register_lsp_virtual_lines()
    --   ]],
    -- },
  },
}

mods.lang = {
  js = {
    {
      'vuki656/package-info.nvim',
      ft = 'json',
      requires = { { 'MunifTanjim/nui.nvim' } },
      config = [[
        require 'young.mod.package-info'
      ]],
    },
  },
  http = {
    {
      'NTBBloodbath/rest.nvim',
      ft = 'http',
      config = [[
        require 'young.mod.rest'
      ]],
    },
  },
  lisp = {
    -- 'kovisoft/paredit',
    -- 'kovisoft/slimv',
    {
      'gpanders/nvim-parinfer',
      ft = { 'clojure', 'scheme', 'lisp', 'racket', 'hy', 'fennel', 'janet', 'carp', 'wast', 'yuck' },
    },
    -- {
    --   'eraserhd/parinfer-rust',
    --   run = 'cargo build --release',
    --   ft = { 'clojure', 'scheme', 'lisp', 'fennel', 'racket', 'fennel', 'hy' },
    -- },
  },
  java = {
    {
      'mfussenegger/nvim-jdtls',
      ft = 'java',
      setup = [[
        vim.g.young_jdtls = true
      ]],
    },
  },
}

mods.write = {
  core = {
    {
      'crispgm/telescope-heading.nvim',
      config = [[
        require('telescope').load_extension 'heading'
      ]],
    },
  },
  todo = {
    {
      'folke/todo-comments.nvim',
      event = 'BufWinEnter',
      -- module = 'todo-comments',
      -- cmd = { 'TodoQuickFix', 'TodoLocList', 'TodoTelescope', 'TodoTrouble' },
      requires = 'nvim-lua/plenary.nvim',
      config = [[require 'young.mod.todo-comments']],
    },
  },
  org = {
    {
      'nvim-neorg/neorg',
      ft = 'norg',
      config = [[
        require 'young.mod.neorg'
      ]],
    },
  },
  markdown = {
    {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
      ft = 'markdown',
      config = [[
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_auto_close = 0
        vim.g.mkdp_command_for_global = 1
        vim.g.mkdp_open_to_the_world = 0
      ]],
    },
    -- {
    --   'ellisonleao/glow.nvim',
    --   config = [[
    --     vim.g.glow_border = "rounded"
    --     vim.g.glow_use_pager = true
    --   ]],
    -- },
  },
  zen = {
    {
      'folke/zen-mode.nvim',
      cmd = 'ZenMode',
      config = [[
        require 'young.mod.zen'
      ]],
    },
  },
}

mods.tool = {
  open = {
    {
      'itchyny/vim-external',
      config = function()
        vim.cmd [[
          map <Leader>aee <Plug>(external-editor)
          map <Leader>aen <Plug>(external-explorer)
          map <Leader>aeb <Plug>(external-browser)
          map gx <Plug>(external-browser)
        ]]
      end,
    },
  },
  website = {
    {
      'wakatime/vim-wakatime',
      event = 'BufRead',
    },
    {
      'glacambre/firenvim',
      run = function()
        vim.fn['firenvim#install'](0)
      end,
      disable = not is_windows,
    },
  },
  -- input = {
  --   {
  --     'ZSaberLv0/ZFVimIM',
  --     -- event = 'InsertEnter',
  --     keys = '<leader>tZ',
  --     setup = [[
  --       require 'young.mod.ZFVimIM'
  --     ]],
  --     requires = {
  --       { 'ZSaberLv0/ZFVimJob', after = 'ZFVimIM' },
  --       { 'ZSaberLv0/ZFVimIM_openapi', after = 'ZFVimJob' },
  --     },
  --   },
  -- }
}

local to_plugs = function(t, ...)
  local plugs = {}
  for key, item in pairs(t) do
    if type(key) == 'number' then
      plugs[#plugs + 1] = item
    elseif #{ ... } > 0 then
      if vim.tbl_contains({ ... }, key) then
        vim.list_extend(plugs, item)
      end
    else
      vim.list_extend(plugs, item)
    end
  end
  if #plugs == 1 then
    return unpack(plugs) -- avoid return { { "foo" } } to packer
  end
  return plugs
end

-- Or: use __newindex()
for _, mod in pairs(mods) do
  setmetatable(mod, { __call = to_plugs })
end

M.mods = mods

M.done = function()
  M.plugins = {
    mods.BWT(),
    mods.LSP(),
    mods.UI(),
    mods.appearance(),
    mods.basic(),
    mods.change(),
    mods.code(),
    mods.edit(),
    mods.file(),
    mods.find(),
    mods.git(),
    mods.lang('lisp', 'java'),
    mods.neovim(),
    mods.telescope(),
    mods.theme(),
    mods.tool(),
    mods.write(),
  }
  return M.plugins
end

M.pins = function()
  local pin_plugins = {
    mods.LSP(),
    mods.UI(),
    mods.code(),
    mods.edit(),
    mods.telescope(),
  }

  if #pin_plugins == 1 then
    pin_plugins = unpack(pin_plugins) -- avoid return { { "foo", "bar" } }
  end

  return pin_plugins
end

return M
