local vim = vim
local xy = xy

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
          help = { colorscheme = 'carbonfox' },
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
    { 'folke/tokyonight.nvim' },
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
    {
      'oxfist/night-owl.nvim',
      enabled = xy.colorscheme == 'night-owl',
      -- config = function()
      --   vim.cmd.colorscheme 'night-owl'
      -- end,
    },
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
      main = 'ibl',
      event = 'VeryLazy',
      auto = true,
    },
    {
      'yaocccc/nvim-hlchunk',
      event = 'VeryLazy',
    },
    -- {
    --   'nvimdev/indentmini.nvim',
    --   event = 'BufEnter',
    --   config = function()
    --     require('indentmini').setup {
    --       char = '│',
    --       exclude = {
    --         'markdown',
    --       },
    --     }
    --   end,
    -- },
    -- {
    --   'shellRaining/hlchunk.nvim',
    --   event = { 'UIEnter' },
    --   config = function()
    --     require('hlchunk').setup {
    --       chunk = {
    --         chars = {
    --           horizontal_line = '━',
    --           vertical_line = '┃',
    --           left_top = '┏',
    --           left_bottom = '┗',
    --           right_arrow = '━',
    --         },
    --       },
    --       blank = {
    --         enable = false,
    --       },
    --     }
    --   end,
    -- },
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
    { -- Fancy cursorline & mode indicator in signcolumn
      'gen740/SmoothCursor.nvim',
      event = 'VeryLazy',
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
    --   'unblevable/quick-scope',
    --   init = function()
    --     vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    --   end,
    -- },
    -- {
    --   'ggandor/lightspeed.nvim',
    --   event = 'BufWinEnter',
    --   config = function()
    --     require 'young.mod.lightspeed'
    --   end,
    -- },
    -- {
    --   'ggandor/leap.nvim',
    --   event = 'BufWinEnter',
    --   config = function()
    --     require 'young.mod.leap'
    --   end,
    -- },
    -- {
    --   'ggandor/flit.nvim',
    --   event = 'VeryLazy',
    --   dependencies = { 'ggandor/leap.nvim' },
    --   config = function()
    --     require('flit').setup {}
    --   end,
    -- },
    {
      'folke/flash.nvim',
      lazy = true,
      auto = true,
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
    -- event = 'BufWinEnter',
    cmd = { 'SplitjoinSplit', 'SplitjoinJoin' },
    keys = {
      { 'gmj', desc = 'Join expr' },
      { 'gms', desc = 'Split expr' },
    },
    init = function()
      vim.g.splitjoin_join_mapping = 'gmj'
      vim.g.splitjoin_split_mapping = 'gms'
    end,
  },
}

