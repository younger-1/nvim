return {
  once = function()
    local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }
    local key = '<M-t>'
    vim.keymap.set('n', key, function()
      if vim.bo.buftype == 'terminal' then
        vim.cmd 'NeoTermClose'
      else
        vim.cmd 'NeoTermOpen'
      end
    end, NOREF_NOERR_TRUNC)
    vim.keymap.set('t', key, function()
      vim.cmd 'NeoTermEnterNormal'
    end, NOREF_NOERR_TRUNC)
  end,

  done = function()
    require('neo-term').setup {
      -- split_on_top = true,
      -- split_size = 0.5,
      exclude_buftypes = { 'terminal' }, -- these two options will affect `NeoTermOpen`
      exclude_filetypes = { 'neo-tree', 'dashboard' },
    }
  end,
}
