local vim = vim
local xy = xy

xy.lazy_loaded = {}
vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('_lazy_loaded', { clear = true }),
  pattern = 'LazyLoad',
  callback = function(event)
    local plugin_name = event.data
    xy.lazy_loaded[plugin_name] = (uv.hrtime() - xy.startup_time.hr_start) / 1e9
  end,
})

---@param name string
---@param fn fun(name:string)
local function lazy_on_load(name, fn)
  local Config = require 'lazy.core.config'
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
    return
  end
  vim.api.nvim_create_autocmd('User', {
    pattern = 'LazyLoad',
    callback = function(event)
      if event.data == name then
        fn(name)
        return true
      end
    end,
  })
end

local function lazy_has(plugin)
  return require('lazy.core.config').spec.plugins[plugin] ~= nil
end

xy.lazy_on_load = lazy_on_load
xy.lazy_has = lazy_has

local modules = {}

modules.theme = {
  vim = {
    -- 'joshdick/onedark.vim',
    'sainnhe/sonokai',
    -- 'sainnhe/edge',
    -- 'sainnhe/everforest',
    -- 'sainnhe/gruvbox-material',
  },
  lua = {
    'rebelot/kanagawa.nvim',
    'EdenEast/nightfox.nvim',
    -- { 'folke/tokyonight.nvim' },
    -- {
    --   'Mofiqul/dracula.nvim',
    --   config = function()
    --     require 'young.theme.dracula'
    --   end,
    -- },
    -- {
    --   'tanvirtin/monokai.nvim',
    --   config = function()
    --     require 'young.theme.monokai'
    --   end,
    -- },
    -- {
    --   'navarasu/onedark.nvim',
    --   config = function()
    --     require 'young.theme.onedark'
    --   end,
    -- },
    -- 'ellisonleao/gruvbox.nvim',
    -- 'daschw/leaf.nvim',
    -- 'projekt0n/github-nvim-theme',
    -- 'mvpopuk/inspired-github.vim',
    -- 'LunarVim/darkplus.nvim',
    -- 'Mofiqul/vscode.nvim',
    -- 'rmehri01/onenord.nvim',
    -- {
    --   'shaunsingh/nord.nvim',
    --   init = function()
    --     vim.g.nord_borders = true
    --   end,
    -- },
    -- {
    --   'marko-cerovac/material.nvim',
    --   init = function()
    --     vim.g.material_style = 'palenight'
    --   end,
    -- },
    -- {
    --   'lunarvim/onedarker.nvim',
    --   enabled = xy.colorscheme == 'onedarker',
    --   branch = 'freeze',
    --   config = function()
    --     require 'young.theme.onedarker'
    --   end,
    -- },
    -- { 'rose-pine/neovim', name = 'rose-pine' },
    -- { 'catppuccin/nvim', name = 'catppuccin' },
    -- {
    --   'oxfist/night-owl.nvim',
    --   enabled = xy.colorscheme == 'night-owl',
    --   -- config = function()
    --   --   vim.cmd.colorscheme 'night-owl'
    --   -- end,
    -- },
  },
  helper = {
    {
      'folke/styler.nvim',
      event = { 'BufReadPost', 'BufNewFile' },
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
    -- { 'rktjmp/lush.nvim' },
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
      event = { 'BufReadPost', 'BufNewFile' },
      auto = 'config',
    },
    {
      'xiyaowong/nvim-transparent',
      cmd = 'TransparentToggle',
      auto = true,
    },
    {
      'azabiong/vim-highlighter',
      event = { 'BufReadPost', 'BufNewFile' },
      auto = 'config',
    },
  },
  indent = {
    {
      'lukas-reineke/indent-blankline.nvim',
      main = 'ibl',
      event = { 'BufReadPost', 'BufNewFile' },
      auto = true,
    },
    {
      'yaocccc/nvim-hlchunk',
      event = { 'BufReadPost', 'BufNewFile' },
    },
    -- {
    --   'nvimdev/indentmini.nvim',
    --   event = { 'BufReadPost', 'BufNewFile' },
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
    --   event = 'BufReadPost',
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
      event = { 'BufReadPost', 'BufNewFile' },
      config = function()
        require 'young.mod.smooth_cursor'
      end,
    },
  },
  column = {
    {
      'lukas-reineke/virt-column.nvim',
      event = { 'BufReadPost', 'BufNewFile' },
      config = function()
        require('virt-column').setup {
          char = '║',
        }
      end,
    },
    {
      'Bekaboo/deadcolumn.nvim',
      event = { 'BufReadPost', 'BufNewFile' },
    },
  },
}

