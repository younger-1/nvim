return function()
  require('nvim-autopairs').setup { check_ts = true }

  require('nvim-autopairs.completion.cmp').setup {
    map_cr = true,
    map_complete = true,
  }
end