modules.change = {
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  -- {
  --   'tpope/vim-abolish',
  --   keys = {
  --     { 'crs', desc = 'snake_case' },
  --     { 'crm', desc = 'MixedCase' },
  --     { 'crc', desc = 'camelCase' },
  --     { 'cru', desc = 'UPPER_CASE' },
  --     { 'cr-', desc = 'dash-case' },
  --     { 'cr.', desc = 'dot.case' },
  --   },
  -- },
  {
    'gregorias/coerce.nvim',
    tag = 'v0.2',
    config = true,
  },
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
        { 'gc', mode = { 'n', 'x' }, desc = 'Comment' },
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
    -- {
    --   'nvimdev/dyninput.nvim',
    --   enabled = xy.has 'nvim-0.10',
    --   event = 'InsertEnter',
    --   config = function()
    --     require 'young.mod.mcc'
    --   end,
    --   dependencies = { 'nvim-treesitter/nvim-treesitter' },
    -- },
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
  register = {
    {
      'gbprod/yanky.nvim',
      event = 'VeryLazy',
      dependencies = { 'kkharji/sqlite.lua' },
      keys = {
        {
          '<leader>sY',
          function()
            vim.cmd 'YankyRingHistory'
          end,
          desc = 'Yanky Ring',
        },
      },
      config = function()
        -- require('telescope').load_extension 'yank_history'
        require 'young.mod.yanky'
      end,
    },
    {
      'AckslD/nvim-neoclip.lua',
      event = 'VeryLazy',
      dependencies = { 'kkharji/sqlite.lua' },
      keys = {
        {
          '<leader>sy',
          function()
            vim.cmd 'Telescope neoclip'
          end,
          desc = 'Clipboard',
        },
      },
      config = function()
        -- require('telescope').load_extension 'neoclip'
        require 'young.mod.neoclip'
      end,
    },
    {
      'ojroques/nvim-osc52',
      event = 'BufRead',
      config = function()
        require 'young.mod.osc52'
      end,
    },
  },
  mark = {
    -- {
    --   'yaocccc/vim-showmarks',
    --    event = 'VeryLazy',
    -- },
    { -- FEAT: save bookmarks
      'chentoast/marks.nvim',
      event = 'BufReadPost',
      -- :MarksToggleSigns[ buffer] Toggle signs globally. Also accepts an optional buffer number to toggle signs for that buffer only.
      -- :MarksListBuf Fill the location list with all marks in the current buffer.
      -- :MarksListGlobal Fill the location list with all global marks in open buffers.
      -- :MarksListAll Fill the location list with all marks in all open buffers.
      -- :BookmarksList group_number Fill the location list with all bookmarks of group "group_number".
      -- :BookmarksListAll Fill the location list with all bookmarks, across all groups.
      keys = {
        { '<leader>mn', '<Plug>(Marks-next-bookmark)' },
        { '<leader>mp', '<Plug>(Marks-prev-bookmark)' },
        --
        {
          '<leader>mt',
          function()
            vim.cmd 'MarksToggleSigns'
          end,
        },
        {
          '<leader>mb',
          function()
            vim.cmd 'MarksListBuf'
          end,
        },
        {
          '<leader>mg',
          function()
            vim.cmd 'MarksListGlobal'
          end,
        },
        {
          '<leader>ma',
          function()
            vim.cmd 'MarksListAll'
          end,
        },
        --
        { '<leader>mL', ':BookmarksList ' },
        {
          '<leader>ml',
          function()
            vim.cmd 'BookmarksListAll'
          end,
        },
      },
      config = function()
        require 'young.mod.marks'
      end,
    },
    -- {
    --   'tomasky/bookmarks.nvim',
    --   event = 'BufReadPost',
    --   config = function()
    --     xy.map.n { '<leader>bm', function() vim.cmd 'Telescope bookmarks list' end }
    --     require('telescope').load_extension 'bookmarks'
    --     require('bookmarks').setup()
    --   end,
    -- },
  },
  {
    'gpanders/editorconfig.nvim',
    enabled = not xy.has 'nvim-0.9',
  },
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
    'lunarvim/bigfile.nvim',
    event = { 'FileReadPre', 'BufReadPre', 'User FileOpened' },
    config = function()
      require('bigfile').setup {
        filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
        pattern = { '*' }, -- autocmd pattern or function see <### Overriding the detection of big files>
        features = { -- features to disable
          'indent_blankline',
          'illuminate',
          'lsp',
          'treesitter',
          'syntax',
          'matchparen',
          'vimopts',
          'filetype',
        },
      }
    end,
  },
  -- { -- BUG: key
  --   'ecthelionvi/NeoComposer.nvim',
  --   event = 'VeryLazy',
  --   dependencies = { 'kkharji/sqlite.lua' },
  --   auto = 'config',
  -- },
}

