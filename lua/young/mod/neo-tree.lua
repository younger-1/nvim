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
      ['<tab>'] = 'toggle_node',
      ['<cr>'] = 'open_with_window_picker',
      ['o'] = 'toggle_node',
      ['P'] = { 'toggle_preview', config = { use_float = true } },
      ['<C-s>'] = 'split_with_window_picker',
      ['<C-v>'] = 'vsplit_with_window_picker',
    },
  },
}

function M.done()
  -- Unless you are still migrating, remove the deprecated commands from v1.x
  vim.g.neo_tree_remove_legacy_commands = 1

  require('neo-tree').setup(cfg)
end

return M
