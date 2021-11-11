local M = {}
-- local Log = require "lvim.core.log"

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
      return string.find(pack, "^" .. module_name)
    end
  end

  -- Handle impatient.nvim automatically.
  local luacache = (_G.__luacache or {}).cache

  print "Start unload:"
  for pack, _ in pairs(package.loaded) do
    if matcher(pack) then
      print("    " .. pack .. " is found")
      package.loaded[pack] = nil
      table.insert(found, pack)

      if luacache then
        luacache[pack] = nil
      end
    end
  end
end

M.reload_file = function(pack)
  local luacache = (_G.__luacache or {}).cache
  package.loaded[pack] = nil
  if luacache then
    luacache[pack] = nil
  end
end

-- For manual reload
M.rr = function(...)
  local mods = { ... }

  -- Reload the current buffer
  if #mods == 0 then
    local bufpath = vim.api.nvim_buf_get_name(0)
    -- local bufpath = "/home/.local/lua/start/packer.nvim/lua/packer/clean.lua"
    bufpath = vim.split(bufpath, "/") -- { "", "home", ".local", "lua", "start", "packer.nvim", "lua", "packer", "clean.lua" }
    local pack = { vim.split(bufpath[#bufpath], ".", true)[1] } -- "clean"
    for i = #bufpath - 1, 1, -1 do
      if i == 1 and bufpath[i] ~= "lua" then
        print("Invalid pack path: " .. vim.api.nvim_buf_get_name(0))
        return
      end
      if bufpath[i] == "lua" then
        break
      end
      table.insert(pack, 1, bufpath[i])
    end
    pack = table.concat(pack, ".")
    M.reload_file(pack)
    print("Reload: " .. pack)
    require("utils").reload_lv_config()
    return
  end

  pp(mods)
  local found = {}
  for _, mod in ipairs(mods) do
    -- require("plenary").reload.reload_module(mod)
    unload_module(found, mod, true)
  end

  print "Reload:"
  for _, pack in ipairs(found) do
    require(pack)
    print("    " .. pack .. " is updated")
  end

  require("utils").reload_lv_config()
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

M.rr_complete = function(lead, _, _)
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
M.toggle_tabline = function()
  if bar_flag then
    vim.cmd "BarbarDisable"
    require("young.mod.tabline").config()
    require("young.key.mappings").load {
      normal_mode = {
        ["<S-l>"] = ":TablineBufferNext<CR>",
        ["<S-h>"] = ":TablineBufferPrevious<CR>",
      },
    }
  else
    vim.cmd "BarbarEnable"
    require("young.key.mappings").load {
      normal_mode = {
        ["<S-l>"] = ":BufferNext<CR>",
        ["<S-h>"] = ":BufferPrevious<CR>",
      },
    }
  end
  bar_flag = not bar_flag
end

-- Toggle to disable mouse mode and indentlines for easier paste
M.toggle_mouse = function()
  if vim.o.mouse == '' then
    -- vim.cmd[[IndentBlanklineEnable]]
    vim.o.mouse = 'nvi'
    print 'Mouse enabled'
    vim.wo.signcolumn = 'yes'
    vim.wo.number = true
  else
    -- vim.cmd[[IndentBlanklineDisable]]
    vim.o.mouse = ''
    print 'Mouse disabled'
    vim.wo.signcolumn = 'no'
    vim.wo.number = false
  end
end

return M
