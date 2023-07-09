local cmd = require('young.key').cmd

local modules = {}

modules.theme = {
  -- { 'rktjmp/lush.nvim' },
  {
    'folke/styler.nvim',
    event = 'BufWinEnter',
    config = function()
      require('styler').setup {
        themes = {
          markdown = { colorscheme = 'nightfox' },
          help = { colorscheme = 'kanagawa' },
          -- noice = { colorscheme = "gruvbox", background = "dark" },
        },
      }
    end,
  },
  vim = {
    -- 'joshdick/onedark.vim',
    'sainnhe/sonokai',
    'sainnhe/edge',
    'sainnhe/everforest',
    'sainnhe/gruvbox-material',
  },
  lua = {
    {
      'Mofiqul/dracula.nvim',
      config = function()
        require 'young.theme.dracula'
      end,
    },
    {
      'tanvirtin/monokai.nvim',
      config = function()
        require 'young.theme.monokai'
      end,
    },
    {
      'navarasu/onedark.nvim',
      config = function()
        require 'young.theme.onedark'
      end,
    },
    'rebelot/kanagawa.nvim',
    'ellisonleao/gruvbox.nvim',
    'daschw/leaf.nvim',
    'projekt0n/github-nvim-theme',
    'mvpopuk/inspired-github.vim',
    'LunarVim/darkplus.nvim',
    'Mofiqul/vscode.nvim',
    'EdenEast/nightfox.nvim',
    'rmehri01/onenord.nvim',
    {
      'shaunsingh/nord.nvim',
      init = function()
        vim.g.nord_borders = true
      end,
    },
    {
      'marko-cerovac/material.nvim',
      init = function()
        vim.g.material_style = 'palenight'
      end,
    },
    {
      'lunarvim/onedarker.nvim',
      enabled = xy.colorscheme == 'onedarker',
      branch = 'freeze',
      config = function()
        require 'young.theme.onedarker'
      end,
    },
    { 'rose-pine/neovim', name = 'rose-pine' },
    { 'catppuccin/nvim', name = 'catppuccin' },
  },
  helper = {
    -- {
    --   'tjdevries/colorbuddy.nvim',
    --   lazy = true,
    -- },
    -- {
    --   'Djancyp/custom-theme.nvim',
    --   -- 'younger-1/custom-theme.nvim',
    --   dependencies = 'nvim-lua/plenary.nvim',
    --   cmd = 'CustomTheme',
    --   config = function()
    --     require('custom-theme').setup()
    --   end,
    -- },
  },
}

modules.appearance = {
  icon = {
    { 'nvim-tree/nvim-web-devicons', auto = 'config' },
    { 'tpope/vim-characterize' },
    -- { 'zsugabubus/vim-vnicode' },
  },
  color = {
    {
      -- 'norcalli/nvim-colorizer.lua',
      'NvChad/nvim-colorizer.lua',
      event = 'BufRead',
      auto = 'config',
    },
    {
      'xiyaowong/nvim-transparent',
      cmd = 'TransparentToggle',
      auto = true,
    },
    {
      'azabiong/vim-highlighter',
      event = 'VeryLazy',
      auto = 'config',
    },
  },
  indent = {
    {
      'lukas-reineke/indent-blankline.nvim',
      event = 'VeryLazy',
      auto = true,
    },
  },
  line = {
    -- { -- Show where your cursor moves when jumping large distances
    --   'edluffy/specs.nvim',
    --   event = 'BufRead',
    --   config = function()
    --     require('young.mod.specs').done()
    --   end,
    -- },
    -- { -- Highlight UI elements based on current mode
    --   'mvllow/modes.nvim',
    --   event = 'CursorMoved',
    --   config = function()
    --     require('young.mod.modes')
    --   end,
    -- },
    {
      'gen740/SmoothCursor.nvim',
      event = 'BufWinEnter',
      config = function()
        require 'young.mod.smooth_cursor'
      end,
    },
  },
  column = {
    {
      'lukas-reineke/virt-column.nvim',
      config = function()
        require('virt-column').setup {
          char = '║',
        }
      end,
    },
    {
      'Bekaboo/deadcolumn.nvim',
    },
  },
}

