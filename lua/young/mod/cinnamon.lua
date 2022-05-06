require('cinnamon').setup {
  -- KEYMAPS:
  default_keymaps = true,   -- Create default keymaps.
  extra_keymaps = false,    -- Create extra keymaps.
  extended_keymaps = false, -- Create extended keymaps.

  -- OPTIONS:
  always_scroll = false,    -- Scroll the cursor even when the window hasn't scrolled.
  centered = true,          -- Keep cursor centered in window when using window scrolling.
  default_delay = 5,        -- The default delay (in ms) between each line when scrolling.
  horizontal_scroll = true, -- Enable smooth horizontal scrolling when view shifts left or right.
  scroll_limit = 150,       -- Max number of lines moved before scrolling is skipped.
}