modules.edit = {
  motion = {
    {
      'haya14busa/vim-asterisk',
      event = { 'BufReadPost', 'BufNewFile' },
      config = function()
        require 'young.mod.asterisk'
      end,
    },
    {
      'chaoren/vim-wordmotion',
      event = { 'BufReadPost', 'BufNewFile' },
      init = function()
        vim.g.wordmotion_prefix = ','
        -- disable cmdline short word
        vim.g.wordmotion_mappings = { ['<C-R><C-W>'] = '' }
      end,
    },
    {
      'anuvyklack/vim-smartword',
      event = { 'BufReadPost', 'BufNewFile' },
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
      keys = { 'f', 'F', 't', 'T' },
      event = 'CmdlineEnter',
      auto = true,
    },
    {
      'andymass/vim-matchup',
      event = { 'BufReadPost', 'BufNewFile' },
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
      event = 'VimEnter',
      -- event = { 'BufReadPre', 'BufReadPost', 'BufNewFile' },
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
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require 'young.mod.treesj'
    end,
  },
  {
    'AndrewRadev/splitjoin.vim',
    submodules = false,
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
  { 'tpope/vim-surround', event = { 'BufReadPost', 'BufNewFile' } },
  { 'tpope/vim-repeat', event = { 'BufReadPost', 'BufNewFile' } },
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
    tag = 'v1.0',
    event = { 'BufReadPost', 'BufNewFile' },
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
      -- event = { 'BufReadPost', 'BufNewFile' },
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
      event = { 'BufReadPost', 'BufNewFile' },
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
      event = { 'BufReadPost', 'BufNewFile' },
      dependencies = { 'kevinhwang91/promise-async' },
      auto = true,
    },
  },
  register = {
    {
      'AckslD/nvim-neoclip.lua',
      event = { 'BufReadPost', 'BufNewFile' },
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
      'gbprod/yanky.nvim',
      event = { 'BufReadPost', 'BufNewFile' },
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
      'ojroques/nvim-osc52',
      event = { 'BufReadPost', 'BufNewFile' },
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
      event = { 'BufReadPost', 'BufNewFile' },
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
          desc = 'MarksToggleSigns',
        },
        {
          '<leader>mb',
          function()
            vim.cmd 'MarksListBuf'
          end,
          desc = 'MarksListBuf',
        },
        {
          '<leader>mg',
          function()
            vim.cmd 'MarksListGlobal'
          end,
          desc = 'MarksListGlobal',
        },
        {
          '<leader>ma',
          function()
            vim.cmd 'MarksListAll'
          end,
          desc = 'MarksListAll',
        },
        --
        { '<leader>mL', ':BookmarksList ' },
        {
          '<leader>ml',
          function()
            vim.cmd 'BookmarksListAll'
          end,
          desc = 'BookmarksListAll',
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
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('guess-indent').setup {}
    end,
  },
  -- {
  --   'Darazaki/indent-o-matic',
  --   event = 'BufReadPost',
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
    --   event = { 'BufReadPost', 'BufNewFile' },
    --   auto = 'config',
    -- },
    -- { -- Just Another Buffer Switcher
    --   'matbme/JABS.nvim',
    --   keys = {
    --     { '<cr>', function() vim.cmd 'JABSOpen' end, desc = 'Jump to buffers' },
    --   },
    --   auto = 'config',
    -- },
    { -- Bookmark your files, separated by project
      'otavioschwanck/arrow.nvim',
      cmd = 'Arrow',
      auto = true,
    },
    {
      '0x7a7a/bufpin.nvim',
      -- event = 'VeryLazy',
      event = { 'BufReadPost', 'BufNewFile' },
      auto = true,
    },
  },
  window = {
    {
      'luukvbaal/stabilize.nvim',
      enabled = not xy.has 'nvim-0.9', -- use 'splitkeep' instead
      config = function()
        require('stabilize').setup {}
      end,
    },
    {
      'stevearc/stickybuf.nvim',
      enabled = not xy.has 'nvim-0.10',
      event = { 'BufReadPost', 'BufNewFile' },
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
      submodules = false,
      -- event = "BufReadPost",
      cmd = { 'FocusToggle', 'FocusMaxOrEqual' },
      auto = true,
    },
    -- { -- Smooth focus/split
    --   'anuvyklack/windows.nvim',
    --   event = "BufReadPost",
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
      -- ft = 'qf', -- not working for first time open qf
      event = { 'BufReadPost', 'BufNewFile' },
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
      -- event = "BufReadPost",
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
      submodules = false,
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
        require('young.mod.telescope').cfg.extensions.file_browser = {
          theme = 'ivy',
        }
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
    --   -- event = { 'BufReadPost', 'BufNewFile' },
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
      -- event = 'BufWinEnter',
      -- event = { 'BufReadPost', 'BufNewFile' },
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
        require('young.mod.telescope').cfg.extensions.project = {
          theme = 'dropdown',
          base_dirs = { -- check .git dir for project
            -- { vim.fn.stdpath 'data' .. '/lazy' }, -- Too slow
            -- { '~/work' },
            -- { '~/source' },
            -- { '~/projects' },
            { '~', max_depth = 3 },
          },
          hidden_files = true, -- default: false
          -- order_by = 'recent',
          search_by = { 'title', 'path' }, -- default: 'title'
          -- on_project_selected = function(prompt_bufnr)
          --   -- Do anything you want in here. For example:
          --   local project_actions = require 'telescope._extensions.project.actions'
          --   project_actions.change_working_directory(prompt_bufnr, false)
          --   require('harpoon.ui').nav_file(1)
          -- end,
        }
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
    {
      'backdround/global-note.nvim',
      -- cmd = { 'GlobalNote', 'ProjectNote', 'GitBranchNote' },
      lazy = true,
      auto = true,
    },
  },
  session = {
    {
      'folke/persistence.nvim',
      event = { 'BufReadPost', 'BufNewFile' },
      auto = true,
    },
    {
      'MunifTanjim/exrc.nvim',
      event = { 'BufReadPost', 'BufNewFile' },
      config = function()
        require 'young.mod.exrc'
      end,
    },
  },
  terminal = {
    {
      'akinsho/toggleterm.nvim',
      event = 'VeryLazy',
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
      event = { 'BufReadPost', 'BufNewFile' },
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
  --   event = 'BufReadPost',
  --   config = function()
  --     require 'young.mod.searchbox'
  --   end,
  -- },
  -- {
  --   'kevinhwang91/nvim-hlslens',
  --   -- enabled = not lazy_has 'noice.nvim',
  --   cond = function()
  --     return not lazy_has 'noice.nvim'
  --   end,
  --   event = 'CursorMoved',
  --   auto = true,
  -- },
}

modules.telescope = {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    -- event = { 'BufReadPost', 'BufNewFile' },
    auto = true,
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
        submodules = false,
        init = function()
          lazy_on_load('telescope.nvim', function()
            require('young.mod.telescope').cfg.extensions['zf-native'] = {
              -- options for sorting file-like items
              file = {
                -- override default telescope file sorter
                enable = true,
                -- highlight matching text in results
                highlight_results = true,
                -- enable zf filename match priority
                match_filename = true,
              },
              -- options for sorting all other items
              generic = {
                -- override default telescope generic item sorter
                enable = true,
                -- highlight matching text in results
                highlight_results = true,
                -- disable zf filename match priority
                match_filename = false,
              },
            }
            require('telescope').load_extension 'zf-native'
          end)
        end,
      },
      {
        'nvim-telescope/telescope-smart-history.nvim',
        dependencies = { 'kkharji/sqlite.lua' },
        init = function()
          lazy_on_load('telescope.nvim', function()
            require('telescope').load_extension 'smart_history'
          end)
        end,
      },
    },
  },
  {
    'nvim-telescope/telescope-frecency.nvim',
    dependencies = { 'kkharji/sqlite.lua' },
    lazy = true,
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

      lazy_on_load('telescope.nvim', function()
        vim.cmd 'Lazy load telescope-frecency.nvim'
      end)
    end,
    config = function()
      require('young.mod.telescope').cfg.extensions.frecency = {
        show_scores = true,
        show_unindexed = true,
        show_filter_column = false,
        workspaces = {
          -- [](https://github.com/nvim-telescope/telescope-frecency.nvim/issues/21)
          ['conf'] = vim.fn.expand '~/.config',
          ['share'] = vim.fn.expand '~/.local/share',
          ['dot'] = vim.fn.expand '~/dotter',
          ['beauty'] = vim.fn.expand '~/Beauty',
          ['project'] = vim.fn.expand '~/projects',
          ['source'] = vim.fn.expand '~/source',
          ['wiki'] = vim.fn.expand '~/wiki',
        },
      }
      require('telescope').load_extension 'frecency'
    end,
  },
  {
    'danielfalk/smart-open.nvim',
    dependencies = { 'kkharji/sqlite.lua' },
    lazy = true,
    init = function()
      vim.keymap.set('n', '<leader><leader>', function()
        require('telescope').extensions.smart_open.smart_open {}
      end, { desc = 'Smart frecency', noremap = true })

      lazy_on_load('telescope.nvim', function()
        vim.cmd 'Lazy load smart-open.nvim'
      end)
    end,
    config = function()
      require('young.mod.telescope').cfg.extensions.smart_open = {
        show_scores = true,
        ignore_patterns = { '*.git/*', '*/tmp/*' },
        match_algorithm = 'fzy',
        open_buffer_indicators = { previous = '👀', others = '🙈' },
        buffer_indicators = { previous = '#', others = '*' },
      }
      require('telescope').load_extension 'smart_open'
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
      require('young.mod.telescope').cfg.extensions.live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        mappings = {
          i = {
            ['<C-l>'] = function(prompt_bufnr)
              require('telescope-live-grep-args.actions').quote_prompt()(prompt_bufnr)
            end,
            ['<A-l>'] = function(prompt_bufnr)
              require('telescope-live-grep-args.actions').quote_prompt { postfix = ' --iglob ' }(prompt_bufnr)
            end,
          },
        },
      }
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
        require('young.mod.telescope').cfg.extensions.lazy = {
          theme = 'ivy',
          show_icon = true,
          mappings = {
            open_in_browser = '<C-o>',
            open_in_find_files = '<C-f>',
            open_in_live_grep = '<C-g>',
            open_in_file_browser = '<C-b>',
            open_in_terminal = '<C-t>',
            open_plugins_picker = '<C-o>', -- Works only after having called first another action
            open_lazy_root_find_files = '<C-r>f',
            open_lazy_root_live_grep = '<C-r>g',
            change_cwd_to_plugin = '<C-r>d',
          },
        }
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
          '<leader>s<tab>',
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
          desc = 'Tab prev',
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
    event = { 'BufReadPost', 'BufNewFile' },
    -- event = 'VeryLazy',
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
  --   event = 'BufReadPost',
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
    {
      'debugloop/telescope-undo.nvim',
      keys = {
        {
          '<leader>sU',
          function()
            vim.cmd 'Telescope undo'
          end,
          desc = 'Undo',
        },
      },
      config = function()
        require('young.mod.telescope').cfg.extensions.undo = {
          layout_strategy = 'vertical',
          -- theme = 'ivy',
          use_delta = true,
          use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
          side_by_side = true,
          diff_context_lines = vim.o.scrolloff,
          entry_format = 'state #$ID, $STAT, $TIME',
          time_format = '',
          saved_only = false,
          mappings = {
            i = {
              -- ['<cr>'] = require('telescope-undo.actions').yank_additions,
              -- ['<S-cr>'] = require('telescope-undo.actions').yank_deletions,
              -- ['<C-cr>'] = require('telescope-undo.actions').restore,
              -- alternative defaults, for users whose terminals do questionable things with modified <cr>
              -- ['<C-y>'] = function() require('telescope-undo.actions').yank_deletions end,
              -- ['<C-r>'] = function() require('telescope-undo.actions').restore end,
            },
          },
        }
        require('telescope').load_extension 'undo'
      end,
    },
  },
}

