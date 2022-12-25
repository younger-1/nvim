local M = {}

function M.once()
  vim.keymap.set('n', 'gpd', '<CMD>Glance definitions<CR>')
  vim.keymap.set('n', 'gpr', '<CMD>Glance references<CR>')
  vim.keymap.set('n', 'gpy', '<CMD>Glance type_definitions<CR>')
  vim.keymap.set('n', 'gpi', '<CMD>Glance implementations<CR>')
end

function M.done()
  -- Lua configuration
  local glance = require 'glance'
  local actions = glance.actions

  glance.setup {
    height = 18, -- Height of the window
    zindex = 45,
    preview_win_opts = { -- Configure preview window options
      cursorline = true,
      number = true,
      wrap = true,
    },
    border = {
      enable = false, -- Show window borders. Only horizontal borders allowed
      top_char = '―',
      bottom_char = '―',
    },
    list = {
      position = 'right', -- Position of the list window 'left'|'right'
      width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
    },
    theme = { -- This feature might not work properly in nvim-0.7.2
      enable = true, -- Will generate colors for the plugin based on your current colorscheme
      mode = 'auto', -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
    },
    mappings = {
      list = {
        ['j'] = actions.next, -- Bring the cursor to the next item in the list
        ['k'] = actions.previous, -- Bring the cursor to the previous item in the list
        ['<Down>'] = actions.next,
        ['<Up>'] = actions.previous,
        ['<Tab>'] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
        ['<S-Tab>'] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
        ['<C-u>'] = actions.preview_scroll_win(5),
        ['<C-d>'] = actions.preview_scroll_win(-5),
        ['v'] = actions.jump_vsplit,
        ['s'] = actions.jump_split,
        ['t'] = actions.jump_tab,
        ['<CR>'] = actions.jump,
        ['o'] = actions.jump,
        ['q'] = actions.close,
        ['<Esc>'] = false, -- disable a mapping
        ['<leader>l'] = false,
        ['<C-p>'] = actions.enter_win 'preview', -- Focus preview window
        ['<C-h>'] = actions.enter_win 'preview', -- Focus preview window
      },
      preview = {
        ['q'] = actions.close,
        ['<Tab>'] = actions.next_location,
        ['<S-Tab>'] = actions.previous_location,
        ['<leader>l'] = false, -- Focus list window
        ['<C-p>'] = actions.enter_win 'list', -- Focus list window
        ['<C-l>'] = actions.enter_win 'list', -- Focus list window
      },
    },
    hooks = {
      ---Runs after getting the results and before opening the window
      -- before_open = function(results, open, jump, method)
      --   if #results == 1 then
      --     jump(results[1]) -- argument is optional
      --   else
      --     open(results) -- argument is optional
      --   end
      -- end,
      ---Triggered right before the window is closed
      before_close = nil,
      ---Triggered after the window is closed
      after_close = nil,
    },
    folds = {
      fold_closed = '',
      fold_open = '',
      folded = true, -- Automatically fold list on startup
    },
    indent_lines = {
      enable = true,
      icon = '│',
    },
    winbar = {
      enable = true, -- Available strating from nvim-0.8+
    },
  }
end

return M
