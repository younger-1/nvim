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

-- TODO: exclude command-line window
local exclude_buftypes = { 'quickfix', 'nofile' }
xy.map.n {
  '<C-f>',
  function()
    if vim.tbl_contains(exclude_buftypes, vim.bo.buftype) then
      -- vim.cmd [[normal! \<C-f>]] -- not ok
      -- vim.cmd [[exe 'normal! \<C-f>']] -- not ok
      vim.cmd [[exe "normal! \<C-f>"]] -- ok
      -- vim.cmd [[call feedkeys('\<C-f>', 'n')]] -- not ok
      -- vim.cmd [[call feedkeys("\<C-f>", 'n')]] -- ok
      -- vim.fn.feedkeys(xy.util.t '<C-f>', 'n') -- ok
      -- vim.cmd('normal! ' .. xy.util.t '<C-f>') -- ok
      return
    end
    -- vim.cmd 'SearchBoxMatchAll title="Match All"'
    require('searchbox').incsearch()
  end,
  'Searchbox',
}

xy.map.x {
  '<C-f>',
  function()
    if vim.tbl_contains(exclude_buftypes, vim.bo.buftype) then
      vim.cmd [[exe "normal! \<C-f>"]]
      return
    end
    -- vim.cmd 'SearchBoxMatchAll title="Match All" visual_mode=true'
    require('searchbox').incsearch { visual_mode = true }
  end,
  'Searchbox (visual)',
}

-- xy.map.n { '<C-b>', ':SearchBoxMatchAll exact=true title=" Search 🦝 "<CR>' }