modules.edit = {
  motion = {
    {
      'haya14busa/vim-asterisk',
      event = 'BufWinEnter',
      config = function()
        require 'young.mod.asterisk'
      end,
    },
    {
      'chaoren/vim-wordmotion',
      event = 'CursorMoved',
      init = function()
        vim.g.wordmotion_prefix = ','
      end,
    },
    {
      'anuvyklack/vim-smartword',
      event = 'CursorMoved',
    },
    -- {
    --   'ggandor/lightspeed.nvim',
    --   event = 'BufWinEnter',
    --   config = function()
    --     require 'young.mod.lightspeed'
    --   end,
    -- },
    {
      'ggandor/leap.nvim',
      event = 'BufWinEnter',
      config = function()
        require 'young.mod.leap'
      end,
    },
    {
      'ggandor/flit.nvim',
      event = 'VeryLazy',
      dependencies = { 'ggandor/leap.nvim' },
      config = function()
        require('flit').setup {}
      end,
    },
    {
      'andymass/vim-matchup',
      event = 'BufRead',
      auto = 'init',
    },
    -- {
    --   'monkoose/matchparen.nvim',
    --   config = function()
    --     require('matchparen').setup()
    --   end,
    -- },
    -- {
    --   'abecodes/tabout.nvim',
    --   config = function()
    --     require('tabout').setup()
    --   end,
    -- },
    -- {
    --   'karb94/neoscroll.nvim',
    --   event = 'BufWinEnter',
    --   config = function()
    --     require 'young.mod.neoscroll'
    --   end,
    -- },
    -- { -- Smooth scrolling for ANY movement command
    --   'declancm/cinnamon.nvim',
    --   event = 'BufWinEnter',
    --   config = function()
    --     require 'young.mod.cinnamon'
    --   end,
    -- },
  },
  -- textobject = {
  -- },
  treesitter = {
    {
      'nvim-treesitter/nvim-treesitter',
      event = { 'BufRead', 'BufNewFile' },
      build = ':TSUpdate',
      config = function()
        require('young.mod.treesitter').done()
      end,
      dependencies = {
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
        { 'RRethy/nvim-treesitter-textsubjects' },
        -- { 'nvim-treesitter/nvim-treesitter-refactor' },
        { 'nvim-treesitter/playground' },
        {
          'nvim-treesitter/nvim-treesitter-context',
          config = function()
            require('young.mod.treesitter').setup_context()
          end,
        },
        {
          'ziontee113/syntax-tree-surfer',
          config = function()
            require 'young.mod.surfer'
          end,
        },
        -- {
        --   'drybalka/tree-climber.nvim',
        -- },
      },
    },
  },
  -- {
  --   'hoschi/yode-nvim',
  --   -- event = 'BufWinEnter',
  --   cmd = { 'YodeCreateSeditorFloating' },
  --   dependencies = 'nvim-lua/plenary.nvim',
  --   config = function()
  --     require('yode-nvim').setup {}
  --   end,
  -- },
  {
    'Wansmer/treesj',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require 'young.mod.treesj'
    end,
  },
  {
    'AndrewRadev/splitjoin.vim',
    event = 'BufWinEnter',
    -- cmd = { 'SplitjoinSplit', 'SplitjoinJoin' },
    init = function()
      vim.g.splitjoin_join_mapping = 'gsj'
      vim.g.splitjoin_split_mapping = 'gss'
    end,
  },
}

modules.change = {
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-abolish' },
  pair = {
    {
      'windwp/nvim-autopairs',
      enabled = not xy.coc,
      event = 'InsertEnter',
      config = function()
        require 'young.mod.autopairs'
      end,
    },
  },
  comment = {
    {
      'numToStr/Comment.nvim',
      -- event = 'BufRead',
      -- keys = { { 'n', 'gc' }, { 'x', 'gc' }, { 'n', '<C-_>' }, { 'x', '<C-_>' } },
      keys = {
        { 'gc', mode = { 'n', 'x' } },
      },
      config = function()
        require 'young.mod.comment'
      end,
    },
  },
  other = {
    -- {
    --   'arthurxavierx/vim-caser',
    --   init = function()
    --     vim.g.caser_prefix = ';c'
    --   end,
    -- },
    {
      'junegunn/vim-easy-align',
      cmd = { 'EasyAlign', 'LiveEasyAlign' },
      keys = { '<Plug>(EasyAlign)', '<Plug>(LiveEasyAlign)' },
      auto = 'init',
    },
    -- {
    --   'mg979/vim-visual-multi',
    --   keys = "<A-n>",
    --   -- cmd = { 'VMDebug', 'VMLive', 'VMRegisters', 'VMSearch' },
    --   init = function()
    --     require('young.mod.multi_cursor')
    --   end,
    -- },
    {
      'monaqa/dial.nvim',
      event = 'BufRead',
      -- FIXME:
      commit = '3b70b2a',
      config = function()
        require('young.mod.dial').done()
      end,
    },
    {
      'nvimdev/dyninput.nvim',
      enabled = xy.has 'nvim-0.10',
      event = 'InsertEnter',
      config = function()
        require 'young.mod.mcc'
      end,
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },
  },
}

modules.neovim = {
  profile = {
    {
      'dstein64/vim-startuptime',
      cmd = 'StartupTime',
      init = function()
        vim.g.startuptime_use_blocks = 0
      end,
    },
  },
  fold = {
    {
      'kevinhwang91/nvim-ufo',
      event = 'VeryLazy',
      dependencies = { 'kevinhwang91/promise-async' },
      auto = true,
    },
  },
  { 'gpanders/editorconfig.nvim' },
  {
    'nacro90/numb.nvim',
    event = 'CmdlineEnter',
    config = function()
      require('numb').setup()
    end,
  },
  -- {
  --   'winston0410/range-highlight.nvim',
  --   event = 'CmdlineEnter',
  --   dependencies = { 'winston0410/cmd-parser.nvim' },
  --   config = function()
  --     require('range-highlight').setup {}
  --   end,
  -- },
  -- {
  --   'lambdalisue/suda.vim',
  --   event = 'BufWinEnter',
  --   config = function()
  --     vim.g['suda#prompt'] = '🔑: '
  --   end,
  -- },
  -- {
  --   'jdhao/better-escape.vim',
  --   event = 'InsertEnter',
  --   init = function()
  --     vim.g.better_escape_shortcut = 'jk'
  --   end
  -- }
  { -- Escape from insert, terminal & command mode without delay
    'TheBlob42/houdini.nvim',
    event = 'BufRead',
    config = function()
      require('houdini').setup()
    end,
  },
  {
    'nmac427/guess-indent.nvim',
    event = 'BufRead',
    config = function()
      require('guess-indent').setup {}
    end,
  },
  -- {
  --   'Darazaki/indent-o-matic',
  --   event = 'BufRead',
  --   config = function()
  --     require('indent-o-matic').setup {}
  --   end,
  -- },
  {
    'gbprod/yanky.nvim',
    dependencies = { 'kkharji/sqlite.lua' },
    event = 'BufRead',
    config = function()
      require 'young.mod.yanky'
    end,
  },
  {
    'ojroques/nvim-osc52',
    event = 'BufRead',
    config = function()
      require 'young.mod.osc52'
    end,
  },
  {
    'lunarvim/bigfile.nvim',
    event = { 'FileReadPre', 'BufReadPre', 'User FileOpened' },
    config = function()
      require('bigfile').config()
    end,
  },
}

