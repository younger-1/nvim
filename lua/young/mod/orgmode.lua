return {
  done = function()
    require('orgmode').setup {}

    -- Load custom treesitter grammar for org filetype
    require('orgmode').setup_ts_grammar()
  end,
}
