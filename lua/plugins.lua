local runtime_dir = vim.fn.stdpath 'data'
local install_path = join_paths(runtime_dir, 'site', 'pack', 'packer', 'start', 'packer.nvim')

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  -- vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.fn.system { 'git', 'clone', '--depth', '3', 'https://github.com/wbthomason/packer.nvim', install_path }
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]]

local packer = require 'packer'
packer.init {
  profile = {
    enable = true,
  },
  display = {
    open_fn = function()
      -- return require("packer.util").float { border = "rounded" }
      return require('packer.util').float { border = 'double' }
    end,
  },
}

local use = require('packer').use
return packer.startup(function(use)
  use { 'wbthomason/packer.nvim' }

  -- UI
  use {
    'romgrk/barbar.nvim',
    event = 'BufWinEnter',
    config = function()
      require('young.mod.barbar').hot()
    end,
  }
  use { 'nvim-lualine/lualine.nvim', config = require 'plug-config.lualine' }
  -- use({ "NTBBloodbath/galaxyline.nvim", config = require("plug-config.galaxyline")})
  use { 'kyazdani42/nvim-tree.lua', config = require 'plug-config.nvim-tree', event = 'BufWinEnter' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'goolord/alpha-nvim', config = require 'plug-config.alpha' }
  use {
    'akinsho/toggleterm.nvim',
    event = 'BufWinEnter',
    config = function()
      require 'young.mod.toggleterm'.done()
    end
  }
  use { 'folke/trouble.nvim', config = require 'plug-config.lsp-trouble', event = 'BufWinEnter' }

  -- Colorscheme & Colors
  use { 'nvim-treesitter/nvim-treesitter', config = require 'plug-config.treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/playground' }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'plug-config.colorizer'
    end,
  }
  use 'rktjmp/lush.nvim'
  use { 'RRethy/vim-illuminate', config = require 'plug-config.illuminate', event = 'BufWinEnter' }
  use 'joshdick/onedark.vim'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('young.mod.telescope').done()
    end,
  }
  use {
    'nvim-telescope/telescope-frecency.nvim',
    requires = { 'tami5/sql.nvim' },
  }

  -- Web Dev
  use { 'windwp/nvim-ts-autotag', ft = { 'html', 'svelte' } }

  -- Autocomplete
  use { 'hrsh7th/nvim-cmp', config = require 'plug-config.cmp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
  use { 'L3MON4D3/LuaSnip', after = 'nvim-cmp' }
  use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-calc', after = 'nvim-cmp' }

  -- LSP
  use { 'neovim/nvim-lspconfig' }
  use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = require 'plug-config.gitsigns',
    event = 'BufWinEnter',
  }

  -- Editing Enhancments
  use { 'windwp/nvim-autopairs', event = 'InsertEnter', config = require 'plug-config.autopairs' }
  use {
    'folke/todo-comments.nvim',
    event = 'InsertEnter',
    requires = 'nvim-lua/plenary.nvim',
    config = require 'plug-config.todo-comments',
  }

  -- General Plugins
  use { 'ahmedkhalf/project.nvim', config = require 'plug-config.project', event = 'BufWinEnter' }
  use {
    'folke/which-key.nvim',
    config = function()
      require('young.key.which-key').done()
    end,
    event = 'BufWinEnter',
  }
  use {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    module = 'persistence',
    config = require 'plug-config.persistence',
  }
  use { 'nvim-neorg/neorg', branch = 'unstable', config = require 'plug-config.neorg', ft = 'norg' }
  use {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup()
    end,
  }
  use { 'folke/lua-dev.nvim' }
  use { 'nanotee/luv-vimdocs' }
  use { 'pianocomposer321/yabs.nvim', config = require 'plug-config.yabs' }

  use {
    'luukvbaal/stabilize.nvim',
    config = function()
      require('stabilize').setup()
    end,
  }

  -- Tests
  use { 'edluffy/specs.nvim' }

  -- Self plugin
  use { 'MordechaiHadad/nvim-lspmanager', config = require 'plug-config.lspmanager' }

  use {
    'ZSaberLv0/ZFVimDirDiff',
    cmd = { 'ZFDirDiff', 'ZFDirDiffMark' },
    setup = function()
      vim.g.ZFDirDiffUI_dirExpandable = '+'
    end,
  }
end)