modules.BWT = {
  buffer = {
    {
      'ThePrimeagen/harpoon',
      event = 'BufRead',
      config = function()
        require 'young.mod.harpoon'
      end,
    },
    {
      'chentoast/marks.nvim',
      event = 'BufReadPost',
      config = function()
        require 'young.mod.marks'
      end,
    },
    -- {
    --   'stevearc/three.nvim',
    --   event = 'BufRead',
    --   config = function()
    --     require 'young.mod.three'
    --   end,
    -- },
  },
  window = {
    {
      'luukvbaal/stabilize.nvim',
      config = function()
        require('stabilize').setup {}
      end,
    },
    -- { 'dhruvasagar/vim-zoom' },
    {
      'mrjones2014/smart-splits.nvim',
      -- event = 'CursorMoved',
      cmd = 'SmartResizeMode',
      config = function()
        require 'young.mod.smart_splits'
      end,
    },
    {
      's1n7ax/nvim-window-picker',
      event = 'CursorMoved',
      config = function()
        require('young.mod.window_picker').done()
      end,
    },
    {
      'sindrets/winshift.nvim',
      cmd = 'WinShift',
      config = function()
        require 'young.mod.winshift'
      end,
    },
    {
      'beauwilliams/focus.nvim',
      -- event = "BufRead",
      cmd = 'FocusToggle',
      config = function()
        require('young.mod.focus').done()
      end,
    },
  },
  -- tab = {},
  quickfix = {
    { 'weilbith/vim-qfloc-edit', ft = 'qf' },
    {
      'kevinhwang91/nvim-bqf',
      -- event = "BufRead",
      ft = 'qf',
      config = function()
        require('young.mod.bqf').done()
      end,
    },
    {
      'https://gitlab.com/yorickpeterse/nvim-pqf',
      event = 'VeryLazy',
      config = true,
    },
  },
}

modules.file = {
  tree = {
    -- {
    --   'nvim-tree/nvim-tree.lua',
    --   cmd = 'NvimTreeToggle',
    --   -- event = 'BufWinEnter',
    -- },
    {
      'nvim-neo-tree/neo-tree.nvim',
      cmd = 'Neotree',
      dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'MunifTanjim/nui.nvim' },
      },
      auto = true,
    },
    {
      'tamago324/lir.nvim',
      event = 'BufRead',
      -- event = 'User DirOpened',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require 'young.mod.lir'
      end,
    },
  },
  project = {
    {
      'ahmedkhalf/project.nvim',
      -- 'younger-1/project.nvim',
      -- branch = 'mydev',
      event = 'VeryLazy',
      config = function()
        require 'young.mod.project'
      end,
    },
    -- {
    --   'gpanders/vim-oldfiles',
    -- },
  },
  session = {
    {
      'folke/persistence.nvim',
      event = 'BufRead',
      config = function()
        require 'young.mod.persistence'
      end,
    },
    {
      'MunifTanjim/exrc.nvim',
      event = 'BufRead',
      config = function()
        require 'young.mod.exrc'
      end,
    },
  },
  dir = {
    -- {
    --   'ZSaberLv0/ZFVimDirDiff',
    --   cmd = { 'ZFDirDiff', 'ZFDirDiffMark' },
    --   init = function()
    --     vim.g.ZFDirDiffUI_dirExpandable = '+'
    --   end,
    -- },
  },
  terminal = {
    {
      'akinsho/toggleterm.nvim',
      event = 'BufWinEnter',
      config = function()
        require('young.mod.toggleterm').done()
      end,
    },
    {
      'samjwill/nvim-unception',
      -- event = 'TermOpen',
      init = function()
        require 'young.mod.unception'
      end,
    },
    -- {
    --   'nyngwang/NeoTerm.lua',
    --   cmd = 'NeoTermOpen',
    --   auto = true,
    -- },
  },
}

modules.find = {
  grep = {
    {
      'windwp/nvim-spectre',
      event = 'VeryLazy',
      config = function()
        require('young.mod.spectre').done()
      end,
    },
  },
  fzf = {
    {
      'ibhagwan/fzf-lua',
      cmd = 'FzfLua',
      config = function()
        require 'young.mod.fzf'
      end,
      enabled = not is_windows,
    },
  },
  -- {
  --   'VonHeikemen/searchbox.nvim',
  --   dependencies = { 'MunifTanjim/nui.nvim' },
  --   event = 'BufRead',
  --   config = function()
  --     require 'young.mod.searchbox'
  --   end,
  -- },
  {
    'kevinhwang91/nvim-hlslens',
    event = 'CursorMoved',
    config = function()
      require 'young.mod.hlslens'
    end,
  },
}

