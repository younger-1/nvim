local M = {}

function M.once()
  local cmd = require('young.key').cmd
  xy.map.n { '<leader>e', cmd 'Neotree toggle reveal', 'Explorer' }

  vim.cmd [[
  nnoremap <silent> <C-p> <cmd>Neotree toggle reveal top<cr>
  nnoremap <silent> <C-e> <cmd>Neotree toggle reveal left<cr>
  nnoremap <silent> <C-n> <cmd>Neotree toggle reveal right<cr>
  nnoremap <silent> <C-b> <cmd>Neotree toggle reveal float buffers<cr>
  nnoremap <silent> <C-f> <cmd>Neotree toggle reveal float git_status<cr>
  ]]
end

local function getTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function(prompt_bufnr, map)
      local actions = require 'telescope.actions'
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require 'telescope.actions.state'
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if filename == nil then
          filename = selection[1]
        end
        -- any way to open the file without triggering auto-close event of neo-tree?
        require('neo-tree.sources.filesystem').navigate(state, state.path, filename)
      end)
      return true
    end,
  }
end

local run_command = function(state)
  local node = state.tree:get_node()
  local path = node:get_id()
  vim.api.nvim_input(': ' .. path .. '<Home>')
end

local system_open = function(state)
  local node = state.tree:get_node()
  local path = node:get_id()
  -- macOs: open file in default application in the background.
  -- vim.api.nvim_command('silent !open -g ' .. path)
  -- Linux: open file in default application
  -- vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
  fn.jobstart({ xy.open_cmd, path }, { detach = true })
end

local cfg = {
  sources = {
    'filesystem',
    'buffers',
    'git_status',
    -- 'diagnostics',
  },
  source_selector = {
    winbar = true,
  },
  popup_border_style = 'rounded',
  filesystem = {
    hijack_netrw_behavior = 'open_current',
    follow_current_file = false,
    use_libuv_file_watcher = true,
    group_empty_dirs = true,
    window = {
      mappings = {
        -- ['<tab>'] = 'toggle_node',
        -- ['<cr>'] = 'open',
        -- ['P'] = { 'toggle_preview', config = { use_float = true } },
        ['s'] = 'fuzzy_finder',
        ['<leader>sf'] = 'telescope_find',
        ['<leader>sg'] = 'telescope_grep',
      },
    },
    commands = {
      telescope_find = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require('telescope.builtin').find_files(getTelescopeOpts(state, path))
      end,
      telescope_grep = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require('telescope.builtin').live_grep(getTelescopeOpts(state, path))
      end,
    },
  },
  default_component_configs = {
    icon = {
      folder_empty = '',
    },
    git_status = {
      symbols = {
        untracked = '',
        ignored = '',
        unstaged = '',
        staged = '',
        conflict = '',
      },
    },
  },
  window = {
    position = 'right',
    width = 35,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ['<space>'] = 'nop',
      ['/'] = 'nop',
      ['w'] = 'nop',
      ['o'] = 'open_with_window_picker',
      ['<C-s>'] = 'split_with_window_picker',
      ['<C-v>'] = 'vsplit_with_window_picker',
      ['i'] = run_command,
      ['O'] = system_open,
    },
  },
}

function M.done()
  -- Unless you are still migrating, remove the deprecated commands from v1.x
  vim.g.neo_tree_remove_legacy_commands = 1

  require('neo-tree').setup(cfg)
end

return M
