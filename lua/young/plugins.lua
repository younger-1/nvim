local M = {}
local mods = {}

setmetatable(mods, {
  __index = function(t, k)
    error(k .. ' is not a valid module section!')
  end,
})

mods.basic = {
  { 'wbthomason/packer.nvim' },
  -- { 'younger-1/packer.nvim', branch = 'mydev' },
  { 'lewis6991/impatient.nvim' },
  {
    'antoinemadec/FixCursorHold.nvim',
    disable = xy.has 'nvim-0.8',
  },
  -- {
  --   'nathom/filetype.nvim',
  --   -- opt = true,
  --   setup = function() end,
  --   config = function()
  --     require('young.mod.filetype').done()
  --   end,
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
      setup = function()
        vim.g.nord_borders = true
      end,
    },
    {
      'marko-cerovac/material.nvim',
      setup = function()
        vim.g.material_style = 'palenight'
      end,
    },
    {
      'lunarvim/onedarker.nvim',
      disable = xy.colorscheme ~= 'onedarker',
      branch = 'freeze',
      config = function()
        require('onedarker').setup()
        -- xy.mod.lualine.options.theme = 'onedarker'
      end,
    },
  },
  helper = {
    -- {
    --   'tjdevries/colorbuddy.nvim',
    --   module = 'colorbuddy',
    -- },
    -- {
    --   'Djancyp/custom-theme.nvim',
    --   requires = 'nvim-lua/plenary.nvim',
    --   config = function()
    --     require('custom-theme').setup()
    --   end,
    -- },
  },
}