modules.telescope = {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    -- event = 'BufRead',
    dependencies = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('young.mod.telescope').done()
    end,
  },
  -- {
  --   'nvim-telescope/telescope-fzf-native.nvim',
  --   build = 'make',
  --   build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  -- },
  {
    'natecraddock/telescope-zf-native.nvim',
    event = 'VeryLazy',
    config = function()
      require('telescope').load_extension 'zf-native'
    end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    event = 'VeryLazy',
    config = function()
      require('telescope').load_extension 'file_browser'
    end,
  },
  {
    'nvim-telescope/telescope-smart-history.nvim',
    event = 'VeryLazy',
    dependencies = { 'kkharji/sqlite.lua' },
    config = function()
      require('telescope').load_extension 'smart_history'
    end,
  },
  -- {
  --   'princejoogie/dir-telescope.nvim',
  --   event = 'VeryLazy',
  --   config = function()
  --     require('dir-telescope').setup {
  --       hidden = true,
  --       respect_gitignore = true,
  --     }
  --   end,
  -- },
  {
    'nvim-telescope/telescope-live-grep-args.nvim',
    event = 'VeryLazy',
    config = function()
      require('telescope').load_extension 'live_grep_args'
    end,
  },
  {
    'nvim-telescope/telescope-frecency.nvim',
    event = 'VeryLazy',
    dependencies = { 'kkharji/sqlite.lua' },
  },
  other = {
    { 'nvim-telescope/telescope-symbols.nvim' },
    -- {
    --   'nvim-telescope/telescope-packer.nvim',
    --   config = function()
    --     require('telescope').load_extension 'packer'
    --   end,
    -- },
    {
      'tsakirist/telescope-lazy.nvim',
      event = 'VeryLazy',
      config = function()
        require('telescope').load_extension 'lazy'
        vim.keymap.set('n', '<leader>ps', '<Cmd>Telescope lazy<CR>', { silent = true, desc = 'Open plugins' })
      end,
    },
    {
      'AckslD/nvim-neoclip.lua',
      event = 'VeryLazy',
      dependencies = { 'kkharji/sqlite.lua' },
      config = function()
        require 'young.mod.neoclip'
      end,
    },
    {
      'LinArcX/telescope-env.nvim',
      event = 'VeryLazy',
      config = function()
        require('telescope').load_extension 'env'
      end,
    },
    {
      'jvgrootveld/telescope-zoxide',
      event = 'VeryLazy',
      config = function()
        require('telescope').load_extension 'zoxide'
        require('telescope._extensions.zoxide.config').setup {
          prompt_title = '[ Z⏫ ]',
        }
      end,
    },
    -- {
    --   'dhruvmanila/telescope-bookmarks.nvim',
    --   dependencies = { 'kkharji/sqlite.lua' },
    --   config = function()
    --     require('telescope').load_extension 'bookmarks'
    --   end,
    -- },
    -- {
    --   'LinArcX/telescope-command-palette.nvim',
    --   config = function()
    --     require('telescope').load_extension 'command_palette'
    --   end,
    -- },
    -- {
    --   'cljoly/telescope-repo.nvim',
    --   config = function()
    --     require('telescope').load_extension 'repo'
    --   end,
    -- },
    -- {
    --   'nvim-telescope/telescope-github.nvim',
    --   config = function()
    --     require('telescope').load_extension 'gh'
    --   end,
    -- },
  },
}

modules.git = {
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G', 'Gstatus', 'Gblame', 'Gpush', 'Gpull', 'Gdiff' },
  },
  {
    'rbong/vim-flog',
    dependencies = { 'tpope/vim-fugitive' },
    cmd = { 'Flog', 'Flogsplit' },
  },
  {
    'lewis6991/gitsigns.nvim',
    -- event = 'BufRead',
    event = 'VeryLazy',
    config = function()
      require('young.mod.gitsigns').done()
    end,
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    config = function()
      require 'young.mod.diffview'
    end,
  },
  {
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    config = function()
      require('neogit').setup {}
    end,
  },
  -- {
  --   'tanvirtin/vgit.nvim',
  --   event = 'BufWinEnter',
  --   config = function()
  --       require('vgit').setup()
  --   end,
  --   enabled = not is_windows,
  -- },
  {
    -- 'ruifm/gitlinker.nvim',
    'younger-1/gitlinker.nvim',
    lazy = true,
    branch = 'up-to-0.8',
    config = function()
      require('young.mod.gitlinker').done()
    end,
  },
  -- { -- Perf: bad for windows when trigger `DirChanged`
  --   'akinsho/git-conflict.nvim',
  --   event = 'BufRead',
  --   enabled = not is_windows,
  --   config = [[require('young.mod.git_conflict')]],
  -- },
  undo = {
    {
      'mbbill/undotree',
      cmd = 'UndotreeToggle',
      auto = 'init',
    },
    {
      'kevinhwang91/nvim-fundo',
      lazy = true,
      dependencies = { 'kevinhwang91/promise-async' },
      config = function()
        require('fundo').setup()
      end,
    },
  },
}

