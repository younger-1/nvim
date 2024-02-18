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
function util.is_dir(path)
  local stat = uv.fs_stat(vim.fs.normalize(path))
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

function util.defer(fn, para, time)
  local fn_box = function()
    fn(para)
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

---Shortcut for nvim_replace_termcodes
---@param keys string
---@return string
-- from: require('cmp.utils.keymap').t
function util.tt(keys)
  return (
    string.gsub(keys, '(<[A-Za-z0-9\\%-%[%]%^@]->)', function(match)
      return vim.api.nvim_eval(string.format([["\%s"]], match))
    end)
  )
end

-- function _G.smart_tab()
--   return vim.fn.pumvisible() == 1 and util.t '<C-N>' or util.t '<Tab>'
-- end
-- vim.api.nvim_set_keymap('c', '<C-f>', 'v:lua.smart_tab()', { expr = true, noremap = true })

function util.relative(path, base)
  -- for windows: vim.fn.fnamemodify('C:\\Users\\123', ':s?' .. 'C:\\\\Users\\\\' .. '??')
  -- return vim.fn.fnamemodify(path, ':s?' .. vim.fn.escape(base, '\\') .. '??')
  path = vim.fs.normalize(path)
  base = vim.fs.normalize(base)
  return vim.fn.fnamemodify(path, ':s?' .. base .. '??')
end

function util.relative_home(path)
  return vim.fn.fnamemodify(path, ':~')
end

function util.relative_current(path)
  return vim.fn.fnamemodify(path, ':.')
end

function util.hl_link_name(hl_name)
  return fn.synIDattr(fn.synIDtrans(fn.hlID(hl_name)), 'name')
end

function util.is_hl_link(hl_name)
  return util.hl_link_name(hl_name) ~= hl_name
end

function util.is_gui_hl_set(hl_name)
  local exists, hl = pcall(api.nvim_get_hl_by_name, hl_name, true)
  local color = hl.foreground or hl.background or hl.reverse
  return exists and color ~= nil
end