modules.keymap = {
  { 'anuvyklack/keymap-amend.nvim', lazy = true },

  menu = {
    {
      'folke/which-key.nvim',
      event = 'VimEnter', -- not VeryLazy
      -- event = { 'BufReadPost', 'BufNewFile' },
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
      -- event = 'VeryLazy',
      event = { 'BufReadPost', 'BufNewFile' },
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
    event = 'VimEnter', -- not VeryLazy
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
      -- require('telescope').load_extension 'notify'
      require('young.mod.notify').done()
    end,
  },
  {
    'folke/trouble.nvim',
    -- event = 'BufReadPost',
    cmd = { 'Trouble', 'TroubleToggle' },
    auto = true,
  },
  {
    'stevearc/dressing.nvim',
    event = 'VimEnter', -- not VeryLazy
    -- event = { 'BufReadPost', 'BufNewFile' },
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
      event = { 'BufReadPost', 'BufNewFile' },
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
    --   event = { 'BufReadPost', 'BufNewFile' },
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
    -- { -- NOTE: Session limitation: all hidden buffers are dropped after session loaded
    --   'backdround/tabscope.nvim',
    --   event = 'VeryLazy',
    --   config = function()
    --     require('tabscope').setup {}
    --     vim.keymap.set('n', '<leader>bc', function()
    --       require('tabscope').remove_tab_buffer()
    --     end, { desc = 'Close buffer in current tab' })
    --   end,
    -- },
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
      event = xy.has 'nvim-0.8' and 'LspAttach' or 'BufReadPost',
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
    --   event = { 'BufReadPost', 'BufNewFile' },
    --   config = function()
    --     require 'young.mod.lualine'
    --   end,
    -- },
    {
      'freddiehaddad/feline.nvim',
      event = { 'BufReadPost', 'BufNewFile' },
      opts = {},
      config = function(_, opts)
        require 'young.mod.feline'
      end,
    },
    -- {
    --   'rebelot/heirline.nvim',
    --   event = { 'BufReadPost', 'BufNewFile' },
    --   config = function()
    --     require('heirline').setup {}
    --   end,
    -- },
  },
  statuscolumn = {
    {
      'luukvbaal/statuscol.nvim',
      enabled = xy.has 'nvim-0.9',
      event = { 'BufReadPost', 'BufNewFile' },
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
    --   event = 'BufReadPost',
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
      -- event = 'VimEnter',
      config = function()
        -- require('alpha').setup(require('young.mod.alpha.screen').opts)
        require('young.mod.alpha').done()
        -- vim.cmd[[doautocmd BufReadPost]]
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
    --   event = { 'BufReadPost', 'BufNewFile' },
    --   config = function()
    --     require 'young.mod.scrollview'
    --   end,
    -- },
    {
      'petertriho/nvim-scrollbar',
      -- after = 'nvim-hlslens',
      event = { 'BufReadPost', 'BufNewFile' },
      auto = 'config',
    },
    -- {
    --   'lewis6991/satellite.nvim',
    --   enabled = xy.has 'nvim-0.10',
    --   event = { 'BufReadPost', 'BufNewFile' },
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
      -- build = 'make install_jsregexp', -- install jsregexp (optional!).
      submodules = false,
      event = 'InsertEnter',
      -- lazy = true,
      config = function()
        require 'young.mod.luasnip'
      end,
      dependencies = {
        { 'saadparwaiz1/cmp_luasnip' },
      },
    },
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
      dependencies = {
        {
          'rcarriga/cmp-dap',
          config = function()
            require('cmp').setup.filetype({ 'dap-repl', 'dapui_watches' }, {
              sources = {
                { name = 'dap' },
              },
            })
          end,
        },
      },
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
      auto = true,
    },
  },
}

