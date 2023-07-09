xy.map.n { 'g<CR>', '<Cmd>Navbuddy<CR>' }
-- xy.map.n { 'gs', '<Cmd>Navbuddy<CR>' }

local navbuddy = require 'nvim-navbuddy'
local actions = require 'nvim-navbuddy.actions'

navbuddy.setup {
  window = {
    border = 'rounded', -- "rounded", "double", "solid", "none"
    -- or an array with eight chars building up the border in a clockwise fashion
    -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
    size = '60%', -- Or table format example: { height = "40%", width = "100%"}
    position = '50%', -- Or table format example: { row = "100%", col = "0%"}
    scrolloff = nil, -- scrolloff value within navbuddy window
    sections = {
      left = {
        size = '20%',
        border = nil, -- You can set border style for each section individually as well.
      },
      mid = {
        size = '40%',
        border = nil,
      },
      right = {
        -- No size option for right most section. It fills to
        -- remaining area.
        border = nil,
        preview = 'leaf', -- Right section can show previews too.
        -- Options: "leaf", "always" or "never"
      },
    },
  },
  node_markers = {
    enabled = true,
    icons = {
      leaf = '  ',
      leaf_selected = ' → ',
      branch = ' ',
    },
  },
  -- icons = {
  --   File = '󰈙 ',
  --   Module = ' ',
  --   Namespace = '󰌗 ',
  --   Package = ' ',
  --   Class = '󰌗 ',
  --   Method = '󰆧 ',
  --   Property = ' ',
  --   Field = ' ',
  --   Constructor = ' ',
  --   Enum = '󰕘',
  --   Interface = '󰕘',
  --   Function = '󰊕 ',
  --   Variable = '󰆧 ',
  --   Constant = '󰏿 ',
  --   String = ' ',
  --   Number = '󰎠 ',
  --   Boolean = '◩ ',
  --   Array = '󰅪 ',
  --   Object = '󰅩 ',
  --   Key = '󰌋 ',
  --   Null = '󰟢 ',
  --   EnumMember = ' ',
  --   Struct = '󰌗 ',
  --   Event = ' ',
  --   Operator = '󰆕 ',
  --   TypeParameter = '󰊄 ',
  -- },
  lsp = {
    auto_attach = true, -- If set to true, you don't need to manually use attach function
    preference = nil, -- list of lsp server names in order of preference
  },
  source_buffer = {
    follow_node = true, -- Keep the current node in focus on the source buffer
    highlight = true, -- Highlight the currently focused node
    reorient = 'smart', -- "smart", "top", "mid" or "none"
    scrolloff = nil, -- scrolloff value when navbuddy is open
  },
}
