require('neoclip').setup {
  filter = nil,
  preview = true,
  default_register = '"',
  content_spec_column = false,
  on_paste = {
    set_reg = false,
  },
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<c-l>',
        paste_behind = '<c-h>',
        custom = {},
      },
      n = {
        select = '<cr>',
        paste = 'p',
        paste_behind = 'P',
        custom = {},
      },
    },
    fzf = {
      select = 'default',
      paste = 'ctrl-l',
      paste_behind = 'ctrl-h',
      custom = {},
    },
  },
}