modules.BWT = {
  buffer = {
    -- {
    --   'ThePrimeagen/harpoon',
    --   event = 'BufRead',
    --   auto = 'config',
    -- },
    -- { -- Just Another Buffer Switcher
    --   'matbme/JABS.nvim',
    --   keys = {
    --     { '<cr>', function() vim.cmd 'JABSOpen' end, desc = 'Jump to buffers' },
    --   },
    --   auto = 'config',
    -- },
  },
  window = {
    {
      'luukvbaal/stabilize.nvim',
      enabled = not xy.has 'nvim-0.9',
      config = function()
        require('stabilize').setup {}
      end,
    },
    {
      'stevearc/stickybuf.nvim',
      opts = {},
    },
    -- { 'dhruvasagar/vim-zoom' },
    {
      'mrjones2014/smart-splits.nvim',
      -- event = 'CursorMoved',
      cmd = 'SmartResizeMode',
      auto = true,
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
      auto = true,
    },
    {
      'nvim-focus/focus.nvim',
      -- event = "BufRead",
      cmd = 'FocusToggle',
      auto = true,
    },
    -- { -- Smooth focus/split
    --   'anuvyklack/windows.nvim',
    --   event = "BufRead",
    --   dependencies = {
    --     'anuvyklack/middleclass',
    --     'anuvyklack/animation.nvim',
    --   },
    --   auto = true,
    -- },
  },
  -- tab = {},
  quickfix = {
    { 'weilbith/vim-qfloc-edit', ft = 'qf' },
    {
      'https://gitlab.com/yorickpeterse/nvim-pqf',
      event = 'VeryLazy',
      config = true,
    },
    -- {
    --   'ten3roberts/qf.nvim',
    --   ft = 'qf',
    --   config = function()
    --     require('qf').setup {}
    --   end,
    -- },
    {
      'kevinhwang91/nvim-bqf',
      -- event = "BufRead",
      ft = 'qf',
      auto = 'config',
    },
    -- {
    --   'arsham/listish.nvim',
    --   dependencies = {
    --     'arsham/arshlib.nvim',
    --     'nvim-treesitter/nvim-treesitter-textobjects',
    --   },
    --   ft = 'qf',
    --   auto = 'config',
    -- },
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
  },
  ranger = {
    {
      'kelly-lin/ranger.nvim',
      keys = {
        {
          '<leader>er',
          function()
            require('ranger-nvim').open(true)
          end,
          desc = 'Ranger',
        },
      },
      config = function()
        require('ranger-nvim').setup { replace_netrw = true }
      end,
    },
    {
      'simonmclean/triptych.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim', -- required
        'nvim-tree/nvim-web-devicons', -- optional
      },
      keys = {
        {
          '<leader>ed',
          function()
            vim.cmd 'Triptych'
          end,
          desc = 'Directory browser',
        },
      },
      auto = 'config',
    },
  },
  dir = {
    {
      'nvim-telescope/telescope-file-browser.nvim',
      keys = {
        {
          '<leader>s.',
          function()
            vim.cmd 'Telescope file_browser hidden=true'
          end,
          desc = 'File browser',
        },
      },
      config = function()
        require('telescope').load_extension 'file_browser'
      end,
    },
    -- {
    --   'ZSaberLv0/ZFVimDirDiff',
    --   cmd = { 'ZFDirDiff', 'ZFDirDiffMark' },
    --   init = function()
    --     vim.g.ZFDirDiffUI_dirExpandable = '+'
    --   end,
    -- },
    -- {
    --   'tamago324/lir.nvim',
    --   -- event = 'BufRead',
    --   -- event = 'User DirOpened',
    --   dependencies = { 'nvim-lua/plenary.nvim' },
    --   init = function()
    --     xy.map.n {
    --       '<leader>-',
    --       function()
    --         require('lir.float').toggle()
    --         require('lir.actions').reload()
    --       end,
    --       'Files',
    --     }
    --   end,
    --   auto = 'config',
    -- },
    {
      'stevearc/oil.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      init = function()
        xy.map.n {
          '<leader>-',
          function()
            vim.cmd 'Oil'
          end,
          'Oil',
        }
        xy.map.n {
          '<leader>ef',
          function()
            require('oil').toggle_float()
          end,
          'Oil float',
        }
      end,
      auto = 'config',
    },
  },
  project = {
    {
      'nvim-telescope/telescope-project.nvim',
      keys = {
        {
          '<leader>sp',
          function()
            vim.cmd 'Telescope project display_type=full layout_config={width=0.7}'
          end,
          desc = 'Projects',
        },
      },
      config = function()
        require('telescope').load_extension 'project'
      end,
    },
    -- {
    --   'ahmedkhalf/project.nvim',
    --   -- 'younger-1/project.nvim',
    --   -- branch = 'mydev',
    --   event = 'VeryLazy',
    --   config = function()
    --     require('telescope').load_extension 'projects'
    --     require 'young.mod.project'
    --     xy.map.n { '<leader>sp', function() vim.cmd 'Telescope projects' end, 'Projects' }
    --     -- xy.map.n { '<leader>pp',cmd 'Telescope projects', 'Projects' }
    --   end,
    -- },
    -- {
    --   'gpanders/vim-oldfiles',
    -- },
    -- {
    --   'CWood-sdf/spaceport.nvim',
    --   opts = {},
    --   lazy = false, -- load spaceport immediately
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
    -- {
    --   'nikvdp/neomux',
    --   cmd = 'Neomux',
    -- },
  },
}

