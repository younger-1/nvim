local tool = {}

xy.tool = tool

-- From: <https://github.com/nvim-lua/plenary.nvim/blob/8c6cc07a68b65eb707be44598f0084647d495978/lua/plenary/reload.lua#L3>
local unload_module = function(found, module_name, starts_with_only)
  -- TODO: Might need to handle cpath / compiled lua packages? Not sure.
  local matcher
  if not starts_with_only then
    matcher = function(pack)
      return string.find(pack, module_name, 1, true)
    end
  else
    matcher = function(pack)
      return string.find(pack, '^' .. module_name)
    end
  end

  -- TODO: Handle impatient.nvim automatically.
  local luacache = (_G.__luacache or {}).cache

  print 'Start unload:'
  for pack, _ in pairs(package.loaded) do
    if matcher(pack) then
      print('    ' .. pack .. ' is found')
      package.loaded[pack] = nil
      table.insert(found, pack)

      if luacache then
        luacache[pack] = nil
      end
    end
  end
end

-- For manual reload
tool.rr = function(...)
  local mods = { ... }

  -- Reload the current buffer
  if #mods == 0 then
    local bufpath = vim.api.nvim_buf_get_name(0) -- "/home/young/.config/nvim/lua/young/tool/init.lua"
    bufpath = vim.split(bufpath, '/') -- { "", "home", "young", ".config", "nvim", "lua", "young", "tool", "init.lua" }
    local modpath = { vim.split(bufpath[#bufpath], '.', { plain = true })[1] } -- { "init" }
    if modpath[1] == 'init' then
      modpath = {}
    end

    for i = #bufpath - 1, 1, -1 do
      if i == 1 then
        print('Invalid lua file path: ' .. vim.api.nvim_buf_get_name(0))
        return
      end
      if bufpath[i] == 'lua' then
        break
      end
      table.insert(modpath, 1, bufpath[i])
    end
    modpath = table.concat(modpath, '.')
    package.loaded[modpath] = nil
    print('Reload: ' .. modpath)
    return
  end

  pp(mods)
  local found = {}
  for _, mod in ipairs(mods) do
    -- require("plenary").reload.reload_module(mod)
    unload_module(found, mod, true)
  end

  print 'Reload:'
  for _, pack in ipairs(found) do
    require(pack)
    print('    ' .. pack .. ' is updated')
  end

  -- TODO: may be to reload
  -- require("util").reload_lv_config()
end

-- Completion for not yet loaded plugins
-- Intended to provide completion for PackerLoad command
-- local loader_complete = function(lead, _, _)
--   local completion_list = {}
--   for name, plugin in pairs(_G.packer_plugins) do
--     if vim.startswith(name, lead) and not plugin.loaded then
--       table.insert(completion_list, name)
--     end
--   end
--   table.sort(completion_list)
--   return completion_list
-- end

tool.rr_complete = function(lead, _, _)
  local completion_list = {}
  for name, _ in pairs(_G.package.loaded) do
    if vim.startswith(name, lead) then
      table.insert(completion_list, name)
    end
  end
  table.sort(completion_list)
  return completion_list
end

-- [DoomUpdate](https://github.com/NTBBloodbath/doom-nvim/blob/a033ddec6e53cf154306b7c0391166f753d519be/lua/doom/core/functions/init.lua#L332)
-- M.update_lunarvim = function()
--   -- save_backup_hashes()
--   Log:info "Pulling LunarVim remote changes ..."

--   -- local updated_lunarvim, update_err = pcall(function()
--   os.execute("git -C " .. require("bootstrap").runtime_dir .. "/lvim" .. " pull -q")
--   -- end)

--   -- if not updated_lunarvim then
--   --   Log:error("Error while updating Doom. Traceback:\n" .. update_err)
--   -- end
--   -- Run syntax_on event to fix UI if it's broke after the git pull
--   -- vim.cmd "syntax on"
--   Log:info "Successfully updated Lunarvim, please restart"
-- end

local rnu
tool.no_rnu = function()
  rnu = vim.wo.rnu
  vim.wo.rnu = false
end

tool.rnu = function()
  vim.wo.rnu = rnu
end

tool.no_cursorline = function()
  -- if vim.wo.diff then
  --   return
  -- end
  vim.w._cursorline = vim.wo.cursorline
  vim.wo.cursorline = false
end

tool.cursorline = function()
  vim.wo.cursorline = vim.w._cursorline
end

local ve_on = 'all'
local ve_off = 'onemore'
tool.visualedit = function()
  if vim.o.ve == ve_off then
    vim.o.ve = ve_on
  else
    vim.o.ve = ve_off
  end
end

-- Toggle to disable mouse mode and indentlines for easier paste
tool.toggle_mouse = function()
  if vim.o.mouse == '' then
    vim.o.mouse = 'nvi'
    print 'Mouse enabled'
    vim.o.signcolumn = xy.opt.signcolumn
    vim.o.number = xy.opt.number
    vim.o.relativenumber = xy.opt.relativenumber
    vim.cmd 'silent! IndentBlanklineEnable'
  else
    vim.o.mouse = ''
    print 'Mouse disabled'
    vim.o.signcolumn = 'no'
    vim.o.number = false
    vim.o.relativenumber = false
    vim.cmd 'silent! IndentBlanklineDisable'
  end
  vim.cmd 'set mouse?'
end

tool.toggle_foldcolumn = function()
  if vim.o.foldcolumn == '0' then
    vim.o.foldcolumn = '1'
  else
    vim.o.foldcolumn = '0'
  end
  vim.cmd 'set foldcolumn?'
end

tool.toggle_signcolumn = function()
  if vim.o.signcolumn == 'no' then
    vim.o.signcolumn = 'yes:2'
  else
    vim.o.signcolumn = 'no'
  end
  vim.cmd 'set signcolumn?'
end

local ls

tool.get_ls = function(servername)
  if ls then
    for bufnr, _ in pairs(ls.attached_buffers) do
      if bufnr == vim.fn.bufnr() then
        print '[Cat!]'
        return
      end
    end
  end

  ls = nil

  for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
    if not servername and client.name ~= 'null-ls' then
      ls = client
      return
    end
    if servername and client.name == servername then
      ls = client
      return
    end
  end
end

tool.print_ls = function(...)
  local keys = { ... }

  tool.get_ls()
  if not ls then
    print '[Failed]: Not such server'
    return
  end

  -- Print entire client
  if #keys == 0 then
    pp(ls)
    return
  end

  local info = {}
  for _, k in ipairs(keys) do
    info[k] = ls[k]
  end
  pp(info)
end

tool.print_ls_complete = function(lead, _, _)
  local completion_list = {}

  tool.get_ls()
  if not ls then
    print '[Failed]: Not such server'
    return
  end

  for name, _ in pairs(ls) do
    if vim.startswith(name, lead) then
      table.insert(completion_list, name)
    end
  end
  table.sort(completion_list)
  return completion_list
end

-- TODO: pick certain LS
-- M.pick_ls
-- commands Pls <servername> <key>

tool.chdir = function(force)
  -- TODO: buftype test
  -- lcd is only need when running ProjectRoot manually
  local cwd_old = vim.fn.getcwd()
  local root = require('project_nvim.project').get_project_root()
  if root then
    vim.cmd('lcd ' .. root)
    vim.notify('[Young] dir: ' .. root)
  end

  -- FIXME: implemented in project_nvim by using patterns_fallback
  -- if not force then
  --   return
  -- end
  -- local cwd = vim.fn.getcwd()
  -- gg(0, cwd_old)
  -- gg(1, cwd)
  -- if cwd == cwd_old then
  --   vim.cmd [[silent! lcd %:p:h]]
  -- end
end

local function hl(name, val)
  api.nvim_set_hl(0, name, val)
end

tool.hi_lsp_ref = function()
  if vim.o.bg == 'dark' then
    -- vim.cmd [[
    --   " hi LspReferenceText  gui=bold,undercurl guibg=DarkGray
    --   hi LspReferenceText  gui=bold,undercurl guibg=DarkCyan
    --   hi LspReferenceRead  gui=bold,undercurl guibg=DarkGreen
    --   hi LspReferenceWrite gui=bold,undercurl guibg=DarkRed
    -- ]]
    hl('LspReferenceText', {
      undercurl = true, --[[ bg = '#27406b' ]]
    })
    hl('LspReferenceRead', { undercurl = true, bg = '#3d5213' })
    hl('LspReferenceWrite', { undercurl = true, bg = '#4a0f23' })
  else
    vim.cmd [[
      " hi LspReferenceText  gui=bold,undercurl guibg=LightGray
      hi LspReferenceText  gui=bold,undercurl guibg=LightCyan
      hi LspReferenceRead  gui=bold,undercurl guibg=LightGreen
      hi LspReferenceWrite gui=bold,undercurl guibg=LightRed
    ]]
  end
end

tool.add_border = function()
  -- local win = vim.api.nvim_get_current_win()
  -- vim.api.nvim_win_set_config(win, {
  --   border = 'rounded',
  -- })
  vim.api.nvim_win_set_config(0, { border = 'rounded' })
end

local bar_flag = true
tool.toggle_tabline = function()
  if bar_flag then
    vim.cmd 'BarbarDisable'
    require('young.mod.tabline').done()
  else
    require('young.mod.barbar').done()
  end
  bar_flag = not bar_flag
end

tool.set_cursor_floating_win = function()
  local winids = vim.api.nvim_tabpage_list_wins(0)
  winids = vim.tbl_filter(function(winid)
    local wincfg = vim.api.nvim_win_get_config(winid)
    return wincfg.relative ~= ''
  end, winids)

  if #winids == 0 then
    xy.util.echo { 'No floating window' }
    return
  end

  if #winids > 1 then
    xy.util.echo { 'Two or more floating window' }
    -- M.pick_floating_win(winids)
  end

  for _, winid in ipairs(winids) do
    if winid ~= vim.api.nvim_get_current_win() then
      vim.api.nvim_set_current_win(winid)
      xy.map.n { 'q', '<cmd>close<cr>', buffer = true }
      return
    end
  end
end

tool.startup_time = function()
  xy.util.defer(function()
    for i, times in ipairs(xy.startup_time or {}) do
      -- pp(times)
      -- local str = vim.fn['repeat']('+', times.depth)
      print(('[%-40s%-3d] [%-8s] [%d] - %f'):format(
        xy.util.relative(times.file_name, join_paths(vim.fn.stdpath 'config', '')),
        -- xy.util.relative_home(times.file_name),
        times.currentline,
        times.func_name,
        times.depth,
        times.hr_time
      ))
    end
  end)
end

tool.startup_event = function(event)
  local now = vim.fn.reltimefloat(vim.fn.reltime(xy.startup_time.rel_start))
  xy.util.echomsg { fmt('%s: %f', event, now) }
end

--- Usage:
--- 1. Call `local stop = tool.profile('my-log')` at the top of the file
--- 2. At the bottom of the file call `stop()`
--- 3. Restart neovim, the newly created log file should open
tool.profile = function(filename)
  local base = '/tmp/config/profile/'
  vim.fn.mkdir(base, 'p')
  local success, profile = pcall(require, 'plenary.profile.lua_profiler')
  if not success then
    vim.api.nvim_echo({ 'Plenary is not installed.', 'Title' }, true, {})
  end
  profile.start()
  return function()
    profile.stop()
    local logfile = base .. filename .. '.log'
    profile.report(logfile)
    vim.defer_fn(function()
      vim.cmd('tabedit ' .. logfile)
    end, 1000)
  end
end

-- @see require'lazy.util'.open
tool.open_github_url = function()
  ---@type string
  local line = fn.getline '.'
  -- local names = fn.matchlist(line, '[A-Za-z0-9-_.]+/[A-Za-z0-9-_.]+')
  local name = line:match '[%a%d%.%-%_]+/[%a%d%.%-%_]+'
  if nil == name then
    -- vim.notify 'Not url for current line!'
    vim.notify_once(fmt('[open_url] not url in (%d, %d) of %s', fn.line '.', fn.col '.', fn.bufname()))
    return
  end
  local url = 'https://github.com/' .. name
  -- fn.system { xy.open_cmd, url }
  local ret = vim.fn.jobstart({ xy.open_cmd, url }, { detach = true })
  if ret <= 0 then
    local msg = {
      'Failed to open github url',
      ret,
      xy.open_cmd,
      url,
    }
    vim.notify(table.concat(msg, '\n'), vim.log.levels.ERROR)
  end
end

-- <https://superuser.com/questions/1267574/reload-file-in-vim-without-scrolling>
tool.keepview = function(cmd)
  local v = fn.winsaveview()
  vim.cmd(cmd)
  fn.winrestview(v)
end

function tool.putline(how)
  local body, type = fn.getreg(vim.v.register), fn.getregtype(vim.v.register)
  if type == 'V' then
    vim.cmd('normal! "' .. vim.v.register .. how)
  else
    fn.setreg(vim.v.register, body, 'l')
    vim.cmd('normal! "' .. vim.v.register .. how)
    fn.setreg(vim.v.register, body, type)
  end
end

function tool.blink_cursor()
  local cnt = 0
  local blink_times = 6
  local timer = uv.new_timer()

  timer:start(
    0,
    100,
    vim.schedule_wrap(function()
      vim.cmd [[
        set cursorcolumn!
        set cursorline!
      ]]

      cnt = cnt + 1
      if cnt == blink_times then
        timer:stop()
      end
    end)
  )
end

function tool.open_file(file)
  if vim.fn.bufexists(file) == 1 then
    vim.cmd.buffer(file)
    vim.o.buflisted = true
  else
    vim.cmd.edit(file)
  end
end

-- TODO: vim.keymap.set (or xy.{map,command}) loction by using debug
-- TODO: {keymap,command,autocmd,option,function,abbr,highlight,colorscheme,ftplugin}
function tool.get_def_locations(tbl)
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

function tool.buf_git_root(cd)
  cd = cd or 'tcd'

  local dir = xy.util.git_root()
  if dir then
    vim.cmd[cd](dir)
    xy.util.echomsg { fmt('[young]: %s %s', cd, dir:gsub(vim.pesc(vim.fn.expand '$HOME'), '~')) }
  else
    xy.util.echomsg { fmt '[young]: not found git root' }
  end
end

function tool.goto_lua_module()
  ---@type string, string
  local modname, funname

  local line = api.nvim_get_current_line()
  -- ("local foo, bar = require('abc'), require('efg')"):find 'require%([\'"](.-)[\'"]%)'
  -- for x in ("local abc_var, efg_var = require('abc'), require('efg')"):gmatch 'require%([\'"](.-)[\'"]%)' do
  --   print(x)
  -- end
  local pat = [[require[%s(]?['"]()(.-)()['"][%s)]?%.?()([%w_]*)()]]
  for mod_start, mod, mod_end, fun_start, fun, fun_end in line:gmatch(pat) do
    local col = fn.getpos('.')[3]
    if mod_start <= col and col < mod_end then
      modname = mod
    end
    if fun_start <= col and col < fun_end then
      modname = mod
      funname = fun
    end
  end

  if not modname then
    pat = [[()(vim[%.%w_]+)()%.()([%w_]+)()]]
    for mod_start, mod, mod_end, fun_start, fun, fun_end in line:gmatch(pat) do
      local col = fn.getpos('.')[3]
      if mod_start <= col and col < mod_end then
        modname = mod
      end
      if fun_start <= col and col < fun_end then
        modname = mod
        funname = fun
      end
    end
  end

  if not modname then
    xy.util.echo { '[young] goto_lua_module: not mod/fun under cursor' }
    return false
  end

  local ret = vim.loader.find(modname)
  if vim.tbl_isempty(ret) then
    -- xy.util.echomsg { '[young] goto_lua_module: [' .. modname .. '] not loaded yet' }
    local ok, err = pcall(require, modname)
    if not ok then
      xy.util.echo { '[young] goto_lua_module: ' .. vim.split(err, '\n')[1] }
      return false
    end
    ret = vim.loader.find(modname)
  end
  local path = ret[1].modpath

  local line
  if funname then
    line = debug.getinfo(require(modname)[funname], 'S').linedefined
  end

  -- gg(1, modname, path)
  -- gg(2, funname, line)

  vim.lsp.util.jump_to_location({
    uri = vim.uri_from_fname(path),
    range = line and line >= 1 and {
      start = { character = 0, line = line - 1 },
      -- ['end'] = { character = 0, line = 0 },
    },
  }, 'utf-8', true)

  return true
end

return tool
