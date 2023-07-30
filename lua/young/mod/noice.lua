require('noice').setup {
  presets = {
    -- bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = true, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
  -- cmdline = {
  --   view = 'cmdline_popup', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
  --   opts = {}, -- global options for the cmdline. See section on views
  --   format = {
  --     cmdline = { pattern = '^:', icon = '', lang = 'vim' },
  --     search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
  --     search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
  --     -- Use a Classic Bottom Cmdline for Search
  --     -- search_down = { view = 'cmdline' },
  --     -- search_up = { view = 'cmdline' },
  --     filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
  --     lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
  --     help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
  --   },
  -- },
  -- messages = {
  --   enabled = true, -- enables the Noice messages UI
  --   view = 'notify', -- default view for messages
  --   view_error = 'notify', -- view for errors
  --   view_warn = 'notify', -- view for warnings
  --   view_history = 'messages', -- view for :messages
  --   view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
  -- },
  -- popupmenu = {
  --   enabled = true, -- enables the Noice popupmenu UI
  --   ---@type 'nui'|'cmp'
  --   backend = 'nui', -- backend to use to show regular cmdline completions
  --   -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
  --   kind_icons = {}, -- set to `false` to disable icons
  -- },
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    -- override = {
    --   ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
    --   ['vim.lsp.util.stylize_markdown'] = true,
    --   ['cmp.entry.get_documentation'] = true,
    -- },
    progress = { enabled = false },
    hover = { enabled = false },
    signature = { enabled = false },
  },
  -- TODO:
  views = {
    -- split = {
    --   enter = true,
    -- },
    -- Clean cmdline_popup
    -- cmdline_popup = {
    --   border = { style = 'none', padding = { 2, 3 } },
    --   filter_options = {},
    --   win_options = { winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder' },
    -- },
  },
  routes = {
    -- Route some undo messages to the mini view
    {
      filter = {
        event = 'msg_show',
        any = {
          { find = '%d+L, %d+B' },
          { find = '; after #%d+' },
          { find = '; before #%d+' },
        },
      },
      view = 'mini',
    },
    -- Route messages to the split view
    {
      filter = { event = 'msg_show', min_height = 20 },
      view = 'split',
    },
    -- Route notifications to the split view
    {
      filter = { event = 'notify', min_height = 15 },
      view = 'split',
    },
    -- Show @recording and vim's `showmode` messages
    {
      filter = { event = 'msg_showmode' },
      view = 'notify',
    },
    -- Hide search_count messages instead of showing them as virtual text
    -- {
    --   filter = { event = 'msg_show', kind = 'search_count' },
    --   opts = { skip = true },
    -- },
    -- Hide written messages
    -- {
    --   filter = { event = 'msg_show', kind = '', find = 'written' },
    --   opts = { skip = true },
    -- },
  },
  status = {}, --- @see section on statusline components
  format = {}, --- @see section on formatting
}