modules.find = {
  search = {
    -- {
    --   'hrsh7th/vim-seak',
    --   config = function()
    --     vim.cmd [[
    --       let g:seak_enabled = v:true
    --       cnoremap <C-o> <Cmd>call seak#select({ 'nohlsearch': v:true })<CR>
    --     ]]
    --   end,
    -- },
    -- {
    --   'hrsh7th/vim-searchx',
    --   auto = 'config',
    -- },
  },
  grep = {
    {
      'nvim-pack/nvim-spectre',
      event = 'VeryLazy',
      auto = true,
    },
    {
      'AckslD/muren.nvim',
      keys = {
        {
          '<leader>rm',
          function()
            vim.cmd 'MurenToggle'
          end,
          desc = 'Multi replace',
        },
        {
          '<leader>rM',
          function()
            vim.cmd 'MurenUnique'
          end,
          desc = 'Multi replace(unique matches of the last search)',
        },
      },
      auto = 'config',
    },
    {
      'gabrielpoca/replacer.nvim',
      opts = {
        save_on_write = false,
        rename_files = false,
      },
      keys = {
        {
          '<leader>rn',
          function()
            require('replacer').run()
          end,
          desc = 'Replacer run',
        },
        {
          '<leader>rN',
          function()
            require('replacer').save()
          end,
          desc = 'Replacer save',
        },
      },
    },
  },
  fzf = {
    {
      'ibhagwan/fzf-lua',
      cmd = 'FzfLua',
      auto = true,
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
  -- {
  --   'kevinhwang91/nvim-hlslens',
  --   -- enabled = not xy.lazy_has 'noice.nvim',
  --   cond = function()
  --     return not xy.lazy_has 'noice.nvim'
  --   end,
  --   event = 'CursorMoved',
  --   auto = true,
  -- },
}

modules.telescope = {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    -- event = 'BufRead',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      -- {
      --   'nvim-telescope/telescope-fzf-native.nvim',
      --   build = 'make',
      --   -- build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      --   config = function()
      --     require('telescope').load_extension 'fzf'
      --   end,
      -- },
      {
        'natecraddock/telescope-zf-native.nvim',
        config = function()
          require('telescope').load_extension 'zf-native'
        end,
      },
      {
        'nvim-telescope/telescope-smart-history.nvim',
        dependencies = { 'kkharji/sqlite.lua' },
        config = function()
          require('telescope').load_extension 'smart_history'
        end,
      },
      {
        'nvim-telescope/telescope-frecency.nvim',
        dependencies = { 'kkharji/sqlite.lua' },
        init = function()
          xy.map.n {
            '<leader>:',
            function()
              vim.cmd 'Telescope frecency'
            end,
            'Frecency',
          }
          xy.map.n {
            '<leader>;',
            function()
              vim.cmd 'Telescope frecency default_text=:CWD:'
            end,
            'Frecency',
          }
        end,
        config = function()
          require('telescope').load_extension 'frecency'
        end,
      },
    },
    auto = true,
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
    keys = {
      {
        "<leader>'",
        function()
          vim.cmd 'Telescope live_grep_args'
        end,
        desc = 'Grep',
      },
      {
        "<leader>'",
        function()
          require('telescope-live-grep-args.shortcuts').grep_visual_selection()
        end,
        mode = 'x',
        desc = 'Grep',
      },
      {
        '<leader>"',
        function()
          require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()
        end,
        desc = 'Grep cursor word',
      },
    },
    config = function()
      require('telescope').load_extension 'live_grep_args'
    end,
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
      keys = {
        {
          '<leader>sx',
          function()
            vim.cmd 'Telescope lazy'
          end,
          desc = 'Lazy plugins',
        },
      },
      config = function()
        require('telescope').load_extension 'lazy'
      end,
    },
    {
      'LinArcX/telescope-env.nvim',
      keys = {
        {
          '<leader>se',
          function()
            vim.cmd 'Telescope env'
          end,
          desc = 'Env variables',
        },
      },
      config = function()
        require('telescope').load_extension 'env'
      end,
    },
    {
      'jvgrootveld/telescope-zoxide',
      keys = {
        {
          '<leader>sz',
          function()
            vim.cmd 'Telescope zoxide list'
          end,
          desc = 'Zoxide',
        },
      },
      config = function()
        require('telescope').load_extension 'zoxide'
      end,
    },
    {
      'LukasPietzschmann/telescope-tabs',
      keys = {
        {
          '<leader>sw',
          function()
            vim.cmd 'Telescope telescope-tabs list_tabs'
          end,
          desc = 'Tabs',
        },
        {
          'g<BS>',
          function()
            vim.cmd 'lua require("telescope-tabs").go_to_previous()'
          end,
          desc = 'Tab Goto',
        },
      },
      config = function()
        require('telescope-tabs').setup {
          close_tab_shortcut_i = '<C-d>', -- if you're in insert mode
          close_tab_shortcut_n = 'D', -- if you're in normal mode
        }
      end,
    },
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
    branch = 'up-to-0.8',
    -- 'linrongbin16/gitlinker.nvim',
    lazy = true,
    auto = true,
  },
  -- { -- PERF: bad for windows when trigger `DirChanged`
  --   'akinsho/git-conflict.nvim',
  --   event = 'BufRead',
  --   enabled = not is_windows,
  --   config = [[require('young.mod.git_conflict')]],
  -- },
  -- github = {
  --   {
  --     'cljoly/telescope-repo.nvim',
  --     config = function()
  --       require('telescope').load_extension 'repo'
  --     end,
  --   },
  --   {
  --     'nvim-telescope/telescope-github.nvim',
  --     config = function()
  --       require('telescope').load_extension 'gh'
  --     end,
  --   },
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
      build = function()
        require('fundo').install()
      end,
      dependencies = { 'kevinhwang91/promise-async' },
      config = function()
        require('fundo').setup()
      end,
    },
  },
}

