local utils = {}
local uv = vim.loop

utils.join_paths = _G.join_paths

function utils.toggle_autoformat()
  if lvim.format_on_save then
    require('lvim.core.autocmds').define_augroups {
      autoformat = {
        {
          'BufWritePre',
          '*',
          ':silent lua vim.lsp.buf.formatting_sync()',
        },
      },
    }
    -- Log:debug "Format on save active"
  end

  if not lvim.format_on_save then
    vim.cmd [[
      if exists('#autoformat#BufWritePre')
        :autocmd! autoformat
      endif
    ]]
    -- Log:debug "Format on save off"
  end
end

function utils.unrequire(m)
  package.loaded[m] = nil
  _G[m] = nil
end

function utils.gsub_args(args)
  if args == nil or type(args) ~= 'table' then
    return args
  end
  local buffer_filepath = vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
  for i = 1, #args do
    args[i] = string.gsub(args[i], '${FILEPATH}', buffer_filepath)
  end
  return args
end

--- Checks whether a given path exists and is a file.
--@param path (string) path to check
--@returns (bool)
function utils.is_file(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == 'file' or false
end

--- Checks whether a given path exists and is a directory
--@param path (string) path to check
--@returns (bool)
function utils.is_directory(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == 'directory' or false
end

--- Returns a table with the default values that are missing.
--- either paramter can be empty.
--@param config (table) table containing entries that take priority over defaults
--@param default_config (table) table contatining default values if found
function utils.apply_defaults(config, default_config)
  config = config or {}
  default_config = default_config or {}
  local new_config = vim.tbl_deep_extend('keep', vim.empty_dict(), config)
  new_config = vim.tbl_deep_extend('keep', new_config, default_config)
  return new_config
end

--@param set1: set to be modified
function utils.add_to_set(set1, set2)
  for _, v in ipairs(set2) do
    if not vim.tbl_contains(set1, v) then
      table.insert(set1, v)
    end
  end
end

--@param para: table or single value
function utils.defer(fn, para, time)
  -- wrap it!
  para = type(para) == 'table' and para or { para }
  local fn_box = function()
    fn(unpack(para))
  end
  time = time or 20
  vim.defer_fn(fn_box, time)
end

return utils
