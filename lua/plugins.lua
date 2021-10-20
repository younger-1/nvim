local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute 'packadd packer.nvim'
end -- Bootstrap packer so it auto installs everywhere

vim.cmd [[packadd packer.nvim]]

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'
local packer = require 'packer'

packer.init {
  max_jobs = 4,
  profile = {
    enable = true,
  },
}

return require('packer').startup(function(use)
  -- Packer can manage itself as an optional plugin
  use { 'wbthomason/packer.nvim', opt = true }

  -- UI
  use { 'romgrk/barbar.nvim', config = require 'plug-config.barbar' }
  use { 'shadmansaleh/lualine.nvim', config = require 'plug-config.lualine' }
  -- use({ "NTBBloodbath/galaxyline.nvim", config = require("plug-config.galaxyline")})
  use { 'kyazdani42/nvim-tree.lua', config = require 'plug-config.nvim-tree', cmd = 'NvimTreeToggle' }
  use { 'kyazdani42/nvim-web-devicons', module = 'nvim-web-devicons' }
  use { 'goolord/alpha-nvim', config = require 'plug-config.alpha' }
  use { 'akinsho/toggleterm.nvim', config = require 'plug-config.toggleterm' }
  use { 'folke/trouble.nvim', config = require 'plug-config.lsp-trouble', event = 'BufWinEnter' }

  -- Colorscheme & Colors
  use { 'nvim-treesitter/nvim-treesitter', config = require 'plug-config.treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'
  use 'norcalli/nvim-colorizer.lua'
  use 'rktjmp/lush.nvim'
  use { 'RRethy/vim-illuminate', config = require 'plug-config.illuminate', event = 'BufWinEnter' }
  use 'joshdick/onedark.vim'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    cmd = 'Telescope',
    config = require 'plug-config.telescope',
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
  use { 'b3nj5m1n/kommentary', event = 'BufWinEnter' }
  use { 'windwp/nvim-autopairs', event = 'InsertEnter', config = require 'plug-config.autopairs' }
  use {
    'folke/todo-comments.nvim',
    event = 'InsertEnter',
    requires = 'nvim-lua/plenary.nvim',
    config = require 'plug-config.todo-comments',
  }

  -- General Plugins
  use { 'ahmedkhalf/project.nvim', config = require 'plug-config.project', event = 'BufWinEnter' }
  use { 'folke/which-key.nvim', config = require 'plug-config.which-key', event = 'BufWinEnter' }
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
end)
