return {
  keys = {
    {
      '<leader>s`',
      function()
        vim.cmd 'Telescope telescope-tabs list_tabs'
      end,
      desc = 'Tabs',
    },
    {
      'g<BS>',
      function()
        vim.cmd 'lua require("telescope-tabs").go_to_previous()'
      end,
      desc = 'Tab prev',
    },
  },
  config = function()
    require('telescope-tabs').setup {
      close_tab_shortcut_i = '<C-d>', -- if you're in insert mode
      close_tab_shortcut_n = 'D', -- if you're in normal mode
    }
  end,
}
