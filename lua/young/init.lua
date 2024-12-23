_G.uv = vim.loop
_G.fn = vim.fn
_G.api = vim.api

_G.fmt = string.format

_G.nvim = setmetatable({}, {
  __index = function(t, k)
    t[k] = assert(vim.api['nvim_' .. k], k)
    return t[k]
  end,
})

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
Mac-intel:
  machine = "x86_64",
  release = "21.6.0",
  sysname = "Darwin",
  version = "Darwin Kernel Version 21.6.0: Sat Jun 18 17:07:25 PDT 2022; root:xnu-8020.140.41~1/RELEASE_X86_64"
]]

-- windows, unix(wsl, mac, linux)
-- _G.is_windows = vim.fn.has('win32') == 1 and true or false
-- _G.is_wsl = vim.fn.has('wsl') == 1 and true or false
_G.is_windows = uv.os_uname().version:match 'Windows' and true or false
_G.is_unix = not is_windows
_G.is_wsl = uv.os_uname().release:lower():match 'microsoft' and true or false
_G.is_mac = uv.os_uname().sysname:match 'Darwin' and true or false
_G.is_linux = _G.is_unix and not (_G.is_wsl or _G.is_mac)

_G.xy = {
  -- colorscheme = 'monokai',
  transparent_mode = false,
  startup_time = {
    os_start = os.clock(),
    rel_start = vim.fn.reltime(),
    hr_start = uv.hrtime(),
  },
  opt = {},
  icon = {
    -- bar = '▏',
    bar = '│',
  },
  lsp = {},
  coc = false,
}

if is_mac then
  xy.open_cmd = 'open' -- <https://ss64.com/osx/open.html>
elseif is_linux then
  xy.open_cmd = 'xdg-open' -- <https://linux.die.net/man/1/xdg-open>
else
  xy.open_cmd = 'explorer'
  -- xy.open_cmd = 'start' -- <https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/start>
end

-- local os, open_cmd = jit.os, "xdg-open"
-- if os == "Darwin" then
--   open_cmd = "open"
-- elseif os == "Windows" then
--   open_cmd = "explorer"
-- end
-- xy.open_cmd = open_cmd

-- stylua: ignore start
_G.tt = tt or function()
  local depth = 0
  while debug.getinfo(depth + 2, 'n').name do
    depth = depth + 1
  end
  table.insert(xy.startup_time, {
    os_time = os.clock() - xy.startup_time.os_start,
    rel_time = vim.fn.reltimefloat(vim.fn.reltime(xy.startup_time.rel_start)),
    hr_time = (uv.hrtime() - xy.startup_time.hr_start) / 1e9,
    file_name = debug.getinfo(2, 'S').source:sub(2),
    func_name = debug.getinfo(2, 'n').name,
    func_scope = debug.getinfo(2, 'n').namewhat,
    currentline = debug.getinfo(2, 'l').currentline,
    depth = depth,
  })
end
-- stylua: ignore end

function _G.join_paths(...)
  local path_sep = is_windows and '\\' or '/'
  local result = table.concat({ ... }, path_sep)
  -- local result = table.concat(vim.tbl_flatten { ... }, path_sep):gsub(path_sep .. '+', path_sep)
  return result
end

_G.pp = vim.print

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

-- function _G.put_text(...)
--   local objects = {}
--   -- Not using `{...}` because it removes `nil` input
--   for i = 1, select('#', ...) do
--     local v = select(i, ...)
--     table.insert(objects, vim.inspect(v))
--   end

--   local lines = vim.split(table.concat(objects, '\n'), '\n')
--   local lnum = vim.api.nvim_win_get_cursor(0)[1]
--   vim.fn.append(lnum, lines)

--   return ...
-- end

-- function _G.PP(obj)
--   local buf = vim.api.nvim_create_buf(false, true)
--   local lines = vim.split(vim.inspect(obj), '\n', { plain = true })
--   vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
--   vim.cmd 'vsplit'
--   vim.api.nvim_win_set_buf(0, buf)
-- end