modules.keymap = {
  { 'anuvyklack/keymap-amend.nvim', lazy = true },

  menu = {
    {
      'folke/which-key.nvim',
      event = 'VeryLazy',
      config = function()
        require('young.mod.which_key').done()
      end,
    },
    -- {
    --   'Cassin01/wf.nvim',
    --   -- version = '*', -- stable version
    --   event = 'VeryLazy',
    --   auto = 'config',
    -- },
    {
      'nvimtools/hydra.nvim',
      event = 'VeryLazy',
      config = function()
        require 'young.mod.hydra'
      end,
    },
    -- {
    --   'linty-org/key-menu.nvim',
    --   event = 'VeryLazy',
    --   config = function()
    --     require 'young.mod.key-menu'
    --   end,
    -- },
  },
  panel = {
    -- {
    --   'LinArcX/telescope-command-palette.nvim',
    --   config = function()
    --     require('telescope').load_extension 'command_palette'
    --   end,
    -- },
    -- {
    --   'FeiyouG/commander.nvim',
    --   lazy = true,
    --   auto = 'config',
    --   -- commander = {
    --   --   {
    --   --     -- keys = { 'n', '<Leader><Leader>' },
    --   --     cmd = function() vim.cmd 'Telescope commander' end,
    --   --     desc = 'Open commander 2',
    --   --   },
    --   -- },
    -- },
    -- {
    --   'mrjones2014/legendary.nvim',
    --   -- version = 'v2.1.0',
    --   -- legendary.nvim handles all your keymaps/commands, its recommended to load legendary.nvim before other plugins
    --   priority = 10000,
    --   lazy = false,
    --   keys = {
    --     {
    --       '<leader>/',
    --       function()
    --         vim.cmd 'Legendary'
    --       end,
    --       mode = { 'n', 'x', 'o' },
    --     },
    --   },
    --   auto = 'config',
    -- },
    -- {
    --   'yagiziskirik/AirSupport.nvim',
    --   event = 'VeryLazy',
    --   config = function()
    --     xy.map.n { '<leader>tk', '<cmd>AirSupport<cr>' }
    --   end,
    --   dependencies = {
    --     { 'nvim-telescope/telescope.nvim' },
    --     { 'nvim-lua/plenary.nvim' },
    --   },
    -- },
    -- {
    --   'LintaoAmons/easy-commands.nvim',
    --   keys = {
    --     {
    --       '<leader>;',
    --       function() vim.cmd 'InspectCommand' end,
    --       mode = { 'n', 'x', 'o' },
    --     },
    --   },
    --   opts = {},
    -- },
  },
  insert = {
    -- {
    --   'jdhao/better-escape.vim',
    --   event = 'InsertEnter',
    --   init = function()
    --     vim.g.better_escape_shortcut = 'jk'
    --   end
    -- }
    { -- Escape from insert, terminal & command mode without delay
      'TheBlob42/houdini.nvim',
      event = 'VeryLazy',
      config = function()
        require('houdini').setup()
      end,
    },
  },
}

