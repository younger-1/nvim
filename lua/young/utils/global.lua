local uv = vim.loop

local uname = uv.os_uname()
--[[
[has("wsl") always reports 0](https://github.com/neovim/neovim/issues/12642)
[fix(eval): fix has('wsl')](https://github.com/mjlbach/neovim/commit/26a5ab11b4d6a4f1db7fef0020c5a3b8bd260ebb)

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

_G.is_windows = uname.version:match 'Windows' and true or false
_G.is_unix = not is_windows
_G.is_wsl = uname.release:match 'WSL' and true or false
_G.path_sep = is_windows and '\\' or '/'

function _G.join_paths(...)
  local result = table.concat({ ... }, path_sep)
  -- local result = table.concat(vim.tbl_flatten { ... }, path_sep):gsub(path_sep .. '+', path_sep)
  return result
end

-- [](https://github.com/glepnir/nvim-lua-guide-zh#tips)
-- 1. fancy print 2. return parameters
function _G.pp(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(table.concat(objects, '\n'))
  return ...
end

-- 1. return fancy string
function _G.ppp(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  return table.concat(objects, '\n')
end

function _G.to_home(path)
  return vim.fn.fnamemodify(path, ':~')
end

function _G.rr(...)
  return require(...)
end
