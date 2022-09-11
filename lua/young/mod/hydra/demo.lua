local Hydra = require 'hydra'

local inverse_gg = Hydra {
  config = {
    color = 'amaranth',
    -- color = 'teal',
    -- color = 'pink',
    invoke_on_body = true,
  },
  mode = 'n',
  body = 'gz',
  heads = {
    { 'gg', 'G' },
    { 'G', 'gg' },
  },
}