modules.UI = {
  {
    'rcarriga/nvim-notify',
    -- event = 'BufWinEnter',
    event = 'VeryLazy',
    config = function()
      require('young.mod.notify').done()
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('young.mod.which_key').done()
    end,
  },
  {
    'anuvyklack/hydra.nvim',
    event = 'VeryLazy',
    config = function()
      require 'young.mod.hydra'
    end,
  },
  {
    'folke/trouble.nvim',
    -- event = 'BufRead',
    cmd = { 'Trouble', 'TroubleToggle' },
    config = function()
      require('young.mod.trouble').done()
    end,
  },
  {
    'stevearc/dressing.nvim',
    -- event = 'BufWinEnter',
    event = 'VeryLazy',
  },
  -- {
  --   'nvim-telescope/telescope-ui-select.nvim',
  --   config = function()
  --     require("telescope").load_extension("ui-select")
  --   end,
  -- },
  -- { 'sidebar-nvim/sidebar.nvim',
  --   branch = 'dev',
  --   config = function()
  --     require("sidebar-nvim").setup {}
  --   end,
  -- },
  -- { 'simnalamburt/vim-mundo', cmd = 'MundoToggle' },
  bufferline = {
    {
      'romgrk/barbar.nvim',
      event = 'BufRead',
      dependencies = {
        'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
      },
      init = function()
        vim.g.barbar_auto_setup = false
      end,
      config = function()
        require 'young.mod.barbar'
      end,
    },
  },
  winbar = {
    -- {
    --   'SmiteshP/nvim-gps',
    --   dependencies = { 'nvim-treesitter/nvim-treesitter' },
    --   config = function()
    --     require 'young.mod.gps'
    --   end,
    -- },
    { -- @see https://github.com/b0o/nvim-conf/blob/main/lua/user/plugin/incline.lua
      'b0o/incline.nvim',
      event = 'BufWinEnter',
      config = function()
        require 'young.mod.incline'
      end,
    },
    { -- breadcrumbs
      'SmiteshP/nvim-navic',
      event = xy.has 'nvim-0.8' and 'LspAttach' or 'BufRead',
      config = function()
        require 'young.mod.navic'
      end,
    },
    -- {
    --   'Bekaboo/dropbar.nvim',
    --   enabled = xy.has 'nvim-0.10',
    -- },
  },
  statusline = {
    -- { 'glepnir/galaxyline.nvim', config = require('young.mod.galaxyline')}
    {
      'nvim-lualine/lualine.nvim',
      event = 'BufRead',
      config = function()
        require 'young.mod.lualine'
      end,
    },
    -- {
    --   'feline-nvim/feline.nvim',
    --   event = 'BufRead',
    --   config = function()
    --     require 'young.mod.feline'
    --   end,
    -- },
  },
  cmdline = {
    -- {
    --   'VonHeikemen/fine-cmdline.nvim',
    --   dependencies = { 'MunifTanjim/nui.nvim' },
    --   event = 'BufRead',
    --   config = function()
    --     require 'young.mod.fine_cmd'
    --   end,
    -- },
    -- {
    --   'gelguy/wilder.nvim',
    --   event = 'CmdlineEnter',
    --   config = function()
    --     require 'young.mod.wilder'
    --   end,
    -- },
  },
  screen = {
    {
      'goolord/alpha-nvim',
      cmd = 'Alpha',
      event = 'VimEnter',
      config = function()
        -- require('alpha').setup(require('young.mod.alpha.screen').opts)
        require('young.mod.alpha').done()
        -- vim.cmd[[doautocmd BufRead]]
      end,
    },
    -- {
    --   'folke/drop.nvim',
    --   event = 'BufWinEnter',
    --   config = function()
    --     require 'young.mod.drop'
    --   end,
    -- },
    {
      'eandrju/cellular-automaton.nvim',
      cmd = 'CellularAutomaton',
      config = function()
        require 'young.mod.cellular'
      end,
    },
  },
  outline = {
    {
      'simrat39/symbols-outline.nvim',
      cmd = 'SymbolsOutline',
      init = function()
        xy.map.n { '<leader>so', '<cmd>SymbolsOutline<cr>' }
      end,
      config = function()
        require 'young.mod.symbols_outline'
      end,
    },
    -- {
    --   'stevearc/aerial.nvim',
    --   event = 'BufWinEnter',
    --   config = function()
    --     require('aerial').setup()
    --   end,
    -- },
  },
  other = {
    -- {
    --   'wfxr/minimap.vim',
    --   cmd = { 'MinimapToggle' },
    --   -- event = 'BufWinEnter',
    --   config = function()
    --     require 'young.mod.minimap'
    --   end,
    -- },
    -- {
    --   'dstein64/nvim-scrollview',
    --   event = 'BufWinEnter',
    --   config = function()
    --     require 'young.mod.scrollview'
    --   end,
    -- },
    {
      'petertriho/nvim-scrollbar',
      -- after = 'nvim-hlslens',
      event = 'VeryLazy',
      config = function()
        require('scrollbar').setup {
          handlers = {
            search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
          },
        }
      end,
    },
  },
}

