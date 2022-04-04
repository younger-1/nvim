local utils = require 'young.utils'
local M = {}

setmetatable(M, {
  __index = function(t, k)
    error(k .. ' is not a valid module section!')
  end,
})

M.basic = {
  { 'wbthomason/packer.nvim' },
  { 'lewis6991/impatient.nvim' },
  { 'antoinemadec/FixCursorHold.nvim' }, -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  {
    'nathom/filetype.nvim',
    -- opt = true,
    setup = function() end,
    config = function()
      require('young.mod.filetype').done()
    end,
  },
}

M.theme = {
  -- { 'rktjmp/lush.nvim' },

  vim = {
    'joshdick/onedark.vim',
    'sainnhe/sonokai',
    'sainnhe/edge',
    'sainnhe/everforest',
    'sainnhe/gruvbox-material',
  },

  lua = {
    {
      'shaunsingh/nord.nvim',
      setup = function()
        vim.g.nord_borders = true
      end,
    },
    'tanvirtin/monokai.nvim',
    'rebelot/kanagawa.nvim',
    'ellisonleao/gruvbox.nvim',
    'projekt0n/github-nvim-theme',
    'mvpopuk/inspired-github.vim',
    'EdenEast/nightfox.nvim',
    {
      'marko-cerovac/material.nvim',
      setup = function()
        vim.g.material_style = 'palenight'
      end,
    },
  },
}

M.appearance = {
  icon = {
    { 'kyazdani42/nvim-web-devicons' },
  },
  color = {
    {
      'norcalli/nvim-colorizer.lua',
      event = 'BufRead',
      config = function()
        require 'young.mod.colorizer'
      end,
    },
  },
  indent = {
    {
      'lukas-reineke/indent-blankline.nvim',
      event = 'BufRead',
      config = function()
        require('young.mod.indent-blankline').done()
      end,
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
      config = function()
        require('young.mod.specs').done()
      end,
    },
  },
}

M.edit = {
  motion = {
    {
      'haya14busa/vim-asterisk',
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
      'ggandor/lightspeed.nvim',
      event = 'BufWinEnter',
      config = function()
        -- require 'young.mod.lightspeed'
      end,
    },
    {
      'andymass/vim-matchup',
      event = 'CursorMoved',
      config = function()
        require 'young.mod.matchup'
      end,
    },
    -- {
    --   'abecodes/tabout.nvim',
    --   config = function()
    --     require('tabout').setup()
    --   end,
    -- },
  },
  -- textobject = {
  -- },
  treesitter = {
    {
      'nvim-treesitter/nvim-treesitter',
      branch = vim.fn.has 'nvim-0.6' == 1 and 'master' or '0.5-compat',
      run = ':TSUpdate',
      config = function()
        require('young.mod.treesitter').done()
      end,
    },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'nvim-treesitter/nvim-treesitter-refactor' },
    { 'nvim-treesitter/playground' },
  },
}

