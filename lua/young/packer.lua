local M = {}

local in_headless = #api.nvim_list_uis() == 0

local util = require 'young.util'
-- local Log = require "lvim.core.log"

local package_root = join_paths(fn.stdpath 'data', 'site', 'pack')
local install_path = join_paths(package_root, 'packer', 'start', 'packer.nvim')
local standard = false
local standard_path = join_paths(fn.stdpath 'config', 'plugin', 'packer_compiled.lua')
local compile_path = standard and standard_path
  or join_paths(fn.stdpath 'config', 'lua', 'young', 'packer_compiled.lua')
local snapshot_name = 'packer-lock.json'
local snapshot_path = join_paths(fn.stdpath 'config', 'utils', 'snapshot')
-- local default_snapshot = join_paths(snapshot_path, snapshot_name)

local _, packer = pcall(require, 'packer')
local first_time = nil

M.once = function()
  -- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  if not util.is_directory(install_path) then
    first_time = true
    -- vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    -- WARN: system sync/async
    vim.fn.system { 'git', 'clone', '--depth', '3', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]] -- To init packer commands after clone it.
    packer = require 'packer'
  end

  packer.init {
    package_root = package_root,
    compile_path = compile_path,
    max_jobs = is_windows and 5 or 10,
    log = { level = in_headless and 'debug' or 'warn' },
    profile = { enable = true },
    -- auto_clean = true, -- During sync(), remove unused plugins
    -- compile_on_sync = true, -- During sync(), run packer.compile()
    -- auto_reload_compiled = true, -- Automatically reload the compiled file after creating it.
    -- opt_default = false, -- Default to using opt (as opposed to start) plugins
    -- transitive_opt = true, -- Make dependencies of opt plugins also opt by default
    -- transitive_disable = true, -- Automatically disable dependencies of disabled plugins
    display = {
      open_fn = function()
        -- return require("packer.util").float { border = "rounded" }
        return require('packer.util').float { border = 'double' }
      end,
      working_sym = 'ﰭ',
      error_sym = '',
      done_sym = '',
      removed_sym = '',
      moved_sym = 'ﰳ',
    },
    -- NOTE: only set this the very first time to avoid constantly triggering the rollback function
    -- <https://github.com/wbthomason/packer.nvim/blob/c576ab3f1488ee86d60fd340d01ade08dcabd256/lua/packer.lua#L998-L995>
    -- snapshot = 'default.json',
    snapshot = first_time and snapshot_name,
    snapshot_path = snapshot_path,
  }

  -- @note lua =rr'packer.handlers'
  -- packer.set_handler('cfg', function(_, plugin, value)
  --   if value:match '^young.' then
  --     plugin.config = ([[require('%s')]]):format(value)
  --   else
  --     plugin.config = ([[require('young.mod.%s')]]):format(value)
  --   end
  -- end)
end

M.recompile = function()
  rc 'young.plugins'

  M.load()
  -- NOTE:Do I need source_compiled here? No, PackerCompile will do
  -- M.source_compiled()

  vim.cmd 'PackerClean'
  vim.cmd 'PackerCompile'
  vim.cmd 'PackerInstall'
end

M.load = function()
  local plugins = require('young.plugins').done()
  -- Log:debug "loading plugins configuration"
  local status_ok, _ = xpcall(function()
    require('packer').reset()
    require('packer').startup(function(use)
      for _, plugin in ipairs(plugins) do
        use(plugin)
      end
    end)
  end, debug.traceback)
  if not status_ok then
    vim.notify('[young.packer]: loading plugins', vim.log.levels.WARN)
    -- Log:warn "problems detected while loading plugins' configurations"
    -- Log:trace(debug.traceback())
    return
  end
end

M.source_compiled = function()
  -- doautocmd BufWinEnter will load "which-key" at least
  vim.cmd [[autocmd User PackerCompileDone ++once doautocmd BufWinEnter | doautocmd BufRead]]

  if first_time then
    vim.notify('[young]: Installing plugins...', vim.log.levels.WARN)
    -- `sync()` runs packer.clean(), packer.update() and packer.compile()
    -- No need to source compiled file, as `compile()` will do it
    vim.defer_fn(function()
      require('packer').sync()
    end, 200)
    -- vim.cmd [[autocmd BufWinEnter * ++once lua require('packer').sync()]]

    return
  end

  if not util.is_file(compile_path) then
    vim.notify('[young.packer]: not find ' .. compile_path .. ', compiling ...', vim.log.levels.WARN)
    packer.compile()

    return
  end

  -- DONE: use vim.schedule(), vim.defer_fn(), plenary's async, timer_start(), wait()
  -- local compiled_ok = function()
  --   return util.is_file(compile_path)
  -- end
  -- vim.wait(20000, compiled_ok)

  -- Use impatient
  if false == standard then
    if util.is_file(standard_path) then
      fn.delete(standard_path)
    end
    require 'young.packer_compiled'
    -- dofile(compile_path)
  end
end

M.flatten_plugin = function(spec)
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

M.get_pins = function()
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

M.snapshot = function()
  packer.snapshot(snapshot_name, unpack(M.get_pins()))
  vim.cmd [[autocmd User PackerSnapshotDone ++once lua require('young.packer').snapshot_hook()]]
end

M.rollback = function()
  packer.rollback(snapshot_name, unpack(M.get_pins()))
end

M.snapshot_hook = function()
  -- TODO:not doautocmd for packer.snapshot yet
  local tmpfile = vim.fn.tempname()
  local snapfile = join_paths(snapshot_path, snapshot_name)
  local jsoner
  for _, item in ipairs { 'jq' } do
    if vim.fn.executable(item) == 1 then
      jsoner = item
      break
    end
  end
  if not jsoner then
    vim.notify('[young.packer]: not jsoner to format ' .. snapfile, vim.log.levels.WARN)
    return
  end
  vim.fn.system(fmt('%s --sort-keys . %s > %s', jsoner, snapfile, tmpfile))
  vim.fn.writefile(vim.fn.readfile(tmpfile), snapfile)
  vim.fn.delete(tmpfile)

  -- NOTE: Not working on windows, but why
  -- os.execute("jq --sort-keys . " .. snapfile .. " > " .. tmpfile)
  -- os.rename(tmpfile, snapfile)
end

M.done = function()
  tt()
  M.once()
  M.load()
  tt()
  M.source_compiled()
end

-- For lua lsp
M.test_path = function()
  for name, infos in pairs(_G.packer_plugins) do
    if not vim.tbl_contains(vim.tbl_keys(infos), 'path') then
      print(name .. ' do not have `path` attributes')
    end
  end
end

return M
