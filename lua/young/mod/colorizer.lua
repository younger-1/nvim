-- require('colorizer').setup({ '*' }, {
--   names = true,
--   RGB = true, -- #RGB hex codes
--   RRGGBB = true, -- #RRGGBB hex codes
--   RRGGBBAA = true, -- #RRGGBBAA hex codes
--   rgb_fn = true, -- CSS rgb() and rgba() functions
--   hsl_fn = true, -- CSS hsl() and hsla() functions
--   css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
--   css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
-- })

require('colorizer').setup {
  filetypes = { '*' },
  -- filetypes = {
  --   'css',
  --   'javascript',
  --   html = { mode = 'foreground' },
  -- },
  user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = true, -- "Name" codes like Blue or blue
    RRGGBBAA = false, -- #RRGGBBAA hex codes
    AARRGGBB = false, -- 0xAARRGGBB hex codes
    rgb_fn = false, -- CSS rgb() and rgba() functions
    hsl_fn = false, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes for `mode`: foreground, background,  virtualtext
    mode = 'background', -- Set the display mode.
    virtualtext = '■',
  },
  -- all the sub-options of filetypes apply to buftypes
  buftypes = {},
}
