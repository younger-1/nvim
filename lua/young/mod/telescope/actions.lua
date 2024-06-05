-- TODO: https://github.com/nvim-telescope/telescope.nvim/pull/1084#issuecomment-913849414
local actions = require 'telescope.actions'
local action_mt = require 'telescope.actions.mt'
local action_state = require 'telescope.actions.state'

local function get_locs(title, entry)
  local def = ({
    ['Key Maps'] = {
      type = 'map',
      name = entry.lhs,
      mode = (entry.mode or ''):sub(1, 1),
    },
    ['Commands'] = {
      type = 'command',
      name = entry.name,
    },
    ['autocommands'] = {
      type = 'autocmd',
      name = entry.value.event,
      group = (entry.value.group_name or ''):match '^[^<]+' or '',
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
  local locs = xy.tool.get_def_locations(def)
  if #locs == 0 then
    return
  end

  return locs
end

local M = action_mt.transform_mod {
  xy_print_entry = function(prompt_bufnr)
    local _picker = action_state.get_current_picker(prompt_bufnr)
    local picker = {}
    for k, v in pairs(_picker) do
      if
        vim.tbl_contains({
          'multi_icon',
          'initial_mode',
          'selection_caret',
          'selection_strategy',
          'prompt_win',
          'prompt_bufnr',
          'prompt_title',
          -- 'prompt_border',
          'prompt_prefix',
          'results_win',
          'results_bufnr',
          'results_title',
          -- 'results_border',
          'preview_win',
          'preview_bufnr',
          'preview_title',
          -- 'preview_border',
          'original_cword',
          'original_cline',
          'original_cfile',
          'original_win_id',
        }, k)
      then
        picker[k] = v
      end
    end
    local entry = action_state.get_selected_entry()
    local locs = get_locs(picker, entry)
    print('Picker: ' .. vim.inspect(picker))
    print('Entry: ' .. vim.inspect(entry))
    print('Def: ' .. vim.inspect(locs))
  end,

  xy_open_def_locations = function(prompt_bufnr)
    local title = action_state.get_current_picker(prompt_bufnr).prompt_title
    local entry = action_state.get_selected_entry()
    local locs = get_locs(title, entry)
    if locs == nil then
      return
    end

    local function open_file(path, line)
      if vim.fn.bufexists(prompt_bufnr) == 1 then
        actions.close(prompt_bufnr)
      end
      xy.tool.open_file(path)
      -- vim.cmd(':' .. line)
      vim.fn.setpos('.', { 0, line, 1 })
    end

    -- TODO:preview
    vim.ui.select(locs, {
      prompt = '[young] Jump to def locations',
      format_item = function(item)
        return ('%s: %s'):format(item[1], item[2])
      end,
    }, function(item)
      if item then
        open_file(item[1], item[2])
      end
    end)
  end,

  xy_resume = function(prompt_bufnr)
    require('telescope.builtin').resume()
  end,

  -- https://github.com/nvim-telescope/telescope.nvim/issues/814#issuecomment-1238510694
  xy_open_and_resume = function(prompt_bufnr)
    actions.select_default(prompt_bufnr)
    require('telescope.builtin').resume()
  end,

  -- https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1407046929
  xy_open_multi_files = function(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi = picker:get_multi_selection()

    actions.select_default(prompt_bufnr) -- the normal enter behaviour

    for _, j in pairs(multi) do
      if j.path ~= nil then -- is it a file -> open it as well:
        xy.tool.open_file(j.path)
      end
    end
  end,
}

return M
