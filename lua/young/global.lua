function _G.pp(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(table.concat(objects, '\n'))
end

function _G.join_paths(...)
  local path_sep = vim.loop.os_uname().version:match 'Windows' and '\\' or '/'
  local result = table.concat(vim.tbl_flatten { ... }, path_sep):gsub(path_sep .. '+', path_sep)
  return result
end
