require('lsp_signature').setup {
  toggle_key = '<C-l>',
  transpancy = nil,
  hint_prefix = ' ',
  hint_enable = true, -- virtual hint enable
  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
  floating_window_above_cur_line = true,
  handler_opts = {
    border = 'double', -- double, single, shadow, none
  },
}
