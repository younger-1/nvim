require('telescope').load_extension 'macros'
require('NeoComposer').setup {
  -- notify = true,
  -- delay_timer = 150,
  -- colors = {
  --   bg = '#16161e',
  --   fg = '#ff9e64',
  --   red = '#ec5f67',
  --   blue = '#5fb3b3',
  --   green = '#99c794',
  -- },
  keymaps = {
    play_macro = 'Q',
    yank_macro = 'yq',
    stop_macro = 'cq',
    toggle_record = 'qw',
    cycle_next = 'q<c-n>',
    cycle_prev = 'q<c-p>',
    toggle_macro_menu = '<m-q>',
  },
}