-- _G.PP = vim.schedule_wrap(function(...)
--   local buf = vim.api.nvim_create_buf(false, true)
--   local lines = vim.split(vim.inspect(...), '\n', { plain = true })
--   vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
--   vim.cmd 'vsplit'
--   vim.api.nvim_win_set_buf(0, buf)
-- end)

---Require a module in protected mode
---@param module string
---@return any
function _G.rr(module)
  local ok, result = pcall(require, module)
  if ok then
    return result
  else
    -- vim.notify(result, vim.log.levels.ERROR, { title = fmt('[young]: Error requiring: %s', module) })
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

local lazy_mods = {}
function _G.rl(mod)
  if lazy_mods[mod] then
    return lazy_mods[mod]
  end
  lazy_mods[mod] = {}
  return setmetatable(lazy_mods[mod], {
    __index = function(_, func)
      return function(...)
        require(mod)[func](...)
      end
    end,
  })
end

-- local lazy = {}
-- lazy.require = function(modname)
--   local ref = nil
--   local init = false

--   local init_ref = function()
--     if init then
--       return
--     end

--     ref = require(modname)
--     init = true
--   end

--   return setmetatable({}, {
--     __call = function(_, ...)
--       init_ref()

--       return ref(...)
--     end,

--     __index = function(_, k)
--       init_ref()

--       return ref[k]
--     end,

--     __newindex = function(_, k, v)
--       init_ref()

--       ref[k] = v
--     end,
--   })
-- end

-- lazy.access = function(table_or_modname, key)
--   local ref = type(table_or_modname) == 'string' and lazy.require(table_or_modname) or table_or_modname

--   return setmetatable({}, {
--     __call = function(_, ...)
--       return ref[key](...)
--     end,

--     __index = function(_, k)
--       return ref[key][k]
--     end,

--     __newindex = function(_, k, v)
--       ref[key][k] = v
--     end,
--   })
-- end
-- xy.lazy = lazy

--[[
xy.a -> require('xy').a -> require('xy.a')
xy.a.b -> require('xy').a.b -> require('xy.a').b -> require('xy.a.b')
]]

local mt = {}
-- function mt.__index(t, k)
function mt:__index(k)
  if k == '_path' then
    return nil
  end

  local ok, ret = pcall(require, 'young.' .. (self._path or '') .. k)
  if ok then
    self[k] = ret
    if type(self[k]) == 'table' then
      self[k]._path = (self._path or '') .. k .. '.'
      setmetatable(self[k], mt)
    end
  else
    self[k] = { _nil = true, _path = (self._path or '') .. k .. '.' }
    setmetatable(self[k], mt)
  end

  return self[k]
end

-- TODO:use module(xy)
setmetatable(xy, mt)

----------------------------------------------------------------------------------------------------
-- cmd
----------------------------------------------------------------------------------------------------
xy.cmd = function(tbl) end

----------------------------------------------------------------------------------------------------
-- command
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
-- autocommand
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
-- function xy.augroup(name, commands)
--   local id = vim.api.nvim_create_augroup(name, { clear = true })
--   for _, autocmd in ipairs(commands) do
--     local is_callback = type(autocmd.command) == 'function'
--     vim.api.nvim_create_autocmd(autocmd.event, {
--       group = name,
--       pattern = autocmd.pattern,
--       desc = autocmd.desc,
--       callback = is_callback and autocmd.command or nil,
--       command = not is_callback and autocmd.command or nil,
--       once = autocmd.once,
--       nested = autocmd.nested,
--       buffer = autocmd.buffer,
--     })
--   end
--   return id
-- end

---@class Autocmd
---@field desc?     string
---@field once?     boolean
---@field nested?   boolean

