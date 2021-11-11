local plugin_loader = {}

local utils = require 'young.utils'
-- local Log = require "lvim.core.log"

local runtime_dir = vim.fn.stdpath 'data'
local config_dir = vim.fn.stdpath 'config'
local install_path = join_paths(runtime_dir, 'site', 'pack', 'packer', 'start', 'packer.nvim')
local compile_path = join_paths(config_dir, 'lua', 'young', 'packer_compiled.lua')

local _, packer = pcall(require, 'packer')

function plugin_loader.init()
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

-- packer expects a space separated list
local function pcall_packer_command(cmd, kwargs)
  local status_ok, msg = pcall(function()
    require('packer')[cmd](unpack(kwargs or {}))
  end)
  if not status_ok then
    -- Log:warn(cmd .. " failed with: " .. vim.inspect(msg))
    -- Log:trace(vim.inspect(vim.fn.eval "v:errmsg"))
  end
end

function plugin_loader.cache_clear()
  if vim.fn.delete(compile_path) == 0 then
    -- Log:debug "deleted packer_compiled.lua"
  end
end

function plugin_loader.recompile()
  plugin_loader.cache_clear()
  pcall_packer_command 'compile'
  if utils.is_file(compile_path) then
    -- Log:debug "generated packer_compiled.lua"
  end
end

function plugin_loader.load()
  local plugins = require 'young.plugins'
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

  -- @young
  if not utils.is_file(compile_path) then
    packer.compile()
    vim.notify('[young.plugin-loader]: not find packer_compiled.lua', vim.log.levels.WARN)
    -- I return because `packer.compile()` is async.
    return
  end
  require 'young.packer_compiled'
  -- @young
end

function plugin_loader.get_core_plugins()
  local list = {}
  local plugins = require 'lvim.plugins'
  for _, item in pairs(plugins) do
    table.insert(list, item[1]:match '/(%S*)')
  end
  return list
end

function plugin_loader.sync_core_plugins()
  local core_plugins = plugin_loader.get_core_plugins()
  -- Log:trace(string.format("Syncing core plugins: [%q]", table.concat(core_plugins, ", ")))
  pcall_packer_command('sync', core_plugins)
end

return plugin_loader