modules.UI = {
  {
    'rcarriga/nvim-notify',
    -- event = 'BufWinEnter',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>sn',
        function()
          vim.cmd 'Telescope notify'
        end,
        desc = 'Notify',
      },
      {
        '<leader>un',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
        desc = 'Dismiss all Notifications',
      },
    },
    config = function()
      require('telescope').load_extension 'notify'
      require('young.mod.notify').done()
    end,
  },
  {
    'folke/trouble.nvim',
    -- event = 'BufRead',
    cmd = { 'Trouble', 'TroubleToggle' },
    auto = true,
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
    -- {
    --   'stevearc/three.nvim',
    --   event = 'BufRead',
    --   auto = 'config',
    -- },
  },
  tabline = {
    -- {
    --   'nanozuki/tabby.nvim',
    --   event = 'VeryLazy',
    --   dependencies = 'nvim-tree/nvim-web-devicons',
    --   auto = 'config',
    -- },
    {
      'backdround/tabscope.nvim',
      event = 'VeryLazy',
      config = function()
        require('tabscope').setup {}
        vim.keymap.set('n', '<leader>bc', function()
          require('tabscope').remove_tab_buffer()
        end, { desc = 'Close buffer in current tab' })
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
    -- { -- @see https://github.com/b0o/nvim-conf/blob/main/lua/user/plugin/incline.lua
    --   'b0o/incline.nvim',
    --   event = 'BufWinEnter',
    --   config = function()
    --     require 'young.mod.incline'
    --   end,
    -- },
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
    -- {
    --   'nvim-lualine/lualine.nvim',
    --   event = 'BufRead',
    --   config = function()
    --     require 'young.mod.lualine'
    --   end,
    -- },
    {
      'freddiehaddad/feline.nvim',
      event = 'BufRead',
      opts = {},
      config = function(_, opts)
        require 'young.mod.feline'
      end,
    },
    -- {
    --   'rebelot/heirline.nvim',
    --   config = function()
    --     require('heirline').setup {}
    --   end,
    -- },
  },
  statuscolumn = {
    {
      'luukvbaal/statuscol.nvim',
      auto = 'config',
    },
  },
  cmdline = {
    -- {
    --   'folke/noice.nvim',
    --   event = 'VeryLazy',
    --   dependencies = { 'MunifTanjim/nui.nvim' },
    --   keys = {
    --     {
    --       '<S-Enter>',
    --       function()
    --         require('noice').redirect(vim.fn.getcmdline())
    --       end,
    --       mode = 'c',
    --       desc = 'Redirect Cmdline',
    --     },
    --     { '<leader>nl', function() vim.cmd 'Noice last' end, desc = 'Last' },
    --     { '<leader>nh', function() vim.cmd 'Noice history' end, desc = 'History' },
    --     { '<leader>nd', function() vim.cmd 'Noice dismiss' end, desc = 'Dismiss' },
    --     { '<leader>ni', function() vim.cmd 'Noice stats' end, desc = 'Stats' },
    --     { '<leader>ns', function() vim.cmd 'Noice telescope' end, desc = 'Search' },
    --     {
    --       '<leader>nt',
    --       function()
    --         if vim.o.cmdheight == 0 then
    --           vim.cmd [[Noice disable]]
    --           vim.o.cmdheight = 1
    --         else
    --           vim.cmd [[Noice enable]]
    --         end
    --       end,
    --       desc = 'Toggle',
    --     },
    --     -- { '<c-f>', function() if not require('noice.lsp').scroll(4) then return '<c-f>' end end, silent = true, expr = true, desc = 'Scroll forward', mode = { 'i', 'n', 's' } },
    --     -- { '<c-b>', function() if not require('noice.lsp').scroll(-4) then return '<c-b>' end end, silent = true, expr = true, desc = 'Scroll backward', mode = { 'i', 'n', 's' } },
    --   },
    --   auto = 'config',
    -- },
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
      -- cmd = 'CellularAutomaton',
      keys = {
        {
          '<leader>t<tab>',
          function()
            vim.cmd 'CellularAutomaton make_it_rain'
          end,
          desc = 'Rain',
        },
      },
      config = function()
        require 'young.mod.cellular'
      end,
    },
  },
  outline = {
    -- {
    --   'simrat39/symbols-outline.nvim',
    --   cmd = 'SymbolsOutline',
    --   -- keys = { { '<leader>to', function() vim.cmd 'SymbolsOutline' end } },
    --   init = function()
    --     -- xy.map.n { '<leader>to', '<cmd>SymbolsOutline<cr>' }
    --     xy.map.n { '<leader><tab>', '<cmd>SymbolsOutline<cr>' }
    --   end,
    --   config = function()
    --     require 'young.mod.symbols_outline'
    --   end,
    -- },
    {
      'hedyhli/outline.nvim',
      cmd = { 'Outline', 'OutlineOpen' },
      keys = { -- Example mapping to toggle outline
        { '<leader><tab>', '<cmd>Outline<CR>', desc = 'Toggle outline' },
      },
      opts = {
        -- Your setup opts here
      },
    },
    -- {
    --   'stevearc/aerial.nvim',
    --   event = 'BufWinEnter',
    --   config = function()
    --     require('aerial').setup()
    --   end,
    -- },
  },
  scrollbar = {
    -- {
    --   'wfxr/minimap.vim',
    --   cmd = { 'MinimapToggle' },
    --   -- event = 'BufWinEnter',
    --   auto = 'init',
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
      auto = 'config',
    },
    -- {
    --   'lewis6991/satellite.nvim',
    --   enabled = xy.has 'nvim-0.10',
    --   event = 'VeryLazy',
    --   auto = 'config',
    -- },
  },
}