---@param group     string
---@param autocmds  Autocmd[]
---@param reset?    boolean    default to reset, unless false
xy.autogroup = function(group, autocmds, reset)
  if reset == false then
    vim.api.nvim_create_augroup(group, { clear = false })
  elseif group then
    local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = group, buffer = autocmds.bufnr })
    if exists and autocmds.bufnr then
      vim.api.nvim_clear_autocmds {
        group = group,
        -- pattern = '<buffer>',
        buffer = autocmds.bufnr,
      }
    elseif exists then
      vim.api.nvim_clear_autocmds {
        group = group,
      }
    else
      vim.api.nvim_create_augroup(group, { clear = true })
    end
  end

  for _, acmd in ipairs(autocmds) do
    local is_fn = type(acmd[3]) == 'function'
    local events = acmd[1]
    if type(events) == 'string' then
      events = vim.split(events, ',')
    end
    vim.api.nvim_create_autocmd(events, {
      group = group,
      pattern = acmd[2],
      -- callback = is_callback and acmd[3] or nil,
      -- command = not is_callback and acmd[3] or nil,
      [is_fn and 'callback' or 'command'] = acmd[3],
      desc = acmd.desc,
      once = acmd.once,
      buffer = autocmds.bufnr,
      nested = acmd.nested,
    })
  end
end

----------------------------------------------------------------------------------------------------
-- mappings
----------------------------------------------------------------------------------------------------
-- local org_keymap = vim.keymap.set
-- function vim.keymap.set(mode, lhs, rhs, opts)
--   xy.map.check('xy.map', lhs, rhs, mode, opts)
--   org_keymap(mode, lhs, rhs, opts)
-- end

xy.map = {
  register = function(mappings, opts)
    opts = opts or {}

    local prefix = opts.prefix or ''
    local mode = opts.mode or 'n'
    local buffer = opts.buffer or false

    xy.map._nest(mappings, prefix, mode, buffer)
  end,

  _nest = function(mappings, prefix, mode, buffer)
    for k, v in pairs(mappings) do
      if k == 'group' or type(v) == 'string' then
        require('young.mod.which_key').add { prefix, group = v, mode = { 'n', 'x', 'o' } }
      elseif #v == 0 then
        xy.map._nest(v, prefix .. k, mode, buffer)
      elseif v[1] == nil then
        xy.util.echomsg { fmt('[xy.map.register]: [%s%s] is mapped to nil, with v = ', prefix, k), vim.inspect(v) }
      elseif #v == vim.tbl_count(v) then
        xy.map[mode] { prefix .. k, v[1], v[2], buffer = buffer }
      else
        local keymap = { prefix .. k, v[1], v[2], buffer = buffer }
        -- allow |mappings|'s (mode,buffer) override |opts|'s (mode,buffer)
        for kk, vv in pairs(v) do
          if tonumber(kk) == nil then
            keymap[kk] = vv
          end
        end
        xy.map[mode](keymap)
      end
    end
  end,

  check = function(caller, lhs, rhs, mode, opts)
    local mode_name = type(mode) == 'string' and mode or table.concat(mode)
    local e = vim.fn.maparg(lhs, mode_name, false, true)
    if (opts and opts.buffer) or (vim.startswith(lhs, '<Plug>')) then
      return
    end
    ---@cast e -string
    if next(e) then
      xy.util.echomsg {
        fmt(
          '[%s check](%s): %s %s%s(%s) => %s%s(%s)',
          caller,
          mode_name,
          lhs,
          -- old
          e.buffer == 1 and '[@]' or '',
          e.rhs or table.concat({ xy.util.get_func_loc(e.callback) }, ' '),
          e.desc,
          -- new
          opts
            and opts.buffer and '[@]' or '',
          type(rhs) == 'string' and rhs or table.concat({ xy.util.get_func_loc(rhs) }, ' '),
          opts and opts.desc
        ),
      }
      -- return
    end
  end,
}

