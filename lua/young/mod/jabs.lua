require('jabs').setup {
  position = 'center', -- center, corner
  width = 50,
  height = 10,
  border = 'rounded', -- none, single, double, rounded, solid, shadow, (or an array or chars)

  -- Options for preview window
  preview_position = 'center', -- top, bottom, left, right
  preview = {
    width = 40,
    height = 30,
    border = 'rounded', -- none, single, double, rounded, solid, shadow, (or an array or chars)
  },

  -- the options below are ignored when position = 'center'
  -- col = ui.width,  -- Window appears on the right
  -- row = ui.height/2, -- Window appears in the vertical middle
}
