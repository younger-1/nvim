return {
  { 'wbthomason/packer.nvim' },

  -- UI
  {
    'romgrk/barbar.nvim',
    event = 'BufWinEnter',
    config = function()
      require('young.mod.barbar').hot()
    end,
  },
  { 'nvim-lualine/lualine.nvim', config = require 'plug-config.lualine' },
  -- use({ "NTBBloodbath/galaxyline.nvim", config = require("plug-config.galaxyline")})
  { 'kyazdani42/nvim-tree.lua', config = require 'plug-config.nvim-tree', event = 'BufWinEnter' },
  { 'kyazdani42/nvim-web-devicons' },
  { 'goolord/alpha-nvim', config = require 'plug-config.alpha' },
  {
    'akinsho/toggleterm.nvim',
    event = 'BufWinEnter',
    config = function()
      require('young.mod.toggleterm').done()
    end,
  },
  {
    'folke/trouble.nvim',
    event = 'BufWinEnter',
    config = function()
      require('young.mod.trouble').done()
    end,
  },

  -- Colorscheme & Colors
  { 'nvim-treesitter/nvim-treesitter', config = require 'plug-config.treesitter', run = ':TSUpdate' },
  { 'nvim-treesitter/playground' },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'plug-config.colorizer'
    end,
  },
  -- { 'rktjmp/lush.nvim' },
  { 'RRethy/vim-illuminate', config = require 'plug-config.illuminate', event = 'BufWinEnter' },
  { 'joshdick/onedark.vim' },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('young.mod.telescope').done()
    end,
  },
  {
    'nvim-telescope/telescope-frecency.nvim',
    requires = { 'tami5/sql.nvim' },
  },

  -- Web Dev
  { 'windwp/nvim-ts-autotag', ft = { 'html', 'svelte' } },

  -- Autocomplete
  { 'hrsh7th/nvim-cmp', config = require 'plug-config.cmp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
  { 'L3MON4D3/LuaSnip', after = 'nvim-cmp' },
  { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },

  -- LSP
  { 'neovim/nvim-lspconfig' },
  { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' },

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = require 'plug-config.gitsigns',
    event = 'BufWinEnter',
  },

  -- Editing Enhancments
  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = require 'plug-config.autopairs' },
  {
    'folke/todo-comments.nvim',
    event = 'InsertEnter',
    requires = 'nvim-lua/plenary.nvim',
    config = require 'plug-config.todo-comments',
  },

  -- General Plugins
  { 'ahmedkhalf/project.nvim', config = require 'plug-config.project', event = 'BufWinEnter' },
  {
    'folke/which-key.nvim',
    config = function()
      require('young.key.which-key').done()
    end,
    event = 'BufWinEnter',
  },
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    module = 'persistence',
    config = require 'plug-config.persistence',
  },
  { 'nvim-neorg/neorg', branch = 'unstable', config = require 'plug-config.neorg', ft = 'norg' },
  -- {
  --   'abecodes/tabout.nvim',
  --   config = function()
  --     require('tabout').setup()
  --   end,
  -- },
  { 'folke/lua-dev.nvim' },
  { 'nanotee/luv-vimdocs' },
  { 'pianocomposer321/yabs.nvim', config = require 'plug-config.yabs' },

  {
    'luukvbaal/stabilize.nvim',
    config = function()
      require('stabilize').setup()
    end,
  },

  -- Tests
  { 'edluffy/specs.nvim' },

  -- Self plugin
  -- { 'MordechaiHadad/nvim-lspmanager', config = require 'plug-config.lspmanager' },

  {
    'ZSaberLv0/ZFVimDirDiff',
    cmd = { 'ZFDirDiff', 'ZFDirDiffMark' },
    setup = function()
      vim.g.ZFDirDiffUI_dirExpandable = '+'
    end,
  },

  {
    'nathom/filetype.nvim',
    -- opt = true,
    setup = function() end,
    config = function()
      require('young.mod.filetype').done()
    end,
  },
}
