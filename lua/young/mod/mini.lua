return {
  once = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
  done = function()
    require('mini.indentscope').setup {
      symbol = xy.icon.bar,
      options = { try_as_border = true },
    }

    -- require('mini.animate').setup()
  end,
}
