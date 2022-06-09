-- <https://github.com/sam4llis/nvim-lua-gf>

if vim.fn.has 'nvim-0.8.0' ~= 1 then
  vim.api.nvim_err_writeln 'The Lua `gf` mapping requires Neovim 0.8.0.'
  vim.api.nvim_err_writeln 'Please update your Neovim.'
  return
end

local M = {}

--
-- @desc
--   Function that returns the correct directory separator character dependent
--   on a user's operating system.
-- @return: string
--   The directory separator character. This is usually `/` on Unix-like systems
--   and `\` on a Windows system.
--
local get_separator = function()
  return string.match(package.config, '^[^\n]')
end

--
-- @desc:
--   Function that splits an input string into an iterable object. A delimiter
--   can be specified to split the string at this specified character.
-- @param s: string
--   The input string to be split.
-- @param delimiter: string
--   The character(s) at which to split the `s` variable. Defaults to a space
--   character.
-- @return: string[]
--   Returns an iterable object of strings after breaking `s` by the specified
--   delimiter.
--
local split = function(s, delimiter)
  local delimiter = delimiter or ' '
  return string.gmatch(s, string.format('[^%s]+', delimiter))
end

--
-- @desc
--   A utility function to concatenate a relative file path, filename, and file
--   type into the desired target path.
-- @param fpath: string
--   A filepath (excluding the file name).
-- @param fname: string
--   A target filename (excluding an extension).
-- @param ftype: string
--   The file type of the target file. Defaults to `.lua` files.
-- @return: string
--   A target filepath, with the correct directory separator character.
local get_fpath = function(fpath, fname, ftype)
  local ftype = ftype or 'lua'
  local path = table.concat({ fpath, ftype, fname }, get_separator())
  return path
end

--
-- @desc:
--   Function that searches for a target filename inside Lua paths and Neovim
--   runtime paths. A target filepath is returned if it can be found inside
--   these paths.
-- @param fpath: string
--   The relative filepath to be found inside the Lua and Neovim paths,
--   e.g., `/user/setup/diagnostics`.
-- @param ftype: string
--   The file type of the target file. Defaults to `.lua` files.
-- @return: string | nil
--   The target file path if it can be found inside the Lua or Neovim (runtime)
--   paths. Otherwise, `nil` is returned.
--
local search_paths_for_file = function(fpath, ftype)
  ftype = ftype or 'lua'

  local paths

  -- First, search for the filepath in Lua modules.
  paths = string.gsub(package.path, '%?', fpath)
  for path in split(paths, ';') do
    if vim.fn.filereadable(path) == 1 then
      return path
    end
  end

  -- If a Lua module can't be found, search for the filepath in Neovim modules.
  paths = vim.api.nvim_list_runtime_paths()
  local module_fname = fpath .. '.' .. ftype
  local init_fname = fpath .. get_separator() .. 'init.' .. ftype
  local target_fpath

  for _, path in pairs(paths) do
    -- Look for a direct module name from the `fname` input.
    target_fpath = get_fpath(path, module_fname, ftype)
    if vim.fn.filereadable(target_fpath) == 1 then
      return target_fpath
    end

    -- If a file related to `fname` does not exist, try to find an `init.lua`
    -- file inside the `path/fname/` directory if it exists.
    target_fpath = get_fpath(path, init_fname, ftype)
    if vim.fn.filereadable(target_fpath) == 1 then
      return target_fpath
    end
  end
end

--
-- @desc
--   Function (global) that searches for the virtual filepath `v_fpath` inside
--   Lua and Neovim modules.
-- @param v_fpath: string
--   The virtual filepath to be searched for. This is the argument found inside
--   `dofile() | loadfile() | require()` statements.
-- @return: string | nil
--   A real filepath as a string if `v_fpath` can be found as a Lua or Neovim
--   module. Otherwise, `nil` is returned.
--
function _G.search_for_path(v_fpath)
  -- Substitute all `.` characters in `v_fpath` to create a real filename path.
  local fpath = vim.fs.normalize(string.gsub(v_fpath, '[.]', '/'))

  return search_paths_for_file(fpath)
end

--
-- @desc
--   A setup script to be invoked by the user to activate `gf` functionality in
--   Lua files.
-- @return: nil
--
M.setup = function()
  -- Create parameters to go to the file in `require()` statements using `gf`.
  vim.opt_local.path:prepend(',' .. vim.fn.stdpath 'config' .. '/lua')
  vim.opt_local.include = [=[\v<((do|load)file|require)\s*\(?['"]\zs[^'"]+\ze['"]]=]
  vim.opt_local.includeexpr = 'v:lua.search_for_path(v:fname)'
end

return M
