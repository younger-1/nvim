local plugin_loader = {}

local in_headless = #vim.api.nvim_list_uis() == 0

local utils = require 'young.utils'
-- local Log = require "lvim.core.log"

local runtime_dir = vim.fn.stdpath 'data'
local config_dir = vim.fn.stdpath 'config'
local install_path = join_paths(runtime_dir, 'site', 'pack', 'packer', 'start', 'packer.nvim')
local compile_path = join_paths(config_dir, 'lua', 'young', 'packer_compiled.lua')
local snapshot_name = 'packer-lock.json'
local snapshot_path = join_paths(vim.fn.stdpath 'config', 'utils', 'snapshot')

local _, packer = pcall(require, 'packer')

plugin_loader.once = function()
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    -- vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    -- WARN: system sync/async
    vim.fn.system { 'git', 'clone', '--depth', '3', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd 'packadd packer.nvim' -- To init packer commands after clone it.
  end

  require('packer').init {
    compile_path = compile_path,
    -- max_jobs = 8,
    log = { level = in_headless and 'debug' or 'warn' },
    profile = { enable = true },
    display = {
      open_fn = function()
        -- return require("packer.util").float { border = "rounded" }
        return require('packer.util').float { border = 'double' }
      end,
    },
    -- snapshot = 'default.json',
    -- snapshot = snapshot_name,
    snapshot_path = snapshot_path,
  }
end

plugin_loader.recompile = function()
  require_clean 'young.plugins'

  plugin_loader.load()
  -- NOTE:Do I need source_compiled here? No, PackerCompile will do
  -- plugin_loader.source_compiled()

  vim.cmd 'PackerClean'
  vim.cmd 'PackerCompile'
  vim.cmd 'PackerInstall'
end

plugin_loader.load = function()
  local plugins = require('young.plugins').done()
  -- Log:debug "loading plugins configuration"
  local status_ok, _ = xpcall(function()
    packer.reset()
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

plugin_loader.source_compiled = function()
  if not utils.is_file(compile_path) then
    vim.notify('[young.plugin-loader]: not find ' .. compile_path .. ', compiling ...', vim.log.levels.WARN)
    packer.compile()
    -- No need to source compiled file, as PackerCompile will do it
    -- doautocmd BufWinEnter will load "which-key" and "nvim-tree" at least
    vim.cmd [[autocmd User PackerCompileDone ++once doautocmd BufWinEnter]]
    return
  end

  -- DONE: use vim.schedule(), vim.defer_fn(), plenary's async, timer_start(), wait()
  -- local compiled_ok = function()
  --   return utils.is_file(compile_path)
  -- end
  -- vim.wait(20000, compiled_ok)

  -- To use impatient
  require 'young.packer_compiled'
  -- dofile(compile_path)
end

plugin_loader.flatten_plugin = function(spec)
  local list = {}

  local function flatten(x)
    if type(x) == 'table' and (#x > 1 or type(x[1]) == 'table') then
      for _, xx in ipairs(x) do
        flatten(xx)
      end
      return
    end

    list[#list + 1] = x
  end

  flatten(spec)
  return list
end

plugin_loader.get_pins = function()
  local pin_plugins = require('young.plugins').pins()
  -- local pin_plugins = {
  --   { 'a/b', 'c/d' },
  --   { {'e/f'}, {'n/m'} },
  -- }
  pin_plugins = vim.tbl_flatten(pin_plugins)

  local get_short = function(name)
    -- return name:match "/(%S*)"
    return require('packer.util').get_plugin_short_name { name }
  end

  local short_names = vim.tbl_map(get_short, pin_plugins)

  return short_names
end

plugin_loader.snapshot = function()
  packer.snapshot(snapshot_name, unpack(plugin_loader.get_pins()))
end

plugin_loader.rollback = function()
  packer.rollback(snapshot_name, unpack(plugin_loader.get_pins()))
end

plugin_loader.snapshot_hook = function()
  -- TODO:not doautocmd for packer.snapshot yet
  local tmpfile = vim.fn.tempname()
  local snapfile = join_paths(snapshot_path, snapshot_name)

  -- vim.fn.system("jq --sort-keys . " .. snapfile .. " > " .. tmpfile)
  -- vim.fn.writefile(vim.fn.readfile(tmpfile), snapfile)
  -- vim.fn.delete(tmpfile)

  os.execute("jq --sort-keys . " .. snapfile .. " > " .. tmpfile)
  os.rename(tmpfile, snapfile)
end

plugin_loader.done = function()
  plugin_loader.once()
  plugin_loader.load()
  plugin_loader.source_compiled()
end

-- For lua lsp
plugin_loader.test_path = function()
  for name, infos in pairs(_G.packer_plugins) do
    if not vim.tbl_contains(vim.tbl_keys(infos), 'path') then
      print(name .. ' do not have `path` attributes')
    end
  end
end

return plugin_loader
