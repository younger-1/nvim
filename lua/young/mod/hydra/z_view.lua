local Hydra = require 'hydra'

Hydra {
  name = 'Side scroll',
  mode = 'n',
  config = {
    -- invoke_on_body = true,
    hint = { type = 'statusline' },
  },
  body = 'z',
  heads = {
    { 'h', '5zh' },
    { 'l', '5zl', { desc = '←/→' } },
    { 'H', 'zH' },
    -- { 'L', 'zL', { desc = '﮿/﯀' } },
    { 'L', 'zL', { desc = '/' } },
    { 'j', '3<C-e>', { private = true } },
    { 'k', '3<C-y>', { private = true, desc = '↓/↑' } },
    { 'J', 'zt', { private = true } },
    { 'K', 'zb', { private = true, desc = '↓/↑' } },
  },
}
