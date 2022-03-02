local nmap = require('young.key').nmap
local xmap = require('young.key').xmap

-- TODO: map add excluded filetypes/buftypes like quickfix
nmap('<C-f>', ':SearchBoxMatchAll<CR>')
xmap('<C-f>', ':SearchBoxMatchAll visual_mode=true<CR>')
-- nmap('<C-b>', ':SearchBoxMatchAll exact=true title=" Search 🦝 "<CR>')

require('searchbox').setup {
  -- popup = {
  --   relative = 'win',
  --   position = {
  --     row = '5%',
  --     col = '95%',
  --   },
  --   size = 30,
  --   border = {
  --     style = 'rounded',
  --     highlight = 'FloatBorder',
  --     text = {
  --       top = ' Search ',
  --       top_align = 'left',
  --     },
  --   },
  --   win_options = {
  --     winhighlight = 'Normal:Normal',
  --   },
  -- },
  hooks = {
    before_mount = function(input)
      -- code
    end,
    -- <https://github.com/VonHeikemen/searchbox.nvim/issues/24>
    after_mount = function(input)
      local map = function(lhs, rhs)
        vim.api.nvim_buf_set_keymap(input.bufnr, 'i', lhs, rhs, { noremap = false })
      end

      local mode = '<Esc><cmd>sleep 3m<CR><cmd>SearchBox%s<CR>'

      map('<C-a>', mode:format 'MatchAll')
      map('<C-r>', mode:format 'IncSearch reverse=true')
      map('<C-x>', mode:format 'IncSearch exact=true')
      -- map('<CR>' , mode:format('MatchAll -- <C-r>=expand("<cword>")<CR>'))
    end,
    on_done = function(value, search_type)
      if value == nil then
        return
      end
      vim.fn.setreg('s', value)
    end,
  },
}