modules.LSP = {
  {
    'neovim/nvim-lspconfig',
    -- event = 'VimEnter',
    event = { 'BufReadPre', 'BufReadPost', 'BufNewFile' },
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
      {
        'nvimtools/none-ls.nvim',
        config = function()
          require('young.lsp.null_ls').done()
        end,
      },
      { 'b0o/SchemaStore.nvim' },
    },
  },
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
      event = xy.has 'nvim-0.8' and 'LspAttach' or 'BufReadPost',
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
    --   event = xy.has 'nvim-0.8' and 'LspAttach' or 'BufReadPost',
    --   config = function()
    --     require 'young.mod.lightbulb'
    --   end,
    -- },
    {
      'j-hui/fidget.nvim',
      event = xy.has 'nvim-0.8' and 'LspAttach' or 'BufReadPost',
      config = function()
        require('young.mod.fidget').done()
      end,
      tag = 'legacy',
    },
    {
      'Maan2003/lsp_lines.nvim',
      -- 'ErichDonGubler/lsp_lines.nvim',
      event = xy.has 'nvim-0.8' and 'LspAttach' or 'BufReadPost',
      config = function()
        require('young.mod.lsp_lines').done()
      end,
    },
    -- {
    --   'VidocqH/lsp-lens.nvim',
    --   event = xy.has 'nvim-0.8' and 'LspAttach' or 'BufReadPost',
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
    -- {
    --   'Wansmer/symbol-usage.nvim',
    --   -- event = xy.has 'nvim-0.8' and 'LspAttach' or 'BufReadPost',
    --   event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    --   auto = 'config',
    -- },
  },
  highlight = {
    { -- Highlighting the word under the cursor
      'RRethy/vim-illuminate',
      enabled = not require('young.lsp.config').document_highlight,
      -- event = 'BufWinEnter',
      -- event = 'VeryLazy',
      event = { 'BufReadPost', 'BufNewFile' },
      config = function()
        require 'young.mod.illuminate'
      end,
    },
    {
      'm-demare/hlargs.nvim',
      event = { 'BufReadPost', 'BufNewFile' },
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
        require('young.mod.telescope').cfg.extensions.coc = {
          theme = 'ivy',
          prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
        }
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
    {
      'ii14/neorepl.nvim',
      cmd = 'Repl', -- :Repl {lang} Starts a new REPL instance. Optional {lang} can be "lua" or "vim".
      auto = true,
    },
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
          desc = 'Database UI',
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
      -- event = { 'BufReadPost', 'BufNewFile' },
      cmd = { 'TodoQuickFix', 'TodoLocList', 'TodoTelescope', 'TodoTrouble' },
      dependencies = 'nvim-lua/plenary.nvim',
      init = function()
        xy.map.n {
          '<leader>st',
          function()
            vim.cmd 'TodoTelescope'
          end,
          'Todo telescope',
        }
        xy.map.n {
          '<leader>xt',
          function()
            vim.cmd 'TodoTrouble'
          end,
          'Todo trouble',
        }
        xy.map.n {
          '<leader>ot',
          function()
            vim.cmd 'TodoQuickFix'
          end,
          'Todo qf',
        }
        xy.map.n {
          '<leader>oT',
          function()
            vim.cmd 'TodoLocList'
          end,
          'Todo locList',
        }
      end,
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
        require('young.mod.telescope').cfg.extensions.heading = {
          treesitter = true,
        }
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
      keys = { { 'gx', desc = '[gx] extended' } },
      auto = 'config',
    },
    {
      'itchyny/vim-external', -- TODO:gx in WSL
      event = { 'BufReadPost', 'BufNewFile' },
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
          'BrowserBookmarks',
        }
        xy.map.n { '<leader>aB', ':BrowserBookmarks ' }
      end,
      config = function()
        require('browser_bookmarks').setup {
          selected_browser = 'chrome', -- Available: 'brave', 'google_chrome', 'safari', 'firefox',
          url_open_command = xy.open_cmd, -- url_open_plugin = 'external_browser',
          -- Show the full path to the bookmark instead of just the bookmark name
          full_path = true,
          -- Provide a custom profile name for Firefox
          firefox_profile_name = nil,
        }
      end,
    },
  },
  website = {
    {
      'wakatime/vim-wakatime',
      event = { 'BufReadPost', 'BufNewFile' },
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
    --   event = 'BufReadPost',
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
        'Hexmode',
      }
      -- vim.g.hexmode_patterns = '*.bin,*.exe,*.dat,*.o,*.jpg,*.png'
    end,
  },
  {
    'echasnovski/mini.nvim',
    version = false,
    -- event = 'VimEnter',
    auto = 'config',
  },
  {
    'mattn/calendar-vim',
    cmd = 'Calendar',
    init = function()
      xy.map.n {
        '<leader>tc',
        function()
          vim.cmd 'Calendar'
        end,
        'Calendar',
      }
    end,
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
      -- xy.autogroup('_lazy_init_' .. plug_name, {
      --   {
      --     'User',
      --     'LazyDone',
      --     function()
      --     end,
      --   },
      -- })
      local m = require(mod_path)
      if type(m) == 'table' and m.once and type(m.once) == 'function' then
        m.once()
      end
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
