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

  -- Handle impatient.nvim automatically.
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

tool.reload_file = function(pack)
  local luacache = (_G.__luacache or {}).cache
  package.loaded[pack] = nil
  if luacache then
    luacache[pack] = nil
  end
end

-- For manual reload
tool.rr = function(...)
  local mods = { ... }

  -- Reload the current buffer
  if #mods == 0 then
    local bufpath = vim.api.nvim_buf_get_name(0)
    -- local bufpath = "/home/.local/lua/start/packer.nvim/lua/packer/clean.lua"
    bufpath = vim.split(bufpath, '/') -- { "", "home", ".local", "lua", "start", "packer.nvim", "lua", "packer", "clean.lua" }
    local pack = { vim.split(bufpath[#bufpath], '.')[1] } -- "clean"
    for i = #bufpath - 1, 1, -1 do
      if i == 1 and bufpath[i] ~= 'lua' then
        print('Invalid lua file path: ' .. vim.api.nvim_buf_get_name(0))
        return
      end
      if bufpath[i] == 'lua' then
        break
      end
      table.insert(pack, 1, bufpath[i])
    end
    pack = table.concat(pack, '.')
    tool.reload_file(pack)
    print('Reload: ' .. pack)
    -- require('util').reload_lv_config()
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

local bar_flag = true
tool.toggle_tabline = function()
  if bar_flag then
    vim.cmd 'BarbarDisable'
    require('young.mod.tabline').config()
    xy.map.n { '<S-l>', ':TablineBufferNext<CR>' }
    xy.map.n { '<S-h>', ':TablineBufferPrevious<CR>' }
  else
    vim.cmd 'BarbarEnable'
    xy.map.n { '<S-l>', ':BufferNext<CR>' }
    xy.map.n { '<S-h>', ':BufferPrevious<CR>' }
  end
  bar_flag = not bar_flag
end

-- Toggle to disable mouse mode and indentlines for easier paste
tool.toggle_mouse = function()
  if vim.o.mouse == '' then
    vim.o.mouse = 'nvi'
    print 'Mouse enabled'
    vim.wo.signcolumn = 'yes:2'
    vim.wo.number = true
    vim.cmd 'silent! IndentBlanklineEnable'
  else
    vim.o.mouse = ''
    print 'Mouse disabled'
    vim.wo.signcolumn = 'no'
    vim.wo.number = false
    vim.cmd 'silent! IndentBlanklineDisable'
  end
end

tool.toggle_foldcolumn = function()
  if vim.o.foldcolumn == '0' then
    vim.o.foldcolumn = '1'
  else
    vim.o.foldcolumn = '0'
  end
end

tool.toggle_signcolumn = function()
  if vim.o.sign == 'no' then
    vim.o.foldcolumn = 'yes:2'
  else
    vim.o.foldcolumn = 'no'
  end
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

  for _, client in pairs(vim.lsp.buf_get_clients()) do
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

local rnu
tool.nornu = function()
  rnu = vim.o.rnu
  vim.o.rnu = false
end

tool.rnu = function()
  vim.o.rnu = rnu
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

tool.lsp_ref = function()
  if vim.o.bg == 'dark' then
    vim.cmd [[
      hi LspReferenceText  cterm=bold ctermbg=DarkCyan  blend=10 gui=bold guibg=DarkCyan
      hi LspReferenceRead  cterm=bold ctermbg=DarkGreen blend=10 gui=bold guibg=DarkGreen
      hi LspReferenceWrite cterm=bold ctermbg=DarkRed   blend=10 gui=bold guibg=DarkRed
    ]]
  else
    vim.cmd [[
      hi LspReferenceText  cterm=bold ctermbg=DarkCyan  blend=10 gui=bold guibg=LightCyan
      hi LspReferenceRead  cterm=bold ctermbg=DarkGreen blend=10 gui=bold guibg=LightGreen
      hi LspReferenceWrite cterm=bold ctermbg=DarkRed   blend=10 gui=bold guibg=LightRed
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

tool.toggle_indent_style = function()
  require('young.mod.indent_blankline').hot()
end

tool.toggle_notify = function()
  require('young.mod.notify').toggle()
end

tool.toggle_notify_style = function()
  require('young.mod.notify').hot()
end

tool.toggle_zoom = function()
  vim.cmd 'call WinZoomToggle()'
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
end

tool.startup_event = function(event)
  local now = vim.fn.reltimefloat(vim.fn.reltime(xy.startup_time.a))
  xy.util.echomsg { fmt('%s: %g', event, now) }
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

tool.open_url = function()
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
  fn.jobstart({ xy.open_cmd, url }, { detach = true })
end

-- <https://superuser.com/questions/1267574/reload-file-in-vim-without-scrolling>
tool.keepview = function(cmd)
  local v = fn.winsaveview()
  vim.cmd(cmd)
  fn.winrestview(v)
end

return tool
