-- local Log = require "lvim.core.log"

local M = {}

local function apply_defaults(configs, defaults)
  configs = configs or {}
  return vim.tbl_deep_extend("keep", configs, defaults)
end

function M.once()
  require 'young.utils.global'

  require 'young.cfg.global'
  require 'young.cfg.option'
  require 'young.cfg.autocmds'

  require 'young.key.mappings'

  require('young.key.which-key').ice()
  vim.g.mapleader = ' '

  -- local lvim_lsp_config = require "lvim.lsp.config"
  -- lvim.lsp = apply_defaults(lvim.lsp, vim.deepcopy(lvim_lsp_config))
  -- 
  -- local supported_languages = require "lvim.config.supported_languages"
  -- require("lvim.lsp.manager").init_defaults(supported_languages)
end

function M.reload()
  package.loaded["young.plugins"] = nil

  local loader = require "young.plugin-loader"
  loader.cache_clear()
  loader.load()

  vim.cmd ":PackerInstall"
  vim.cmd ":PackerCompile"
  -- vim.cmd ":PackerClean"

  -- require("lvim.lsp").setup()

  -- Log:info "Reloaded configuration"
end

function M.get_reload_path()
  return join_paths(vim.fn.stdpath 'config', 'lua', 'young', 'plugins.lua')
end

return M
