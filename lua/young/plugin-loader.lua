local plugin_loader = {}

local utils = require 'young.utils'
-- local Log = require "lvim.core.log"

local runtime_dir = vim.fn.stdpath 'data'
local config_dir = vim.fn.stdpath 'config'
local install_path = join_paths(runtime_dir, 'site', 'pack', 'packer', 'start', 'packer.nvim')
local compile_path = join_paths(config_dir, 'lua', 'young', 'packer_compiled.lua')

local _, packer = pcall(require, 'packer')

plugin_loader.once = function()
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    -- vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.fn.system { 'git', 'clone', '--depth', '3', 'https://github.com/wbthomason/packer.nvim', install_path }
  end

  require('packer').init {
    compile_path = compile_path,
    log = { level = 'warn' },
    profile = { enable = true },
    display = {
      open_fn = function()
        -- return require("packer.util").float { border = "rounded" }
        return require('packer.util').float { border = 'double' }
      end,
    },
  }
end

plugin_loader.cache_clear = function()
  if vim.fn.delete(compile_path) == 0 then
    -- Log:debug "deleted packer_compiled.lua"
  end
end

plugin_loader.recompile = function()
  plugin_loader.cache_clear()
  packer.compile()
  if utils.is_file(compile_path) then
    -- Log:debug "generated packer_compiled.lua"
  vim.wait(5000, compiled_ok)
  require 'young.packer_compiled'
  end
end

plugin_loader.load = function()
  local plugins = require('young.plugins').done()
  -- Log:debug "loading plugins configuration"
  local status_ok, _ = xpcall(function()
    packer.startup(function(use)
      for _, plugin in ipairs(plugins) do
        use(plugin)
      end
    end)
  end, debug.traceback)
  if not status_ok then
    vim.notify('[young.plugin-loader]: loading plugins', vim.log.levels.WARN)
    -- Log:warn "problems detected while loading plugins' configurations"
    -- Log:trace(debug.traceback())
    return
  end
end

-- @young
plugin_loader.source_compiled = function()
  if not utils.is_file(compile_path) then
    packer.compile()
    -- vim.notify('[young.plugin-loader]: not find packer_compiled.lua', vim.log.levels.WARN)
    -- return
  end

  -- TODO: use vim.defer_fn(), plenary's async, timer_start(), wait()
  local compiled_ok = function()
    return utils.is_file(compile_path)
  end
  vim.wait(5000, compiled_ok)
  require 'young.packer_compiled'
end

plugin_loader.done = function()
  plugin_loader.once()
  plugin_loader.load()
  plugin_loader.source_compiled()
end

return plugin_loader
