local filters = require('mutchar.filters')

require('mutchar').setup {
  -- c = { '-', '->', '-' },

  -- cpp = {
  --   { ';', '::', ';' },
  --   { '88', '::', '88' },
  --   { '-', '->', '-', '-----', '-------' },
  -- },

  -- rust = { ';', '::', ';' },

  -- go = {
  --   { ';', ':=', ';' },
  -- },

  ['c'] = {
    rules = { '-', '->' },
    filter = filters.non_space_before,
  },
  ['rust'] = {
    rules = {
      { ';', ': ' },
      { '-', '->' },
      { ',', '<!>' },
    },
    filter = {
      filters.semicolon_in_rust,
      filters.minus_in_rust,
      filters.generic_in_rust,
    },
    one_to_one = true,
  },
}