M.change = {
  core = {
    { 'tpope/vim-surround' },
    { 'tpope/vim-repeat' },
    { 'tpope/vim-abolish' },
  },
  pair = {
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
        require 'young.mod.autopairs'
      end,
    },
  },
  comment = {
    {
      'numToStr/Comment.nvim',
      event = 'BufRead',
      config = function()
        require 'young.mod.comment'
      end,
    },
  },
  other = {
    {
      'arthurxavierx/vim-caser',
      setup = function()
        vim.g.caser_prefix = ';c'
      end,
    },
    {
      'junegunn/vim-easy-align',
      cmd = { 'EasyAlign', 'LiveEasyAlign' },
      keys = { '<Plug>(EasyAlign)', '<Plug>(LiveEasyAlign)' },
      setup = function()
        require 'young.mod.easy-align'
      end,
    },
    {
      'mg979/vim-visual-multi',
      cmd = { 'VMDebug', 'VMLive', 'VMRegisters', 'VMSearch' },
      setup = function()
        vim.g.VM_default_mappings = 0
      end,
    },
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

M.neovim = {
  profile = {
    {
      'dstein64/vim-startuptime',
      cmd = 'StartupTime',
      setup = function()
        vim.g.startuptime_use_blocks = 0
      end,
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
  {
    'winston0410/range-highlight.nvim',
    event = 'CmdlineEnter',
    requires = { { 'winston0410/cmd-parser.nvim', module = 'cmd-parser' } },
    config = function()
      require('range-highlight').setup {}
    end,
  },
  {
    'lambdalisue/suda.vim',
    config = function()
      vim.g['suda#prompt'] = '🔑: '
    end,
  },
}

M.BWT = {
  window = {
    {
      'luukvbaal/stabilize.nvim',
      config = function()
        require('stabilize').setup {}
      end,
    },
    { 'dhruvasagar/vim-zoom' },
    {
      'mrjones2014/smart-splits.nvim',
      disable = vim.fn.has 'nvim-0.7',
      event = 'BufWinEnter',
      config = function()
        require 'young.mod.smart-splits'
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

M.file = {
  project = {
    {
      -- 'ahmedkhalf/project.nvim',
      'younger-1/project.nvim',
      branch = 'add-patterns-fallback',
      config = function()
        require 'young.mod.project'
      end,
    },
  },
  session = {
    {
      'folke/persistence.nvim',
      event = 'BufRead',
      module = 'persistence',
      config = function()
        require 'young.mod.persistence'
      end,
    },
  },
  dir = {
    {
      'tamago324/lir.nvim',
      config = function()
        require 'young.mod.lir'
      end,
    },
    {
      'ZSaberLv0/ZFVimDirDiff',
      cmd = { 'ZFDirDiff', 'ZFDirDiffMark' },
      setup = function()
        vim.g.ZFDirDiffUI_dirExpandable = '+'
      end,
    },
  },
}

M.find = {
  core = {
    {
      'windwp/nvim-spectre',
      event = 'BufRead',
      config = function()
        -- require("user.spectre").config()
      end,
    },
    {
      'VonHeikemen/searchbox.nvim',
      requires = { { 'MunifTanjim/nui.nvim' } },
      -- module = 'searchbox',
      event = 'BufRead',
      config = function()
        require 'young.mod.searchbox'
      end,
    },
  },
  fzf = {
    {
      'ibhagwan/fzf-lua',
      module = 'fzf-lua',
      config = function()
        require 'young.mod.fzf'
      end,
      disable = is_windows,
    },
  },
}

M.telescope = {
  core = {
    {
      'nvim-telescope/telescope.nvim',
      requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
      config = function()
        require('young.mod.telescope').done()
      end,
    },
    {
      'natecraddock/telescope-zf-native.nvim',
      config = function()
        require('telescope').load_extension 'zf-native'
      end,
    },
    {
      'nvim-telescope/telescope-file-browser.nvim',
      config = function()
        require('telescope').load_extension 'file_browser'
      end,
    },
    { 'nvim-telescope/telescope-symbols.nvim' },
  },
  other = {
    {
      'nvim-telescope/telescope-packer.nvim',
      config = function()
        require('telescope').load_extension 'packer'
      end,
    },
    {
      'jvgrootveld/telescope-zoxide',
      config = function()
        require('telescope').load_extension 'zoxide'
        require('telescope._extensions.zoxide.config').setup {
          prompt_title = '[ Z⏫ ]',
        }
      end,
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      requires = { { 'tami5/sqlite.lua', module = 'sqlite' } },
    },
    {
      'AckslD/nvim-neoclip.lua',
      requires = { { 'tami5/sqlite.lua', module = 'sqlite' } },
      config = function()
        require 'young.mod.neoclip'
      end,
    },
    {
      'dhruvmanila/telescope-bookmarks.nvim',
      requires = { { 'tami5/sqlite.lua', module = 'sqlite' } },
      config = function()
        require('telescope').load_extension 'bookmarks'
      end,
    },
    {
      'LinArcX/telescope-env.nvim',
      config = function()
        require('telescope').load_extension 'env'
      end,
    },
    {
      'LinArcX/telescope-command-palette.nvim',
      config = function()
        require('telescope').load_extension 'command_palette'
      end,
    },
    {
      'cljoly/telescope-repo.nvim',
      config = function()
        require('telescope').load_extension 'repo'
      end,
    },
  },
}

M.git = {
  {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    event = 'BufRead',
    config = function()
      require('young.mod.gitsigns').done()
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
  {
    'tpope/vim-fugitive',
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
    'nvim-telescope/telescope-github.nvim',
    config = function()
      require('telescope').load_extension 'gh'
    end,
  },
  {
    'ruifm/gitlinker.nvim',
    event = 'BufRead',
    config = function()
      require('young.mod.gitlinker').done()
    end,
  },
}

M.UI = {
  core = {
    {
      'kyazdani42/nvim-tree.lua',
      event = 'BufWinEnter',
      config = function()
        require('young.mod.nvim-tree').done()
      end,
    },
    {
      'rcarriga/nvim-notify',
      event = 'BufWinEnter',
      config = function()
        require('young.mod.notify').done()
      end,
    },
    {
      'folke/which-key.nvim',
      event = 'BufWinEnter',
      config = function()
        require('young.key.which-key').done()
      end,
    },
    {
      'folke/trouble.nvim',
      event = 'BufRead',
      config = function()
        require('young.mod.trouble').done()
      end,
    },
    { 'stevearc/dressing.nvim' },
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
  },
  bufferline = {
    {
      'romgrk/barbar.nvim',
      event = 'BufWinEnter',
      config = function()
        require('young.mod.barbar').hot()
      end,
    },
  },
  statusline = {
    -- { 'NTBBloodbath/galaxyline.nvim', config = require('plug-config.galaxyline')}
    {
      'nvim-lualine/lualine.nvim',
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
  },
  cmdline = {
    {
      'VonHeikemen/fine-cmdline.nvim',
      requires = { { 'MunifTanjim/nui.nvim' } },
      -- cmd = 'FineCmdline',
      event = 'BufRead',
      config = function()
        require 'young.mod.fine-cmd'
      end,
    },
    -- {
    --   'gelguy/wilder.nvim',
    --   event = 'CmdlineEnter',
    --   config = function()
    --     require 'young.mod.wilder'
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
  },
  screen = {
    {
      'goolord/alpha-nvim',
      config = function()
        -- require('alpha').setup(require('young.mod.alpha.screen').opts)
        require('young.mod.alpha').done()
      end,
    },
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
      event = 'BufWinEnter',
      config = function()
        require('scrollbar').setup()
        -- require('scrollbar.handlers.search').setup()
      end,
    },
  },
}

M.code = {
  completion = {
    {
      'hrsh7th/nvim-cmp',
      config = function()
        require('young.mod.cmp').done()
      end,
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
          config = function()
            require('cmp_git').setup()
          end,
        },
      },
    },
    { 'onsails/lspkind-nvim' },
    { 'rafamadriz/friendly-snippets' },
    -- {
    --   "github/copilot.vim",
    --   requires = { 'hrsh7th/cmp-copilot' },
    --   -- setup = function()
    --   --   vim.g.copilot_filetypes = {
    --   --     ["TelescopePrompt"] = false,
    --   --   }
    --   -- end,
    -- },
  },
  -- task = {
  --   { 'tpope/vim-dispatch' },
  --   { 'pianocomposer321/yabs.nvim', config = require 'young.mod.yabs' },
  -- },
}

M.LSP = {
  core = {
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/nvim-lsp-installer' },
    -- { "jose-elias-alvarez/null-ls.nvim" },
    { 'b0o/SchemaStore.nvim' },
    {
      'ray-x/lsp_signature.nvim',
      event = 'BufRead',
      config = function()
        require 'young.mod.lsp-signature'
      end,
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
      config = function()
        require 'young.mod.lightbulb'
      end,
    },
    {
      'j-hui/fidget.nvim',
      config = function()
        require('young.mod.fidget').done()
      end,
    },
    -- { -- TODO:
    --   'ErichDonGubler/lsp_lines.nvim',
    --   config = function()
    --     require('lsp_lines').register_lsp_virtual_lines()
    --   end,
    -- },
  },
}

M.lang = {
  js = {
    {
      'vuki656/package-info.nvim',
      ft = 'json',
      requires = { { 'MunifTanjim/nui.nvim' } },
      config = function()
        require 'young.mod.package-info'
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
    -- 'gpanders/nvim-parinfer',
    {
      'eraserhd/parinfer-rust',
      run = 'cargo build --release',
      ft = { 'clojure', 'scheme', 'lisp', 'fennel', 'racket', 'fennel', 'hy' },
    },
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

M.write = {
  core = {
    {
      'crispgm/telescope-heading.nvim',
      config = function()
        require('telescope').load_extension 'heading'
      end,
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
      config = function()
        require 'young.mod.neorg'
      end,
    },
  },
  markdown = {
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
}

M.tool = {
  open = {
    {
      'itchyny/vim-external',
      config = function()
        vim.cmd [[
          map <Leader>aee <Plug>(external-editor)
          map <Leader>aen <Plug>(external-explorer)
          map <Leader>aeb <Plug>(external-browser)
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
  --     setup = [[require 'young.mod.ZFVimIM']],
  --     requires = {
  --       { 'ZSaberLv0/ZFVimJob', after = 'ZFVimIM' },
  --       { 'ZSaberLv0/ZFVimIM_openapi', after = 'ZFVimJob' },
  --     },
  --   },
  -- }
}

for _, module in pairs(M) do
  setmetatable(module, {
    __call = function(t, ...)
      local plugs = {}
      for key, item in pairs(module) do
        if type(key) == 'number' then
          plugs[#plugs + 1] = item
        elseif #{ ... } > 0 then
          if vim.tbl_contains({ ... }, key) then
            utils.append_to_list(plugs, item)
          end
        else
          utils.append_to_list(plugs, item)
        end
      end
      if #plugs == 1 then
        return unpack(plugs) -- avoid return { { "foo" } } to packer
      end
      return plugs
    end,
  })
end

M.done = function()
  return {
    M.BWT(),
    M.LSP(),
    M.UI(),
    M.appearance(),
    M.basic(),
    M.change(),
    M.code(),
    M.edit(),
    M.file(),
    M.find(),
    M.git(),
    M.lang('lisp', 'java'),
    M.neovim(),
    M.telescope(),
    M.theme(),
    M.tool(),
    M.write(),
  }
end

return M
