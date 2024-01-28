require('three').setup {
  bufferline = {
    enabled = true,
    icon = {
      -- Tab left/right dividers
      -- Set to this value for fancier, more "tab-looking" tabs
      dividers = { ' ', ' ' },
      -- dividers = { '▍', '' },
      -- Scroll indicator icons when buffers exceed screen width
      scroll = { '«', '»' },
      -- Pinned buffer icon
      pin = '󰐃',
    },
    -- When true, only show buffers that are inside the current directory
    -- This can be toggled on a per-tab basis with toggle_scope_by_dir()
    scope_by_directory = true,
  },
  windows = {
    enabled = true,
    -- Constant or function to calculate the minimum window width of the focused window
    winwidth = function(winid)
      local bufnr = vim.api.nvim_win_get_buf(winid)
      return math.max(vim.bo[bufnr].textwidth, 80)
    end,
    -- Constant or function to calculate the minimum window height of the focused window
    winheight = 10,
  },
  projects = {
    enabled = true,
    -- Name of file to store the project directory cache
    filename = 'projects.json',
    -- When true, automatically add directories entered as projects
    -- If false, you will need to manually call add_project()
    autoadd = true,
    -- List of lua patterns. If any match the directory, it will be allowed as a project
    allowlist = {},
    -- List of lua patterns. If any match the directory, it will be ignored as a project
    blocklist = {},
    -- Return true to allow a directory as a project
    filter_dir = function(dir)
      return true
    end,
  },
}

local three = require 'three'
-- Keymaps for bufferline
vim.keymap.set('n', 'L', three.next, { desc = 'Next buffer' })
vim.keymap.set('n', 'H', three.prev, { desc = 'Previous buffer' })
vim.keymap.set('n', 'gt', three.wrap(three.next_tab, { wrap = true }), { desc = 'Next tab' })
vim.keymap.set('n', 'gT', three.wrap(three.prev_tab, { wrap = true }), { desc = 'Prev tab' })

for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, three.wrap(three.jump_to, i), { desc = 'Jump to buffer ' .. i })
end
-- vim.keymap.set('n', '<leader>0', three.wrap(three.jump_to, 10), { desc = 'Jump to buffer 10' })
vim.keymap.set('n', '<leader>0', three.wrap(three.next, { delta = 100 }), { desc = 'Jump to last buffer' })
vim.keymap.set('n', '<leader>bq', three.smart_close, { desc = 'Close window or buffer' })
vim.keymap.set('n', '<leader>bc', three.close_buffer, { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>bh', three.hide_buffer, { desc = 'Hide buffer' })
vim.keymap.set('n', '<leader>bp', three.toggle_pin, { desc = 'Pin buffer' })
vim.keymap.set('n', '<leader>bt', three.clone_tab, { desc = 'Clone tab' })
vim.keymap.set('n', '<leader>bm', function()
  vim.ui.input({ prompt = 'Move buffer to:' }, function(idx)
    idx = idx and tonumber(idx)
    if idx then
      three.move_buffer(idx)
    end
  end)
end, { desc = 'Move buffer' })

-- Keymaps for projects
vim.keymap.set('n', '<leader>pf', three.open_project, { desc = 'Find project' })
vim.keymap.set('n', '<leader>pd', three.remove_project, { desc = 'Delete project' })
-- vim.api.nvim_create_user_command('ProjectDelete', function()
--   three.remove_project()
-- end, {})