modules.code = {
  jump = {
    {
      'pechorin/any-jump.vim',
      -- 'younger-1/any-jump.vim',
      -- branch = 'remove-pics',
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
      version = 'v2.*',
      build = 'make install_jsregexp', -- install jsregexp (optional!).
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
    {
      'tpope/vim-dispatch',
      -- :h dispatch-maps
      -- These can be disabled with: let g:dispatch_no_maps = 1
      keys = {
        { 'm<CR>', desc = 'Make' },
        { 'm<Space>', desc = 'Make...' },
        { 'm!', desc = 'Make!' },
        { 'm?', desc = 'Show makeprg' },
        --
        { '`<CR>', desc = 'Dispatch' },
        { '`<Space>', desc = 'Dispatch...' },
        { '`!', desc = 'Dispatch!' },
        { '`?', desc = 'Show Dispatch' },
        --
        { "'<CR>", desc = 'Start' },
        { "'<Space>", desc = 'Start...' },
        { "'!", desc = 'Start!' },
        { "'?", desc = 'Show b:start' },
        --
        { "g'<CR>", desc = 'Spawn' },
        { "g'<Space>", desc = 'Spawn...' },
        { "g'!", desc = 'Spawn!' },
        { "g'?", desc = 'Show shell' },
      },
    },
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
      init = function()
        xy.map.register {
          ['<leader>cn'] = {
            f = {
              function()
                vim.cmd 'Neogen func'
              end,
              'Function',
            },
            F = {
              function()
                vim.cmd 'Neogen file'
              end,
              'File',
            },
            c = {
              function()
                vim.cmd 'Neogen class'
              end,
              'Class',
            },
            t = {
              function()
                vim.cmd 'Neogen type'
              end,
              'Type',
            },
          },
        }
      end,
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
          i = {
            function()
              vim.cmd 'LspInfo'
            end,
            'LspInfo',
          },
          I = {
            function()
              vim.cmd 'LspInstall'
            end,
            'LspInstall',
          },
          m = {
            function()
              vim.cmd 'Mason'
            end,
            'Mason',
          },
          n = {
            function()
              vim.cmd 'NullLsInfo'
            end,
            'Null-ls info',
          },
          c = {
            function()
              vim.cmd 'CmpStatus'
            end,
            'Cmp status',
          },
          C = {
            function()
              vim.cmd 'Copilot status'
            end,
            'Copilot status',
          },
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
    'nvimtools/none-ls.nvim',
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
      'nvimdev/lspsaga.nvim',
      -- event = 'BufWinEnter',
      cmd = 'Lspsaga',
      dependencies = {
        { 'nvim-tree/nvim-web-devicons' },
        -- Please make sure you install markdown and markdown_inline parser
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
      'SmiteshP/nvim-navbuddy',
      event = xy.has 'nvim-0.8' and 'LspAttach' or 'BufRead',
      dependencies = {
        'SmiteshP/nvim-navic',
        'MunifTanjim/nui.nvim',
      },
      auto = 'config',
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
    -- {
    --   'VidocqH/lsp-lens.nvim',
    --   event = xy.has 'nvim-0.8' and 'LspAttach' or 'BufRead',
    --   keys = {
    --     { '<leader>tL', function() vim.cmd 'LspLensToggle' end },
    --   },
    --   config = function()
    --     require('lsp-lens').setup {
    --       include_declaration = false, -- Reference include declaration
    --       sections = { -- Enable / Disable specific request
    --         definition = false,
    --         references = true,
    --         implementation = true,
    --       },
    --       ignore_filetype = {
    --         'prisma',
    --       },
    --     }
    --   end,
    -- },
    {
      'Wansmer/symbol-usage.nvim',
      event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
      auto = 'config',
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
      keys = {
        {
          '<leader>l<space>',
          function()
            vim.cmd 'Telescope coc'
          end,
          desc = 'Coc',
        },
      },
      config = function()
        require('telescope').load_extension 'coc'
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
  cpp = {
    {
      'p00f/clangd_extensions.nvim',
      ft = 'cpp',
      auto = 'config',
    },
  },
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
        xy.autogroup('_jdtls_lsp', {
          { 'FileType', 'java', "lua require'young.lang.java'.setup()" },
        })
      end,
    },
  },
  sql = {
    {
      'tpope/vim-dadbod',
      cmd = { 'DB', 'DBUI' },
      keys = {
        {
          '<leader>td',
          function()
            vim.cmd 'DBUI'
          end,
        },
      },
      dependencies = {
        {
          'kristijanhusak/vim-dadbod-ui',
          init = function()
            vim.cmd [[
            let g:db_ui_show_database_icon = 1
            let g:db_ui_use_nerd_fonts = 1
            " let g:db_ui_debug = 1
            " let g:db_ui_force_echo_notifications = 1
            ]]
          end,
          config = function()
            -- Just make sure to NOT COMMIT these. I suggest using project local vim config (:help exrc)
            vim.g.dbs = {
              -- mysql://user:secret@host:port/database
              local_mysql = 'mysql://root@localhost/',
              -- local_postgres = 'postgres://' .. vim.env.USER .. '@localhost',
              local_postgres = 'postgres:postgres',
              local_postgres_template1 = 'postgres:template1',
              local_postgres_user = 'postgres:' .. vim.env.USER,
              -- dev = 'postgres://postgres:mypassword@localhost:5432/my-dev-db',
              local_clickhouse = 'clickhouse:',
              -- local_clickhouse_default = 'clickhouse:default',
              local_clickhouse_system = 'clickhouse:system',
            }
          end,
        },
        {
          'kristijanhusak/vim-dadbod-completion',
          config = function()
            -- Currently works for PostgreSQL, MySQL, Oracle, SQLite and SQLserver/MSSQL
            vim.cmd [[
            " For built in omnifunc
            " autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
            " For hrsh7th/nvim-cmp
            autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
            ]]
          end,
        },
      },
    },
    -- {
    --   'nanotee/sqls.nvim',
    --   lazy = true,
    -- },
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
    {
      'ellisonleao/glow.nvim',
      keys = {
        {
          '<leader>ro',
          function()
            vim.cmd 'Glow'
          end,
          desc = 'Glow',
        },
      },
      config = function()
        require('glow').setup {
          glow_path = 'glow', -- will be filled automatically with your glow bin in $PATH, if any
          border = 'shadow', -- floating window border config
          pager = false,
          -- width = 80,
          -- height = 100,
          width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
          height_ratio = 0.7,
        }
      end,
    },
    {
      'crispgm/telescope-heading.nvim',
      ft = { 'markdown', 'norg', 'org', 'rst', 'help', 'asciidoc', 'tex' },
      keys = {
        {
          '<leader>so',
          function()
            vim.cmd 'Telescope heading'
          end,
          desc = 'Heading',
        },
      },
      config = function()
        require('telescope').load_extension 'heading'
      end,
    },
    {
      'lukas-reineke/headlines.nvim',
      ft = { 'markdown', 'norg', 'org', 'rmd' },
      auto = 'config',
    },
    {
      'AckslD/nvim-FeMaco.lua',
      ft = { 'markdown', 'norg', 'org' },
      keys = {
        -- Call :FeMaco or require('femaco.edit').edit_code_block() with your cursor on a code-block
        {
          '<leader>re',
          function()
            vim.cmd 'FeMaco'
          end,
          desc = 'Edit Fenced Markdown Code-block',
        },
      },
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
  -- {
  --   '3rd/image.nvim',
  --   event = 'VeryLazy',
  --   -- ft = { 'markdown', 'norg', 'org', 'rst', 'asciidoc', 'tex' },
  --   auto = 'config',
  -- },
}

modules.tool = {
  open = {
    {
      'rmagatti/gx-extended.nvim',
      keys = { 'gx' },
      auto = 'config',
    },
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
    {
      'dhruvmanila/browser-bookmarks.nvim',
      -- event = 'VeryLazy',
      cmd = 'BrowserBookmarks',
      dependencies = {
        -- Only if your selected browser is Firefox, Waterfox or buku
        'kkharji/sqlite.lua',
        -- Only if you're using the Telescope extension
        'nvim-telescope/telescope.nvim',
      },
      init = function()
        xy.map.n {
          '<leader>ab',
          function()
            vim.cmd 'BrowserBookmarks'
          end,
        }
        xy.map.n { '<leader>aB', ':BrowserBookmarks ' }
      end,
      config = function()
        -- require('telescope').load_extension 'bookmarks'
        require('browser_bookmarks').setup {
          selected_browser = 'chrome',
          url_open_command = xy.open_cmd,
          -- url_open_plugin = 'external_browser',
        }
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
      xy.map.n {
        '<leader>tx',
        function()
          vim.cmd 'Hexmode'
        end,
      }
      -- vim.g.hexmode_patterns = '*.bin,*.exe,*.dat,*.o,*.jpg,*.png'
    end,
  },
  {
    'echasnovski/mini.nvim',
    version = false,
    auto = true,
  },
  {
    'mattn/calendar-vim',
    cmd = 'Calendar',
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
  modules.keymap(),
  modules.lang { 'cpp', 'lua', 'python', 'lisp', 'java', 'sql' },
  modules.neovim(),
  modules.telescope(),
  modules.theme(),
  modules.tool(),
  modules.write(),
}
