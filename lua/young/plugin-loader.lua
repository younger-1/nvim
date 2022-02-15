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
    max_jobs = 8,
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

plugin_loader.recompile = function()
  require_clean('young.plugins')

  plugin_loader.load()

  vim.cmd 'PackerClean'
  vim.cmd 'PackerCompile'
  vim.cmd 'PackerInstall'
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

plugin_loader.source_compiled = function()
  if not utils.is_file(compile_path) then
    vim.notify('[young.plugin-loader]: not find ' .. compile_path .. ', compiling ...', vim.log.levels.WARN)
    packer.compile()
    -- No need to source compiled file, as PackerCompile will do it
    -- doautocmd BufWinEnter will load "which-key" and "nvim-tree" at least
    vim.cmd [[autocmd User PackerCompileDone ++once doautocmd BufWinEnter]]
    return
  end

  -- DONE: use vim.defer_fn(), plenary's async, timer_start(), wait()
  -- local compiled_ok = function()
  --   return utils.is_file(compile_path)
  -- end
  -- vim.wait(20000, compiled_ok)

  -- To use impatient
  require('young.packer_compiled')
  -- dofile(compile_path)
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