modules.code = {
  jump = {
    {
      -- 'pechorin/any-jump.vim',
      'younger-1/any-jump.vim',
      branch = 'remove-pics',
      cmd = { 'AnyJump', 'AnyJumpVisual', 'AnyJumpArg' },
      auto = 'init',
    },
  },
  completion = {
    {
      'hrsh7th/nvim-cmp',
      enabled = not xy.coc,
      event = { 'InsertEnter', 'CmdlineEnter' },
      config = function()
        require('young.mod.cmp').done()
      end,
      dependencies = {
        { 'onsails/lspkind-nvim' },
        -- [source]
        { 'hrsh7th/cmp-nvim-lsp' },
        -- { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        --
        { 'hrsh7th/cmp-calc' },
        { 'hrsh7th/cmp-emoji' },
        { 'lukas-reineke/cmp-rg' },
        -- { 'octaltree/cmp-look' }, -- need binary (look) and file (/usr/share/dict/words)
        -- {
        --   'uga-rosa/cmp-dictionary',
        --   config = function()
        --     require('young.mod.cmp').setup_dictionary()
        --   end,
        -- },
        --
        {
          'petertriho/cmp-git',
          ft = 'gitcommit',
          dependencies = 'nvim-lua/plenary.nvim',
          config = function()
            require('cmp_git').setup()
          end,
        },
        {
          'rcarriga/cmp-dap',
        },
      },
    },
    -- {
    --   'github/copilot.vim',
    --   -- dependencies = { 'hrsh7th/cmp-copilot' },
    --   event = 'InsertEnter',
    --   cmd = 'Copilot',
    --   init = [[require('young.mod.copilot').setup_vim()]],
    -- },
    -- {
    --   'zbirenbaum/copilot.lua',
    --   dependencies = { 'zbirenbaum/copilot-cmp' },
    --   event = 'InsertEnter',
    --   config = [[require('young.mod.copilot').setup_lua()]],
    -- }
  },
  snippet = {
    -- [luasnip]
    {
      'L3MON4D3/LuaSnip',
      -- event = 'InsertEnter',
      lazy = true,
      config = function()
        require 'young.mod.luasnip'
      end,
    },
    { 'saadparwaiz1/cmp_luasnip', lazy = true },
    -- [vsnip]
    -- 'hrsh7th/cmp-vsnip',
    -- 'hrsh7th/vim-vsnip',
    -- [ultisnips]
    -- 'SirVer/ultisnips'
    -- 'quangnguyen30192/cmp-nvim-ultisnips'
    { 'rafamadriz/friendly-snippets', lazy = true },
  },
  debug = {
    {
      'mfussenegger/nvim-dap',
      lazy = true,
      config = function()
        require 'young.mod.dap'
      end,
    },
    {
      'rcarriga/nvim-dap-ui',
      lazy = true,
      config = function()
        require 'young.mod.dapui'
      end,
    },
    {
      'theHamsta/nvim-dap-virtual-text',
      lazy = true,
      config = function()
        require('young.mod.dap').setup_virtual_text()
      end,
    },
    {
      'nvim-telescope/telescope-dap.nvim',
      lazy = true,
      -- config = function()
      --   require('telescope').load_extension 'dap'
      -- end,
    },
    {
      'Weissle/persistent-breakpoints.nvim',
      lazy = true,
      config = function()
        require('persistent-breakpoints').setup {}
      end,
    },
    {
      'mfussenegger/nvim-dap-python',
      lazy = true,
      config = function()
        require('young.mod.dap').setup_python()
      end,
    },
    {
      'leoluz/nvim-dap-go',
      lazy = true,
      config = function()
        require('young.mod.dap').setup_go()
      end,
    },
  },
  task = {
    -- { 'tpope/vim-dispatch' },
    -- { 'pianocomposer321/yabs.nvim', config = require 'young.mod.yabs' },
    -- {
    --   'skywind3000/asynctasks.vim',
    --   cmd = { 'AsyncTask' },
    --   config = function()
    --     vim.g.asyncrun_open = 25
    --     vim.g.asyncrun_bell = 1
    --     vim.g.asyncrun_rootmarks = { '.svn', '.git', '.root', '_darcs', 'build.xml' }
    --     vim.g.asynctasks_term_pos = 'floaterm'
    --     vim.g.asynctasks_term_reuse = 0
    --   end,
    --   dependencies = {
    --     {
    --       'skywind3000/asyncrun.vim',
    --       lazy = true,
    --     }
    --   },
    -- },
  },
  doc = {
    {
      'danymat/neogen',
      cmd = 'Neogen',
      -- after = 'nvim-treesitter',
      config = function()
        require('neogen').setup {
          snippet_engine = 'luasnip',
        }
      end,
    },
  },
}

modules.LSP = {
  {
    'neovim/nvim-lspconfig',
    init = function()
      xy.map.register {
        ['<leader>l'] = {
          i = { cmd 'LspInfo' },
          I = { cmd 'LspInstall' },
          m = { cmd 'Mason' },
          n = { cmd 'NullLsInfo' },
          c = { cmd 'CmpStatus' },
          C = { cmd 'Copilot status' },
        },
      }
    end,
    config = function()
      require('young.lsp').done()
    end,
    dependencies = {
      -- { 'williamboman/nvim-lsp-installer' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('young.lsp.null_ls').done()
    end,
  },
  { 'b0o/SchemaStore.nvim' },
  -- {
  --   'ray-x/lsp_signature.nvim',
  --   event = 'InsertEnter',
  --   config = function()
  --     require 'young.mod.lsp_signature'
  --   end,
  -- },
  ui = {
    {
      'glepnir/lspsaga.nvim',
      -- event = 'BufWinEnter',
      cmd = 'Lspsaga',
      dependencies = {
        { 'nvim-tree/nvim-web-devicons' },
        --Please make sure you install markdown and markdown_inline parser
        { 'nvim-treesitter/nvim-treesitter' },
      },
      auto = true,
    },
    -- {
    --   'rmagatti/goto-preview',
    --   lazy = true,
    -- },
    {
      'dnlhc/glance.nvim',
      cmd = 'Glance',
      auto = true,
    },
    {
      'weilbith/nvim-code-action-menu',
      cmd = 'CodeActionMenu',
      init = function()
        xy.map { '<leader>ca', '<cmd>CodeActionMenu<cr>' }
      end,
    },
    -- {
    --   'kosayoda/nvim-lightbulb',
    --   event = xy.has 'nvim-0.8' and 'LspAttach' or 'BufRead',
    --   config = function()
    --     require 'young.mod.lightbulb'
    --   end,
    -- },
    {
      'j-hui/fidget.nvim',
      event = xy.has 'nvim-0.8' and 'LspAttach' or 'BufRead',
      config = function()
        require('young.mod.fidget').done()
      end,
      tag = 'legacy',
    },
    {
      'Maan2003/lsp_lines.nvim',
      -- 'ErichDonGubler/lsp_lines.nvim',
      event = xy.has 'nvim-0.8' and 'LspAttach' or 'BufRead',
      config = function()
        require('young.mod.lsp_lines').done()
      end,
    },
  },
  highlight = {
    { -- Highlighting the word under the cursor
      'RRethy/vim-illuminate',
      enabled = not require('young.lsp.config').document_highlight,
      -- event = 'BufWinEnter',
      event = 'VeryLazy',
      config = function()
        require 'young.mod.illuminate'
      end,
    },
    {
      'm-demare/hlargs.nvim',
      event = 'VeryLazy',
      -- after = 'nvim-treesitter',
      config = function()
        require('hlargs').setup {
          -- color = '#ef9062',
        }
      end,
    },
  },
}

if xy.coc then
  -- https://github.com/neoclide/coc.nvim
  modules.LSP = {
    {
      'neoclide/coc.nvim',
      branch = 'release',
    },
    {
      'fannheyward/telescope-coc.nvim',
      event = 'VeryLazy',
      config = function()
        require('telescope').load_extension 'coc'
        xy.map.n { '<leader>l<space>', '<cmd>Telescope coc<cr>' }
      end,
    },
  }
end

modules.lang = {
  -- {
  --   'sheerun/vim-polyglot',
  --   lazy = true,
  --   init = function()
  --     vim.g.polyglot_disabled = { 'autoindent', 'ftdetect', 'markdown' }
  --   end,
  -- },
  lua = {
    { 'folke/neodev.nvim', lazy = true },
    -- { 'ii14/emmylua-nvim', lazy = true },
    {
      'nanotee/luv-vimdocs',
      enabled = not xy.has 'nvim-0.8',
    },
    {
      'milisims/nvim-luaref',
      enabled = not xy.has 'nvim-0.8',
    },
    -- {
    --   'rafcamlet/nvim-luapad',
    --   cmd = { 'Luapad', 'LuaRun', 'LuapadToggle' },
    --   config = function()
    --     require 'young.mod.luapad'
    --   end,
    -- },
  },
  python = {
    -- {
    --   'dccsillag/magma-nvim',
    --   ft = { 'python' },
    --   build = ':UpdateRemotePlugins',
    -- },
    {
      'luk400/vim-jukit',
      ft = 'ipynb',
      -- cmd = { 'JukitOut', 'JukitOutHist' },
      auto = true,
    },
  },
  js = {
    {
      'vuki656/package-info.nvim',
      ft = 'json',
      dependencies = { 'MunifTanjim/nui.nvim' },
      config = function()
        require 'young.mod.package_info'
      end,
    },
  },
  http = {
    {
      'NTBBloodbath/rest.nvim',
      ft = 'http',
      config = function()
        require 'young.mod.rest'
      end,
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
    --   build = 'cargo build --release',
    --   ft = { 'clojure', 'scheme', 'lisp', 'fennel', 'racket', 'fennel', 'hy' },
    -- },
  },
  java = {
    {
      'mfussenegger/nvim-jdtls',
      enabled = not xy.coc,
      ft = 'java',
      init = function()
        vim.g.young_jdtls = true
      end,
    },
  },
}

modules.write = {
  todo = {
    {
      'folke/todo-comments.nvim',
      event = 'BufRead',
      -- cmd = { 'TodoQuickFix', 'TodoLocList', 'TodoTelescope', 'TodoTrouble' },
      dependencies = 'nvim-lua/plenary.nvim',
      config = function()
        require 'young.mod.todo_comments'
      end,
    },
  },
  org = {
    {
      'nvim-orgmode/orgmode',
      ft = { 'org' },
      auto = 'config',
    },
    {
      'akinsho/org-bullets.nvim',
      ft = { 'org' },
      auto = 'config',
    },
    {
      'nvim-neorg/neorg',
      ft = 'norg',
      config = function()
        require 'young.mod.neorg'
      end,
    },
  },
  markdown = {
    {
      'iamcco/markdown-preview.nvim',
      build = 'cd app && yarn install',
      ft = 'markdown',
      config = function()
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_auto_close = 0
        vim.g.mkdp_command_for_global = 1
        vim.g.mkdp_open_to_the_world = 0
      end,
    },
    -- {
    --   'ellisonleao/glow.nvim',
    --   config = function()
    --     vim.g.glow_border = "rounded"
    --     vim.g.glow_use_pager = true
    --   end,
    -- },
    {
      'crispgm/telescope-heading.nvim',
      ft = { 'markdown', 'norg', 'org', 'rst', 'help', 'asciidoc', 'tex' },
      config = function()
        require('telescope').load_extension 'heading'
      end,
    },
    {
      'lukas-reineke/headlines.nvim',
      ft = { 'markdown', 'norg', 'org', 'rmd' },
      auto = 'config',
    },
  },
  zen = {
    {
      'folke/zen-mode.nvim',
      cmd = 'ZenMode',
      auto = true,
    },
  },
  { 'jbyuki/venn.nvim', cmd = 'VBox' },
  { 'jbyuki/nabla.nvim', lazy = true },
  {
    '3rd/image.nvim',
    event = 'VeryLazy',
    -- ft = { 'markdown', 'norg', 'org', 'rst', 'asciidoc', 'tex' },
    auto = 'config',
    -- enable = require
  },
}

modules.tool = {
  open = {
    {
      'itchyny/vim-external', -- TODO:gx in WSL
      event = 'BufWinEnter',
      keys = { '<Plug>(external-editor)', '<Plug>(external-explorer)', '<Plug>(external-browser)' },
      config = function()
        require 'young.mod.external'
      end,
    },
    {
      'axieax/urlview.nvim',
      lazy = true,
    },
  },
  website = {
    {
      'wakatime/vim-wakatime',
      event = 'BufRead',
    },
    {
      'glacambre/firenvim',
      build = function()
        vim.fn['firenvim#install'](0)
      end,
      enabled = is_windows or is_mac,
    },
    -- { -- Use your favorite machine translation engines
    --   'potamides/pantran.nvim',
    --   event = 'BufRead',
    --   config = function()
    --     require 'young.mod.pantran'
    --   end,
    -- },
  },
  -- input = {
  --   {
  --     'ZSaberLv0/ZFVimIM',
  --     -- event = 'InsertEnter',
  --     keys = '<leader>tZ',
  --     init = [[require 'young.mod.ZFVimIM']],
  --     dependencies = {
  --       { 'ZSaberLv0/ZFVimJob' },
  --       { 'ZSaberLv0/ZFVimIM_openapi' },
  --     },
  --   },
  -- }
  {
    'fidian/hexmode',
    cmd = 'Hexmode',
    init = function()
      -- vim.g.hexmode_patterns = '*.bin,*.exe,*.dat,*.o,*.jpg,*.png'
    end,
  },
  {
    'echasnovski/mini.nvim',
    version = false,
    auto = true,
  },
}

local to_plugs = function(t, submods)
  local plugs = {}
  for key, item in pairs(t) do
    if type(key) == 'number' then
      plugs[#plugs + 1] = item
    elseif submods and #submods > 0 then
      if vim.tbl_contains(submods, key) then
        vim.list_extend(plugs, item)
      end
    else
      vim.list_extend(plugs, item)
    end
  end

  return plugs
end

-- local function require_helper(plug, mod_name)
--   if plug.config or plug.init then
--     return
--   end
--   local short_name = require('lazy.core.plugin').Spec.get_name(plug[1])
--   local plug_name = short_name:match('^[^.]+'):gsub('^n?vim%-', '')
--   -- gg(plug[1], short_name, plug_name)

--   -- local ok, mod = pcall(require, 'young.mod.' .. mod_name .. xy_name)
--   local mod_path
--   for _, paths in ipairs {
--     { 'young', 'mod', plug_name },
--     { 'young', 'mod', mod_name, plug_name },
--   } do
--     local prefix = join_paths(fn.stdpath 'config', 'lua', unpack(paths))
--     if xy.util.is_file(prefix .. '.lua') or xy.util.is_file(prefix .. '/init.lua') then
--       mod_path = table.concat(paths, '.')
--       gg(mod_path)
--       break
--     end
--   end

--   if mod_path then
--     plug.init = function()
--       xy.autogroup('_lazy_init_' .. plug_name, {
--         {
--           'User',
--           'VeryLazy',
--           function()
--             local m = require(mod_path)
--             if type(m) == 'table' and m.once and type(m.once) == 'function' then
--               m.once()
--             end
--           end,
--         },
--       })
--     end
--     plug.config = function()
--       local m = require(mod_path)
--       if type(m) == 'table' and m.done and type(m.done) == 'function' then
--         m.done()
--       end
--     end
--   end
-- end

local function require_helper_semi(plug)
  if not plug.auto then
    return
  end
  -- require('lazy.core.config').plugins
  local short_name = require('lazy.core.plugin').Spec.get_name(plug[1])
  local plug_name = short_name:match('^[^.]+'):gsub('^n?vim%-', '')
  local mod_path = 'young.mod.' .. plug_name

  if plug.auto == 'init' or plug.auto == true then
    plug.init = function()
      xy.autogroup('_lazy_init_' .. plug_name, {
        {
          'User',
          'LazyDone',
          function()
            local m = require(mod_path)
            if type(m) == 'table' and m.once and type(m.once) == 'function' then
              m.once()
            end
          end,
        },
      })
    end
  end

  if plug.auto == 'config' or plug.auto == true then
    plug.config = function()
      local m = require(mod_path)
      if type(m) == 'table' and m.done and type(m.done) == 'function' then
        m.done()
      end
    end
  end
end

local function auto_require_mod(plugs, mod_name)
  for i, plug in ipairs(plugs) do
    if type(plug) == 'string' then
      plug = { plug }
    end
    -- require_helper(plug, mod_name)
    require_helper_semi(plug)
    plugs[i] = plug
  end
  return plugs
end

for _, mod in pairs(modules) do
  -- setmetatable(mod, { __call = to_plugs })
  setmetatable(mod, {
    __call = function(t, s)
      return auto_require_mod(to_plugs(t, s), _)
    end,
  })
end
-- setmetatable(modules, {
--   __newindex = function(t, k, v)
--     rawset(t, k, function(s)
--       -- return to_plugs(v, s)
--       return auto_require_mod(to_plugs(v, s), k)
--     end)
--   end,
-- })

return {
  modules.BWT(),
  modules.LSP(),
  modules.UI(),
  modules.appearance(),
  modules.change(),
  modules.code(),
  modules.edit(),
  modules.file(),
  modules.find(),
  modules.git(),
  modules.lang { 'lua', 'python', 'lisp', 'java' },
  modules.neovim(),
  modules.telescope(),
  modules.theme(),
  modules.tool(),
  modules.write(),
}