mods.appearance = {
  icon = {
    { 'kyazdani42/nvim-web-devicons' },
  },
  color = {
    {
      -- 'norcalli/nvim-colorizer.lua',
      'NvChad/nvim-colorizer.lua',
      event = 'BufRead',
      config = function()
        require 'young.mod.colorizer'
      end,
    },
    {
      'xiyaowong/nvim-transparent',
      -- setup = function()
      --   vim.g.transparent_enabled = false
      -- end,
      -- event = 'BufRead',
      cmd = 'TransparentToggle',
      config = function()
        require 'young.mod.transparent'
      end,
    },
  },
  indent = {
    {
      'lukas-reineke/indent-blankline.nvim',
      after = 'nvim-treesitter',
      config = function()
        require('young.mod.indent_blankline').done()
      end,
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
}

mods.edit = {
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
      setup = function()
        vim.g.wordmotion_prefix = ';'
      end,
    },
    {
      'anuvyklack/vim-smartword',
      event = 'CursorMoved',
    },
    {
      'ggandor/lightspeed.nvim',
      event = 'BufWinEnter',
      config = function()
        require 'young.mod.lightspeed'
      end,
    },
    {
      'andymass/vim-matchup',
      event = 'BufRead',
      setup = function()
        require 'young.mod.matchup'
      end,
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
      run = ':TSUpdate',
      config = function()
        require('young.mod.treesitter').done()
      end,
    },
    { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
    { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' },
    {
      'nvim-treesitter/nvim-treesitter-context',
      after = 'nvim-treesitter',
      config = function()
        require('young.mod.treesitter').setup_context()
      end,
    },
    { 'nvim-treesitter/playground', after = 'nvim-treesitter' },
    { 'RRethy/nvim-treesitter-textsubjects', after = 'nvim-treesitter' },
    {
      'ziontee113/syntax-tree-surfer',
      after = 'nvim-treesitter',
      config = function()
        require 'young.mod.surfer'
      end,
    },
    -- {
    --   'drybalka/tree-climber.nvim',
    --   after = 'nvim-treesitter',
    -- },
  },
  -- {
  --   'hoschi/yode-nvim',
  --   -- event = 'BufWinEnter',
  --   cmd = { 'YodeCreateSeditorFloating' },
  --   requires = 'nvim-lua/plenary.nvim',
  --   config = function()
  --     require('yode-nvim').setup {}
  --   end,
  -- },
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
      after = 'nvim-cmp',
      config = function()
        require 'young.mod.autopairs'
      end,
    },
  },
  comment = {
    {
      'numToStr/Comment.nvim',
      event = 'BufRead',
      -- BUG:PackerCompile will cause `keys` redefined
      -- keys = { { 'n', 'gc' }, { 'x', 'gc' }, { 'n', '<C-_>' }, { 'x', '<C-_>' } },
      config = function()
        require('young.mod.comment').done()
      end,
    },
  },
  other = {
    -- {
    --   'arthurxavierx/vim-caser',
    --   setup = function()
    --     vim.g.caser_prefix = ';c'
    --   end,
    -- },
    {
      'junegunn/vim-easy-align',
      cmd = { 'EasyAlign', 'LiveEasyAlign' },
      -- BUG:PackerCompile will cause `keys` redefined
      keys = { '<Plug>(EasyAlign)', '<Plug>(LiveEasyAlign)' },
      setup = function()
        require 'young.mod.easy_align'
      end,
    },
    -- {
    --   'mg979/vim-visual-multi',
    --   keys = "<A-n>",
    --   -- cmd = { 'VMDebug', 'VMLive', 'VMRegisters', 'VMSearch' },
    --   setup = function()
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
  },
}

mods.neovim = {
  profile = {
    {
      'dstein64/vim-startuptime',
      cmd = 'StartupTime',
      setup = function()
        vim.g.startuptime_use_blocks = 0
      end,
    },
  },
  fold = {
    {
      'kevinhwang91/nvim-ufo',
      event = 'BufRead',
      requires = { { 'kevinhwang91/promise-async', module = 'promise' } },
      config = function()
        require 'young.mod.ufo'
      end,
    },
  },
  { 'gpanders/editorconfig.nvim' },
  -- {
  --   'nacro90/numb.nvim',
  --   event = 'CmdlineEnter',
  --   config = function()
  --     require('numb').setup()
  --   end,
  -- },
  -- {
  --   'winston0410/range-highlight.nvim',
  --   event = 'CmdlineEnter',
  --   requires = { { 'winston0410/cmd-parser.nvim', module = 'cmd-parser' } },
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
  --   setup = function()
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
    event = 'BufRead',
    config = function()
      require 'young.mod.yanky'
    end,
  },
}

mods.BWT = {
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
      disable = not xy.has 'nvim-0.7',
      -- event = 'CursorMoved',
      module = 'smart-splits',
      cmd = 'SmartResizeMode',
      config = function()
        require 'young.mod.smart_splits'
      end,
    },
    {
      's1n7ax/nvim-window-picker',
      -- event = 'CursorMoved',
      module = 'window-picker',
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
      -- module = 'focus',
      config = function()
        require 'young.mod.focus'
      end,
    },
  },
  -- tab = {},
  quickfix = {
    {
      'kevinhwang91/nvim-bqf',
      -- event = "BufRead",
      ft = 'qf',
      -- lua pp((require('bqf.config'))
      config = function()
        require('young.mod.bqf').done()
      end,
    },
  },
}

mods.file = {
  tree = {
    {
      'kyazdani42/nvim-tree.lua',
      -- event = 'BufWinEnter',
      cmd = 'NvimTreeToggle',
      config = function()
        require('young.mod.nvim_tree').done()
      end,
    },
    {
      'tamago324/lir.nvim',
      -- module = 'lir',
      config = function()
        require 'young.mod.lir'
      end,
    },
  },
  project = {
    {
      -- 'ahmedkhalf/project.nvim',
      'younger-1/project.nvim',
      event = 'BufRead',
      -- after = 'telescope.nvim',
      branch = 'mydev',
      config = function()
        require 'young.mod.project'
      end,
    },
  },
  session = {
    {
      'folke/persistence.nvim',
      event = 'BufRead',
      -- module = 'persistence',
      config = function()
        require 'young.mod.persistence'
      end,
    },
  },
  dir = {
    -- {
    --   'ZSaberLv0/ZFVimDirDiff',
    --   cmd = { 'ZFDirDiff', 'ZFDirDiffMark' },
    --   setup = function()
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
      setup = function()
        require 'young.mod.unception'
      end,
    },
  },
}

