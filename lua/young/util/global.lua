_G.xy = {}

_G.uv = vim.loop
_G.fn = vim.fn
_G.api = vim.api

_G.fmt = string.format

--[[
Windows:
  machine = "x86_64",
  release = "10.0.19043",
  sysname = "Windows_NT",
  version = "Windows 10 Home China"
WSL-arch:
  machine = "x86_64",
  release = "5.10.60.1-microsoft-standard-WSL2",
  sysname = "Linux",
  version = "#1 SMP Wed Aug 25 23:20:18 UTC 2021"
WSL-ubuntu:
  machine = "x86_64",
  release = "4.4.0-19041-Microsoft",
  sysname = "Linux",
  version = "#1237-Microsoft Sat Sep 11 14:32:00 PST 2021"
]]

-- _G.is_windows = vim.fn.has('win32') == 1 and true or false
-- _G.is_wsl = vim.fn.has('wsl') == 1 and true or false
_G.is_windows = uv.os_uname().version:match 'Windows' and true or false
_G.is_wsl = uv.os_uname().release:lower():match 'microsoft' and true or false
_G.is_unix = not is_windows

function _G.join_paths(...)
  local path_sep = is_windows and '\\' or '/'
  local result = table.concat({ ... }, path_sep)
  -- local result = table.concat(vim.tbl_flatten { ... }, path_sep):gsub(path_sep .. '+', path_sep)
  return result
end

_G.pp = vim.pretty_print

-- 1. fancy print 2. return parameters
function _G.ppp(...)
  local objects = {}
  -- Not using `{...}` because it removes `nil` input
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))

  return ...
end

-- function _G.ppp(...)
--   local objects = vim.tbl_map(vim.inspect, { ... })
--   print(table.concat(objects, '\n'))
--   return ...
-- end

function _G.pn(obj, n)
  print(vim.inspect(obj, { depth = n or 1 }))
  return obj
end

function _G.gg(name, val, ...)
  local prefix = '[young]: '
  if not name then
    print(prefix .. '============')
    return
  end
  if #{ ... } == 0 then
    print(prefix .. vim.inspect(name) .. ' => ' .. vim.inspect(val))
  else
    local objects = vim.tbl_map(vim.inspect, { name, val, ... })
    print(prefix .. table.concat(objects, ' -> '))
  end
end

function _G.put_text(...)
  local objects = {}
  -- Not using `{...}` because it removes `nil` input
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  local lines = vim.split(table.concat(objects, '\n'), '\n')
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  vim.fn.append(lnum, lines)

  return ...
end

function _G.to_home(path)
  return vim.fn.fnamemodify(path, ':~')
end

---Require a module in protected mode
---@param module string
---@return any
function _G.rr(module)
  local ok, result = pcall(require, module)
  if ok then
    return result
  else
    vim.notify(result, vim.log.levels.ERROR, { title = fmt('[rr]: Error requiring: %s', module) })
    return false
  end
end

---require_clean: Require a module in protected mode without relying on its cached value
---@param module string
---@return any
function _G.rc(module)
  package.loaded[module] = nil
  _G[module] = nil
  return rr(module)
end

----------------------------------------------------------------------------------------------------
-- Command
----------------------------------------------------------------------------------------------------
xy.command = function(tbl)
  local opts = {}
  for k, v in pairs(tbl) do
    if tonumber(k) == nil then
      opts[k] = v
    end
  end
  vim.api.nvim_create_user_command(tbl[1], tbl[2], opts)
end

----------------------------------------------------------------------------------------------------
-- Autocommand
----------------------------------------------------------------------------------------------------
---@class Autocommand
---@field event   string[] list of autocommand events
---@field pattern string[] list of autocommand patterns
---@field command string | function
---@field nested  boolean
---@field once    boolean
---@field buffer  number
---@field desc    number

---Create an autocommand
---returns the group ID so that it can be cleared or manipulated.
---@param name string
---@param commands Autocommand[]
---@return number
function xy.augroup(name, commands)
  local id = api.nvim_create_augroup(name, { clear = true })
  for _, autocmd in ipairs(commands) do
    local is_callback = type(autocmd.command) == 'function'
    api.nvim_create_autocmd(autocmd.event, {
      group = name,
      pattern = autocmd.pattern,
      desc = autocmd.desc,
      callback = is_callback and autocmd.command or nil,
      command = not is_callback and autocmd.command or nil,
      once = autocmd.once,
      nested = autocmd.nested,
      buffer = autocmd.buffer,
    })
  end
  return id
end

----------------------------------------------------------------------------------------------------
-- Mappings
----------------------------------------------------------------------------------------------------
xy.map = {}

local function mapper(tbl)
  local opts = { noremap = true, silent = true, nowait = true }

  local mode = tbl['mode'] or ''
  tbl['mode'] = nil

  for k, v in pairs(tbl) do
    if tonumber(k) == nil then
      opts[k] = v
    end
  end

  vim.keymap.set(mode, tbl[1], tbl[2], opts)
end

setmetatable(xy.map, {
  __call = function(t, tbl)
    mapper(tbl)
  end,
  __index = function(t, key)
    local silent
    if key == '!' or key == 'c' then
      silent = false
    end

    t[key] = function(tbl)
      tbl['silent'] = tbl['silent'] or silent
      tbl['mode'] = key
      mapper(tbl)
    end
    return t[key]
  end,
})

----------------------------------------------------------------------------------------------------
-- Others
----------------------------------------------------------------------------------------------------
---check if a certain feature/version/commit exists in nvim
---@param feature string
---@return boolean
xy.has = function(feature)
  return vim.fn.has(feature) > 0
end

xy.log = {
  info = function(msg)
    vim.notify(msg, vim.log.levels.INFO)
  end,
  warn = function(msg)
    vim.notify(msg, vim.log.levels.WARN)
  end,
  err = function(msg)
    vim.notify(msg, vim.log.levels.ERROR)
  end,
}