-- <https://github.com/tjdevries/leftpad.nvim>
function util.leftpad(str_or_num, padding, char)
  if type(str_or_num) == 'string' then
    return string.format('%' .. tostring(padding) .. 's', str_or_num)
  else
    return string.rep(char and tostring(char) or '0', padding - #tostring(str_or_num)) .. tostring(str_or_num)
  end
end

function util.get_visual_selection()
  local x, y = fn.getpos('v')[3], fn.getpos('.')[3]
  if x > y then
    x, y = y, x
  end
  return fn.getline(fn.line '.'):sub(x, y)
end

-- Better than util.get_visual_selection()
-- 1. gv works as usual.
-- 2. deal with any unicode.
function util.get_visual_selection_by_reg(reg)
  reg = reg or vim.v.register
  local old_text, type = fn.getreg(reg), fn.getregtype(reg)

  -- NOTE:feedkeys do NOT update register
  -- gg(1, fn.getreg(reg))
  -- api.nvim_feedkeys('"' .. reg .. 'y', 'n', false)
  -- fn.feedkeys('"' .. reg .. 'y', 'n')
  -- gg(2, fn.getreg(reg))

  vim.cmd('normal! "' .. reg .. 'y')
  local text = fn.getreg(reg)

  if reg == '"' then
    fn.setreg(vim.v.register, old_text, type)
  end
  return text
end

-- TODO: vim.keymap.set (or xy.{map,command}) loction by using debug
-- TODO: {keymap,command,autocmd,option,function,abbr,highlight,colorscheme,ftplugin}
function util.get_def_locations(tbl)
  local str = tbl.type
  if tbl.type == 'map' then
    str = tbl.mode .. str
    -- tbl.name = tbl.name:gsub('<[Ll]eader>', fn.keytrans(vim.g.mapleader))
    tbl.name = tbl.name:gsub('<[Ll]eader>', '<Space>')
  elseif tbl.type == 'autocmd' then
    str = str .. ' ' .. tbl.group
  end

  str = str .. ' ' .. tbl.name
  if tbl.type == 'set' then
    str = str .. '?'
  end

  local output = fn.execute(str)
  -- pp(str)
  -- pp(output)

  local ret = {}
  -- local idx = output:find(vim.pesc(tbl.name))
  -- local start = output:find(tbl.name, 1, true)
  for path, line in output:gmatch '<Lua %d+: (%S+):(%d+)>' do
    table.insert(ret, { path, line })
  end

  if next(ret) == nil then
    str = 'verbose ' .. str
    output = fn.execute(str)
    for path, line in output:gmatch 'Last set from (%S+) line (%d+)' do
      table.insert(ret, { path, line })
    end
  end

  if next(ret) == nil and tbl.type == 'map' then
    if xy.map.info[tbl.mode] and xy.map.info[tbl.mode][tbl.name] then
      local info = xy.map.info[tbl.mode][tbl.name]
      table.insert(ret, { info.file_name, info.currentline })
    end
  end
  return ret
end

-- xy.util.get_def_locations { type = 'map', para = 'v', name = '<Leader>sg' }
-- xy.util.get_def_locations { type = 'command', name = 'RegDiff' }
-- xy.util.get_def_locations { type = 'autocmd', para = '_number' }
-- xy.util.get_def_locations { type = 'autocmd', name = 'BufDelete' }
-- xy.util.get_def_locations { type = 'map', name = 'j' }
-- xy.util.get_def_locations { type = 'command', name = 'RR' }
-- xy.util.get_def_locations { type = 'autocmd', para = 'init' }
-- xy.util.get_def_locations { type = 'set', name = 'grepprg' }
-- xy.util.get_def_locations { type = 'set', name = 'scrolloff' }
-- xy.util.get_def_locations { type = 'function', name = 'QuickFixToggle' }
-- xy.util.get_def_locations { type = 'highlight', name = 'helpURL' }

--[[
:vmap <leader>sg
x  <Space>     * <Cmd>lua require("which-key").show(" ", {mode = "v", auto = true})<CR>
x  <Space>sg   * <Lua 825: ~/.config/nvim/lua/young/key/visual/leader.lua:36>
                 Grep

:command RegDiff
    Name              Args Address Complete    Definition
|   RegDiff           *                        <Lua 54: ~/.config/nvim/plugin/command.lua:3>

:autocmd _number
--- Autocommands ---
_number  InsertEnter
    *         <Lua 24: ~/.config/nvim/lua/young/tool/init.lua:124>
_number  InsertLeave
    *         <Lua 25: ~/.config/nvim/lua/young/tool/init.lua:129>

:verb map j
   j           * (v:count == 0 ? 'gj' : 'j')
        Last set from ~/.config/nvim/plugin/keymap.vim line 2

:verb set grepprg
  grepprg=rg --vimgrep --smart-case
        Last set from ~/.config/nvim/plugin/option.vim line 6

:verb hi helpURL
helpURL        xxx links to String
        Last set from /usr/share/nvim/runtime/syntax/help.vim line 209

:verb hi IlluminatedWordRead
IlluminatedWordRead xxx gui=underline
                   links to LspReferenceRead
        Last set from Lua
]]

---@see https://github.com/anuvyklack/hydra.nvim/blob/7e2aa29f88d534371c6b0263d3abbfac7c2376ce/lua/hydra/lib/util.lua#L71
-- Recursive subtables
local mt = {}
function mt.__index(self, subtbl)
  self[subtbl] = setmetatable({}, {
    __index = mt.__index,
  })
  return self[subtbl]
end
---Return an empty table, in which any nested tables of any level will be created on fly when they will be accessed.
---Example:
---```
---    local t = util.unlimited_depth_table()
---    t[one][two][three] = 'text'
---```
function util.unlimited_depth_table()
  return setmetatable({}, mt)
end

function util.get_loc()
  local me = debug.getinfo(1, 'S')
  local level = 2
  local info = debug.getinfo(level, 'S')
  while info and info.source == me.source do
    level = level + 1
    info = debug.getinfo(level, 'S')
  end
  info = info or me
  local source = info.source:sub(2)
  source = vim.loop.fs_realpath(source) or source
  return source .. ':' .. info.linedefined
end

---@param value any
---@param opts? {loc:string}
function util.dump(value, opts)
  opts = opts or {}
  opts.loc = opts.loc or util.get_loc()
  if vim.in_fast_event() then
    return vim.schedule(function()
      util.dump(value, opts)
    end)
  end
  opts.loc = vim.fn.fnamemodify(opts.loc, ':~:.')
  local msg = vim.inspect(value)
  vim.notify(msg, vim.log.levels.INFO, {
    title = 'Debug: ' .. opts.loc,
    on_open = function(win)
      vim.wo[win].conceallevel = 3
      vim.wo[win].concealcursor = ''
      vim.wo[win].spell = false
      local buf = vim.api.nvim_win_get_buf(win)
      if not pcall(vim.treesitter.start, buf, 'lua') then
        vim.bo[buf].filetype = 'lua'
      end
    end,
  })
end

function util.get_value(...)
  local value = { ... }
  return vim.tbl_islist(value) and vim.tbl_count(value) <= 1 and value[1] or value
end

function util.dd(...)
  util.dump(util.get_value(...))
end

---@param fn fun()
function util.on_very_lazy(fn)
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      fn()
    end,
  })
end

function util.open_file(file)
  if vim.fn.bufexists(file) == 1 then
    vim.cmd.buffer(file)
  else
    vim.cmd.edit(file)
  end
end

function util.git_root()
  local res = vim.fs.find({ '.git' }, {
    upward = true,
    stop = vim.loop.os_homedir(),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
  })[1]
  return res and vim.fs.dirname(res)
end

return util
