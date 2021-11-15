local uv = vim.loop

_G.is_windows = uv.os_uname().version:match 'Windows' and true or false
_G.is_unix = not is_windows
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
