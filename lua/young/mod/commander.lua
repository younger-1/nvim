local commander = require 'commander'

commander.setup {
  -- Change the separator used to separate each component
  separator = '│',

  -- When set to true,
  -- The desc component will be populated with cmd if desc is empty or missing.
  auto_replace_desc_with_cmd = false,

  -- Default title of the prompt
  prompt_title = ' Commander',

  integration = {
    telescope = {
      -- Set to true to use telescope instead of vim.ui.select for the UI
      enable = true,
      -- Can be any builtin or custom telescope theme
      theme = require('telescope.themes').commander,
    },
    lazy = {
      -- Set to true to automatically add all key bindings set through lazy.nvim
      enable = true,
      -- Set to true to use plugin name as category for each keybinding added from lazy.nvim
      set_plugin_name_as_cat = true,
    },
  },
}

commander.add {
  {
    desc = 'Open commander',
    cmd = require('commander').show,
    keys = { 'n', '<Leader><Leader>' },
  },
}

-- -- The keymaps of the following commands will be key (if any)
-- -- But the commands won't be shown when you call `require("commander").show()`
-- commander.add({
--   {
--     desc = 'Find files',
--     cmd = '<CMD>Telescope find_files<CR>',
--     keys = { 'n', '<leader>mf', { noremap = true } },
--   },
--   {
--     -- If keys is not specified, then this enery is ignored
--     -- since there is no keymaps to set
--     desc = 'Search inside current buffer',
--     cmd = '<CMD>Telescope current_buffer_fuzzy_find<CR>',
--   },
-- }, {
--   show = false,
-- })
--
-- -- The following commands will be shown in the prompt,
-- -- But the keymaps will not be registered;
-- -- This is helpful if you already registered the keymap somewhere else
-- -- and want to avoid set the exact keymap twice
-- commander.add({
--   {
--     -- If keys are specified,
--     -- then they will still show up in commander but won't be set
--     desc = 'Find hidden files',
--     cmd = '<CMD>Telescope find_files hidden=true<CR>',
--     keys = { 'n', '<leader>f.f' },
--   },
--   {
--     desc = 'Show document symbols',
--     cmd = '<CMD>Telescope lsp_document_symbols<CR>',
--   },
--   {
--     -- Since `show` is set to `true` in this command,
--     -- It overwrites the opts and this keymap will still be set
--     desc = 'LSP code actions',
--     cmd = '<CMD>Telescope lsp_code_actions<CR>',
--     keys = { 'n', '<leader>sa' },
--     set = true,
--   },
-- }, {
--   set = false,
-- })
