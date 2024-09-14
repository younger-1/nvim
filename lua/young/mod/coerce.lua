require('coerce').setup {
  keymap_registry = require('coerce.keymap').keymap_registry(),
  -- keymap_registry = require('coerce.keymap').plain_keymap_registry,
  -- The notification function used during error conditions.
  notify = function(...)
    return vim.notify(...)
  end,
  default_mode_keymap_prefixes = {
    normal_mode = 'cr',
    motion_mode = 'gcr',
    visual_mode = 'gcr',
  },
}
