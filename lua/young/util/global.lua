_G.young = {}

_G.uv = vim.loop
_G.fn = vim.fn
_G.api = vim.api
_G.fmt = string.format

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
function young.augroup(name, commands)
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

-- source: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/globals.lua
-- credits: akinsho
---create a mapping function factory
---@param mode string
---@param o table
---@return fun(lhs: string, rhs: string|function, opts: table|nil) 'create a mapping'
local function make_mapper(mode, o)
  -- copy the opts table as extends will mutate the opts table passed in otherwise
  local parent_opts = vim.deepcopy(o)
  ---Create a mapping
  ---@param lhs string
  ---@param rhs string|function
  ---@param opts table
  return function(lhs, rhs, opts)
    -- If the label is all that was passed in, set the opts automagically
    opts = type(opts) == 'string' and { desc = opts } or opts and vim.deepcopy(opts) or {}
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('keep', opts, parent_opts))
  end
end

local map_opts = { remap = true, silent = true }
local noremap_opts = { silent = true }

-- A recursive normal mapping
young.nmap = make_mapper('n', map_opts)
-- A recursive select mapping
young.xmap = make_mapper('x', map_opts)
-- A recursive insert mapping
young.imap = make_mapper('i', map_opts)
-- A recursive visual mapping
young.vmap = make_mapper('v', map_opts)
-- A recursive operator mapping
young.omap = make_mapper('o', map_opts)
-- A recursive terminal mapping
young.tmap = make_mapper('t', map_opts)
-- A recursive visual & select mapping
young.smap = make_mapper('s', map_opts)
-- A recursive commandline mapping
young.cmap = make_mapper('c', { remap = true, silent = false })
-- A non recursive normal mapping
young.nnoremap = make_mapper('n', noremap_opts)
-- A non recursive select mapping
young.xnoremap = make_mapper('x', noremap_opts)
-- A non recursive visual mapping
young.vnoremap = make_mapper('v', noremap_opts)
-- A non recursive insert mapping
young.inoremap = make_mapper('i', noremap_opts)
-- A non recursive operator mapping
young.onoremap = make_mapper('o', noremap_opts)
-- A non recursive terminal mapping
young.tnoremap = make_mapper('t', noremap_opts)
-- A non recursive visual & select mapping
young.snoremap = make_mapper('s', noremap_opts)
-- A non recursive commandline mapping
young.cnoremap = make_mapper('c', { silent = false })

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
_G.path_sep = is_windows and '\\' or '/'

function _G.join_paths(...)
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