mods.find = {
  grep = {
    {
      'windwp/nvim-spectre',
      event = 'BufRead',
      config = function()
        require('young.mod.spectre').done()
      end,
    },
  },
  fzf = {
    {
      'ibhagwan/fzf-lua',
      cmd = 'FzfLua',
      module = 'fzf-lua',
      config = function()
        require 'young.mod.fzf'
      end,
      disable = is_windows,
    },
  },
  -- {
  --   'VonHeikemen/searchbox.nvim',
  --   requires = { { 'MunifTanjim/nui.nvim', module = 'nui' } },
  --   -- module = 'searchbox',
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

mods.telescope = {
  core = {
    {
      'nvim-telescope/telescope.nvim',
      -- cmd = 'Telescope', -- BUG:PackerCompile will cause `cmd` redefined
      event = 'BufRead',
      -- defer = 2,
      module = 'telescope',
      requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
      config = function()
        require('young.mod.telescope').done()
      end,
    },
    {
      'natecraddock/telescope-zf-native.nvim',
      after = 'telescope.nvim',
      config = function()
        require('telescope').load_extension 'zf-native'
      end,
    },
    {
      'nvim-telescope/telescope-file-browser.nvim',
      after = 'telescope.nvim',
      config = function()
        require('telescope').load_extension 'file_browser'
      end,
    },
  },
  other = {
    { 'nvim-telescope/telescope-symbols.nvim' },
    {
      'nvim-telescope/telescope-packer.nvim',
      after = 'telescope.nvim',
      config = function()
        require('telescope').load_extension 'packer'
      end,
    },
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      after = 'telescope.nvim',
      config = function()
        require('telescope').load_extension 'live_grep_args'
      end,
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      after = 'telescope.nvim',
      requires = { { 'kkharji/sqlite.lua', module = 'sqlite' } },
    },
    {
      'AckslD/nvim-neoclip.lua',
      after = 'telescope.nvim',
      requires = { { 'kkharji/sqlite.lua', module = 'sqlite' } },
      config = function()
        require 'young.mod.neoclip'
      end,
    },
    {
      'LinArcX/telescope-env.nvim',
      after = 'telescope.nvim',
      config = function()
        require('telescope').load_extension 'env'
      end,
    },
    {
      'jvgrootveld/telescope-zoxide',
      after = 'telescope.nvim',
      config = function()
        require('telescope').load_extension 'zoxide'
        require('telescope._extensions.zoxide.config').setup {
          prompt_title = '[ Z⏫ ]',
        }
      end,
    },
    -- {
    --   'dhruvmanila/telescope-bookmarks.nvim',
    --   after = 'telescope.nvim',
    --   requires = { { 'kkharji/sqlite.lua', module = 'sqlite' } },
    --   config = function()
    --     require('telescope').load_extension 'bookmarks'
    --   end,
    -- },
    -- {
    --   'LinArcX/telescope-command-palette.nvim',
    --   after = 'telescope.nvim',
    --   config = function()
    --     require('telescope').load_extension 'command_palette'
    --   end,
    -- },
    -- {
    --   'cljoly/telescope-repo.nvim',
    --   after = 'telescope.nvim',
    --   config = function()
    --     require('telescope').load_extension 'repo'
    --   end,
    -- },
    -- {
    --   'nvim-telescope/telescope-github.nvim',
    --   after = 'telescope.nvim',
    --   config = function()
    --     require('telescope').load_extension 'gh'
    --   end,
    -- },
  },
}

mods.git = {
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'GBrowse' },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('young.mod.gitsigns').done()
    end,
  },
  {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    event = 'BufRead',
    config = function()
      require 'young.mod.diffview'
    end,
  },
  {
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    module = 'neogit',
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
  --   disable = is_windows,
  -- },
  {
    'ruifm/gitlinker.nvim',
    event = 'BufRead',
    config = function()
      require('young.mod.gitlinker').done()
    end,
  },
  -- { -- Perf: bad for windows when trigger `DirChanged`
  --   'akinsho/git-conflict.nvim',
  --   event = 'BufRead',
  --   disable = is_windows,
  --   config = [[require('young.mod.git_conflict')]],
  -- },
}

