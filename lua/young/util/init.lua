local util = {}

xy.util = util

util.join_paths = _G.join_paths

function util.toggle_autoformat()
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

function util.unrequire(m)
  package.loaded[m] = nil
  _G[m] = nil
end

function util.gsub_args(args)
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
function util.is_file(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == 'file' or false
end

--- Checks whether a given path exists and is a directory
--@param path (string) path to check
--@returns (bool)
function util.is_directory(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == 'directory' or false
end

--- Returns a table with the default values that are missing.
--- either paramter can be empty.
--@param config (table) table containing entries that take priority over defaults
--@param default_config (table) table contatining default values if found
function util.apply_defaults(config, default_config)
  config = config or {}
  default_config = default_config or {}
  local new_config = vim.tbl_deep_extend('keep', vim.empty_dict(), config)
  new_config = vim.tbl_deep_extend('keep', new_config, default_config)
  return new_config
end

--@param set1: set to be modified
function util.add_to_set(set1, set2)
  for _, v in ipairs(set2) do
    if not vim.tbl_contains(set1, v) then
      table.insert(set1, v)
    end
  end
end

--@note: use vim.list_extend instead
-- function util.append_to_list(a, b)
--   for _, v in ipairs(b) do
--     table.insert(a, v)
--   end
-- end

--@param para: table or single value
function util.defer(fn, para, time)
  -- wrap it!
  para = type(para) == 'table' and para or { para }
  local fn_box = function()
    fn(unpack(para))
  end
  time = time or 20
  vim.defer_fn(fn_box, time)
end

--@note: pairs also iter over number index
function util.shallow_force(a, b)
  for k, v in pairs(b) do
    a[k] = v
  end
end

function util.shallow_keep(a, b)
  for k, v in pairs(b) do
    if not a[k] then
      a[k] = v
    end
  end
end

function util.echo(t)
  local chunks = {}
  for _, text in ipairs(t) do
    chunks[#chunks + 1] = { text, 'WarningMsg' }
  end
  vim.api.nvim_echo(chunks, false, {})
end

function util.echomsg(t)
  local chunks = {}
  for _, text in ipairs(t) do
    chunks[#chunks + 1] = { text, 'WarningMsg' }
  end
  vim.api.nvim_echo(chunks, true, {})
end

---A terser proxy for `nvim_replace_termcodes`
---@param str string
---@return string
function util.t(str)
  return api.nvim_replace_termcodes(str, true, true, true)
end

-- function _G.smart_tab()
--   return vim.fn.pumvisible() == 1 and util.t '<C-N>' or util.t '<Tab>'
-- end
-- vim.api.nvim_set_keymap('c', '<C-f>', 'v:lua.smart_tab()', { expr = true, noremap = true })

function util.relative(path, base)
  return vim.fn.fnamemodify(path, ':s?' .. vim.fn.escape(base, '\\') .. '??')
end

function util.relative_home(path)
  return vim.fn.fnamemodify(path, ':~')
end

function util.relative_current(path)
  return vim.fn.fnamemodify(path, ':.')
end

return util