setmetatable(xy.map, {
  -- default to 'map', not 'nmap'
  ---@param tbl table: { lhs, rhs, desc, ... }
  __call = function(t, tbl)
    local mode = tbl['mode'] or { 'n', 'x', 'o' }
    tbl['mode'] = nil

    local opts = { nowait = true }
    for k, v in pairs(tbl) do
      if tonumber(k) == nil then
        opts[k] = v
      end
    end
    opts.desc = tbl[3] or opts.desc

    vim.keymap.set(mode, tbl[1], tbl[2], opts)
  end,
  __index = function(t, key)
    -- local silent
    -- if key ~= '!' and key ~= 'c' then
    --   silent = true
    -- end

    t[key] = function(tbl)
      -- if nil == tbl['silent'] then
      --   tbl['silent'] = silent
      -- end

      -- let mode has higher priority
      tbl['mode'] = tbl['mode'] or key
      xy.map(tbl)
    end
    return t[key]
  end,
})

xy.map2 = {}
setmetatable(xy.map2, {
  -- default to 'map', not 'nmap'
  __call = function(t, lhs, rhs, opts)
    local mode = opts['mode'] or { 'n', 'x', 'o' }
    opts['mode'] = nil

    vim.keymap.set(mode, lhs, rhs, opts)
  end,
  __index = function(t, key)
    t[key] = function(lhs, rhs, opts)
      -- let mode has higher priority
      opts['mode'] = opts['mode'] or key
      xy.map2(lhs, rhs, opts)
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

xy.globals = function()
  local no = {
    '_',
    '_G',
    '_VERSION',
    'arg',
    'assert',
    'bit',
    'collectgarbage',
    'coroutine',
    'debug',
    'dofile',
    'error',
    'find',
    'gcinfo',
    'getfenv',
    'getmetatable',
    'io',
    'ipairs',
    'jit',
    'load',
    'loadfile',
    'loadstring',
    'math',
    'newproxy',
    'next',
    'os',
    'package',
    'pairs',
    'pcall',
    'print',
    'rawequal',
    'rawget',
    'rawset',
    'require',
    'select',
    'setfenv',
    'setmetatable',
    'string',
    'table',
    'tonumber',
    'tostring',
    'type',
    'unpack',
    'vim',
    'xpcall',
    -- 'MPairs',
    -- 'MiniIndentscope',
    -- 'STSSwapCurrentNodeNextNormal_Dot',
    -- 'STSSwapCurrentNodePrevNormal_Dot',
    -- 'STSSwapDownNormal_Dot',
    -- 'STSSwapUpNormal_Dot',
    -- 'ScFa',
    -- 'ScLa',
    -- 'ScSa',
    -- 'StatusCol',
    -- 'TelescopeGlobalState',
    -- '_PlenaryLeafTable',
    -- '_TelescopeConfigurationPickers',
    -- '_TelescopeConfigurationValues',
    -- '_TelescopeFileBrowserConfig',
    -- '___toggleterm_winbar_click',
    -- '_packer',
    -- 'cmp',
    -- 'f',
    -- 'lhs',
    -- 'mason_lspconfig_completion',
    -- 'modes',
    -- 'module',
    -- 'rhs',
    -- 'status',
    -- 'typename',
    -- 'unception_edit_files',
    -- 'unception_escape_special_chars',
    -- 'unception_get_absolute_filepath',
    -- 'unception_handle_bufunload',
    -- 'unception_handle_quitpre',
    -- 'unception_notify_when_done_editing',
    -- 'unception_pipe_path_host_env_var',
    'api',
    'fmt',
    'fn',
    'gg',
    'is_linux',
    'is_mac',
    'is_unix',
    'is_windows',
    'is_wsl',
    'nvim',
    'pn',
    'pp',
    'ppp',
    'rc',
    'rl',
    'rr',
    'tt',
    'uv',
    'xy',
  }
  local G = {}
  for k, v in pairs(_G) do
    if not vim.tbl_contains(no, k) then
      G[k] = v
    end
  end
  return G
end