mods.UI = {
  core = {
    {
      'rcarriga/nvim-notify',
      -- event = 'VimEnter',
      -- event = 'BufWinEnter',
      after = 'telescope.nvim',
      config = function()
        require('young.mod.notify').done()
      end,
    },
    {
      -- 'folke/which-key.nvim',
      'folke/which-key.nvim', -- TODO:while lvim use it
      event = 'BufWinEnter',
      config = function()
        require('young.mod.which_key').done()
      end,
    },
    {
      'anuvyklack/hydra.nvim',
      -- defer = 2,
      event = 'BufWinEnter',
      config = function()
        require 'young.mod.hydra'
      end,
    },
    {
      'folke/trouble.nvim',
      -- event = 'BufRead',
      cmd = { 'Trouble', 'TroubleToggle' },
      -- after = 'telescope.nvim',
      config = function()
        require('young.mod.trouble').done()
      end,
    },
    {
      'stevearc/dressing.nvim',
      event = 'BufWinEnter',
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
    {
      'mbbill/undotree',
      cmd = 'UndotreeToggle',
      setup = function()
        require 'young.mod.undotree'
      end,
    },
  },
  bufferline = {
    {
      'romgrk/barbar.nvim',
      event = 'BufRead',
      config = function()
        require('young.mod.barbar').hot()
      end,
    },
  },
  winbar = {
    { -- breadcrumbs
      'SmiteshP/nvim-navic',
      event = 'LspAttach',
      config = function()
        require 'young.mod.navic'
      end,
    },
  },
  statusline = {
    -- { 'NTBBloodbath/galaxyline.nvim', config = require('plug-config.galaxyline')}
    {
      'nvim-lualine/lualine.nvim',
      event = 'BufRead',
      config = function()
        require 'young.mod.lualine'
      end,
    },
    -- {
    --   'feline-nvim/feline.nvim',
    --   config = function()
    --     require 'young.mod.feline'
    --   end,
    -- },
    -- {
    --   'SmiteshP/nvim-gps',
    --   requires = 'nvim-treesitter/nvim-treesitter',
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
  },
  cmdline = {
    -- {
    --   'VonHeikemen/fine-cmdline.nvim',
    --   requires = { { 'MunifTanjim/nui.nvim', module = 'nui' } },
    --   -- cmd = 'FineCmdline',
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
      event = 'BufWinEnter',
      bufread = true,
      config = function()
        -- require('alpha').setup(require('young.mod.alpha.screen').opts)
        require('young.mod.alpha').done()
      end,
    },
  },
  outline = {
    {
      'simrat39/symbols-outline.nvim',
      cmd = 'SymbolsOutline',
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
      after = 'nvim-hlslens',
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

mods.code = {
  jump = {
    {
      -- 'pechorin/any-jump.vim',
      'younger-1/any-jump.vim',
      branch = 'remove-pics',
      cmd = { 'AnyJump', 'AnyJumpVisual', 'AnyJumpArg' },
      setup = function()
        require 'young.mod.anyjump'
      end,
    },
  },
  completion = {
    {
      'hrsh7th/nvim-cmp',
      event = { 'InsertEnter', 'CmdlineEnter' },
      config = function()
        require('young.mod.cmp').done()
      end,
      requires = {
        -- [source]
        { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
        -- { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
        --
        { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-emoji', after = 'nvim-cmp' },
        { 'lukas-reineke/cmp-rg', after = 'nvim-cmp' },
        -- { 'octaltree/cmp-look', after = 'nvim-cmp' }, -- need binary (look) and file (/usr/share/dict/words)
        -- {
        --   'uga-rosa/cmp-dictionary',
        --   after = 'nvim-cmp',
        --   config = function()
        --     require('young.mod.cmp').setup_dictionary()
        --   end,
        -- },
        --
        {
          'petertriho/cmp-git',
          after = 'nvim-cmp', -- TODO:load only in gitcommit
          ft = 'gitcommit',
          requires = 'nvim-lua/plenary.nvim',
          config = function()
            require('cmp_git').setup()
          end,
        },
        {
          'rcarriga/cmp-dap',
          after = { 'nvim-cmp', 'nvim-dap' },
        },
      },
    },
    { 'onsails/lspkind-nvim' },
    -- {
    --   'github/copilot.vim',
    --   -- requires = { { 'hrsh7th/cmp-copilot', after = 'copilot.vim' } },
    --   event = 'InsertEnter',
    --   cmd = 'Copilot',
    --   setup = [[require('young.mod.copilot').setup_vim()]],
    -- },
    -- {
    --   'zbirenbaum/copilot.lua',
    --   requires = { { 'zbirenbaum/copilot-cmp', after = { 'copilot.lua', 'nvim-cmp' } } },
    --   event = 'InsertEnter',
    --   config = [[require('young.mod.copilot').setup_lua()]],
    -- }
  },
  snippet = {
    -- [luasnip]
    {
      'L3MON4D3/LuaSnip',
      module = 'luasnip',
      config = function()
        require 'young.mod.luasnip'
      end,
    },
    { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    -- [vsnip]
    -- 'hrsh7th/cmp-vsnip',
    -- 'hrsh7th/vim-vsnip',
    -- [ultisnips]
    -- 'SirVer/ultisnips'
    -- 'quangnguyen30192/cmp-nvim-ultisnips'
    { 'rafamadriz/friendly-snippets', opts = true },
  },
  debug = {
    {
      'mfussenegger/nvim-dap',
      module = 'dap',
      config = function()
        require 'young.mod.dap'
      end,
    },
    {
      'rcarriga/nvim-dap-ui',
      after = 'nvim-dap',
      config = function()
        require 'young.mod.dapui'
      end,
    },
    {
      'theHamsta/nvim-dap-virtual-text',
      after = 'nvim-dap',
      config = function()
        require('young.mod.dap').setup_virtual_text()
      end,
    },
    {
      'nvim-telescope/telescope-dap.nvim',
      after = { 'nvim-dap', 'telescope.nvim' },
      -- config = function()
      --   require('telescope').load_extension 'dap'
      -- end,
    },
    {
      'Weissle/persistent-breakpoints.nvim',
      after = 'nvim-dap',
      config = function()
        require('persistent-breakpoints').setup {}
      end,
    },
    {
      'mfussenegger/nvim-dap-python',
      after = 'nvim-dap',
      config = function()
        require('young.mod.dap').setup_python()
      end,
    },
    {
      'leoluz/nvim-dap-go',
      after = 'nvim-dap',
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
    --   requires = {
    --     {
    --       'skywind3000/asyncrun.vim',
    --       opt = true,
    --     }
    --   },
    -- },
  },
  doc = {
    {
      'danymat/neogen',
      -- cmd = 'Neogen',
      -- event = 'InsertEnter',
      after = 'nvim-treesitter',
      config = function()
        require('neogen').setup {
          snippet_engine = 'luasnip',
        }
      end,
    },
  },
}

mods.LSP = {
  core = {
    { 'neovim/nvim-lspconfig' },
    -- { 'williamboman/nvim-lsp-installer' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    {
      'jose-elias-alvarez/null-ls.nvim',
      config = function()
        require('young.lsp.null_ls').done()
      end,
    },
    { 'b0o/SchemaStore.nvim' },
    {
      'ray-x/lsp_signature.nvim',
      event = 'InsertEnter',
      config = function()
        require 'young.mod.lsp_signature'
      end,
    },
  },
  lua = {
    { 'folke/lua-dev.nvim', opt = true },
    -- { 'ii14/emmylua-nvim', opt = true },
    {
      'nanotee/luv-vimdocs',
      disable = xy.has 'nvim-0.8',
    },
    {
      'milisims/nvim-luaref',
      disable = xy.has 'nvim-0.8',
    },
    -- {
    --   'rafcamlet/nvim-luapad',
    --   cmd = { 'Luapad', 'LuaRun', 'LuapadToggle' },
    --   config = function()
    --     require 'young.mod.luapad'
    --   end,
    -- },
  },
  ui = {
    {
      'glepnir/lspsaga.nvim',
      -- event = 'BufWinEnter',
      cmd = 'Lspsaga',
      setup = function()
        require('young.mod.lspsaga').once()
      end,
      config = function()
        require('young.mod.lspsaga').done()
      end,
    },
    { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' },
    -- {
    --   'kosayoda/nvim-lightbulb',
    --   event = 'BufRead',
    --   config = function()
    --     require 'young.mod.lightbulb'
    --   end,
    -- },
    {
      'j-hui/fidget.nvim',
      event = 'LspAttach',
      config = function()
        require('young.mod.fidget').done()
      end,
    },
    {
      'Maan2003/lsp_lines.nvim',
      -- 'ErichDonGubler/lsp_lines.nvim',
      event = 'LspAttach',
      config = function()
        require('young.mod.lsp_lines').done()
      end,
    },
  },
  highlight = {
    { -- Highlighting the word under the cursor
      'RRethy/vim-illuminate',
      disable = require('young.lsp.config').document_highlight,
      event = 'BufWinEnter',
      config = function()
        require 'young.mod.illuminate'
      end,
    },
    {
      'm-demare/hlargs.nvim',
      after = 'nvim-treesitter',
      config = function()
        require('hlargs').setup {
          -- color = '#ef9062',
        }
      end,
    },
  },
}

mods.lang = {
  -- {
  --   'sheerun/vim-polyglot',
  --   opt = true,
  --   setup = function()
  --     vim.g.polyglot_disabled = { 'autoindent', 'ftdetect', 'markdown' }
  --   end,
  -- },
  python = {
    -- {
    --   'dccsillag/magma-nvim',
    --   ft = { 'python' },
    --   run = ':UpdateRemotePlugins',
    -- },
    {
      'luk400/vim-jukit',
      ft = 'ipynb',
      -- cmd = { 'JukitOut', 'JukitOutHist' },
      setup = function()
        require('young.mod.jukit').once()
      end,
      config = function()
        require('young.mod.jukit').done()
      end,
    },
  },
  js = {
    {
      'vuki656/package-info.nvim',
      ft = 'json',
      requires = { { 'MunifTanjim/nui.nvim', module = 'nui' } },
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
    --   run = 'cargo build --release',
    --   ft = { 'clojure', 'scheme', 'lisp', 'fennel', 'racket', 'fennel', 'hy' },
    -- },
  },
  java = {
    {
      'mfussenegger/nvim-jdtls',
      ft = 'java',
      setup = function()
        vim.g.young_jdtls = true
      end,
    },
  },
}

mods.write = {
  todo = {
    {
      'folke/todo-comments.nvim',
      event = 'BufRead',
      -- module = 'todo-comments',
      -- cmd = { 'TodoQuickFix', 'TodoLocList', 'TodoTelescope', 'TodoTrouble' },
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require 'young.mod.todo_comments'
      end,
    },
  },
  org = {
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
      'crispgm/telescope-heading.nvim',
      after = 'telescope.nvim',
      config = function()
        require('telescope').load_extension 'heading'
      end,
    },
    {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
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
  },
  zen = {
    {
      'folke/zen-mode.nvim',
      cmd = 'ZenMode',
      config = function()
        require 'young.mod.zen'
      end,
    },
  },
  { 'jbyuki/venn.nvim', cmd = 'VBox' },
  { 'jbyuki/nabla.nvim', module = 'nabla' },
}

mods.tool = {
  open = {
    {
      'itchyny/vim-external', -- TODO:gx in WSL
      event = 'BufWinEnter',
      config = function()
        require 'young.mod.external'
      end,
    },
    {
      'axieax/urlview.nvim',
      opt = true,
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
  --     setup = [[require 'young.mod.ZFVimIM']],
  --     requires = {
  --       { 'ZSaberLv0/ZFVimJob', after = 'ZFVimIM' },
  --       { 'ZSaberLv0/ZFVimIM_openapi', after = 'ZFVimJob' },
  --     },
  --   },
  -- }
}

local to_plugs = function(t, buckets)
  local plugs = {}
  for key, item in pairs(t) do
    if type(key) == 'number' then
      plugs[#plugs + 1] = item
    elseif buckets and #buckets > 0 then
      if vim.tbl_contains(buckets, key) then
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
    mods.lang { 'python', 'lisp', 'java' },
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
