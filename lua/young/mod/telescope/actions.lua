-- TODO: https://github.com/nvim-telescope/telescope.nvim/pull/1084#issuecomment-913849414
local action_mt = require 'telescope.actions.mt'
local action_state = require 'telescope.actions.state'

local function get_locs(title, entry)
  local def = ({
    ['Key Maps'] = {
      type = 'map',
      para = entry.mode,
      name = entry.lhs,
    },
    ['Commands'] = {
      type = 'command',
      name = entry.name,
    },
    ['autocommands'] = {
      type = 'autocmd',
      para = entry.value.group_name,
      name = entry.value.event,
    },
    ['options'] = {
      type = 'set',
      name = entry.value.name,
    },
    ['Highlights'] = {
      type = 'highlight',
      name = entry.value,
    },
  })[title]

  if def == nil then
    return
  end
  -- pp(def)
  local locs = xy.util.get_def_locations(def)
  if #locs == 0 then
    return
  end

  return locs
end

local M = action_mt.transform_mod {
  print_entry = function(prompt_bufnr)
    local title = action_state.get_current_picker(prompt_bufnr).prompt_title
    local entry = action_state.get_selected_entry()
    local locs = get_locs(title, entry)
    print('Picker: ' .. vim.inspect(title))
    print('Entry: ' .. vim.inspect(entry))
    print('Def: ' .. vim.inspect(locs))
  end,
  open_def_locations = function(prompt_bufnr)
    local title = action_state.get_current_picker(prompt_bufnr).prompt_title
    local entry = action_state.get_selected_entry()
    local locs = get_locs(title, entry)
    if locs == nil then
      return
    end

    local function open_file(path, line)
      if vim.fn.bufexists(prompt_bufnr) == 1 then
        require('telescope.actions').close(prompt_bufnr)
      end
      vim.cmd('e ' .. path)
      -- vim.cmd(':' .. line)
      vim.fn.setpos('.', { 0, line, 1 })
    end

    -- TODO:preview
    vim.ui.select(locs, {
      prompt = '[young] Jump to def locations',
      format_item = function(item)
        return ('%s: %s'):format(item[1], item[2])
      end,
    }, function(choice)
      if choice then
        open_file(choice[1], choice[2])
      end
    end)
  end,
}

return M
