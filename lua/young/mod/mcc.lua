require('mcc').setup {
  c = { '-', '->', '-' },

  cpp = {
    { ';', '::', ';' },
    { '88', '::', '88' },
    { '-', '->', '-', '-----', '-------' },
  },

  rust = { ';', '::', ';' },

  go = {
    { ';', ':=', ';' },
  },
}