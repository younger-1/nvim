-- <https://www.reddit.com/r/neovim/comments/u0iiwp/i_made_a_cursed_dsl_for_keymapping_using_whichkey/>
-- - <https://gist.github.com/cultab/3c364ce879c050cf56040c40d22ceafb>
-- - <https://github.com/cultab/dotfiles/blob/master/neovim/.config/nvim/lua/user/map.lua>

_G.map = setmetatable({ mappings = {}, parsed = {}, key = {} }, {
  __call = function(self, key)
    self.key = key
    pp(key)
    return self.parse
  end,
})

map 'what' 'will' 'you' { look = 1 }()()

local M = {}

local function P(a)
  print(vim.inspect(a))
end

local wk = require 'which-key'

-- Map a key to a lua function or vimscript snippet also add a description.
--
-- map keycode:string { lua function | vimscript:string , description:string }
--
-- Example:
-- ```lua
-- map 'gD' { vim.lsp.buf.declaration, "Goto declaration [LSP]" }
-- ```
--
-- An optional third argument determines the mode the key is bound in.
--
-- Example, let's map <leader>= to vim.lsp.buf.range_formatting in visual mode:
-- ```lua
-- map '<leader>=' { vim.lsp.buf.range_formatting, "Format range", 'v' }
-- ```
-- TODO: other modes? "s", "o", "x", "l", "c", "t"
local function prototype()
  return {
    mappings = {
      n = {},
      v = {},
      i = {},
    },
  }
end

_G.map = setmetatable(prototype(), {
  -- enable syntax like:  map "<leader>a"  { vim.lsp.buf.rename , "some desc" }
  -- if mode is missing, assume normal mode
  -- if mapping is missing, name the group
  __call = function(self, key)
    -- @param mapping_args list
    local closure = function(mapping_args)
      -- default to normal mode
      local modes = 'n'
      -- if another set of modes is given, overwrite "n"
      if mapping_args[3] then
        modes = mapping_args[3]
      end

      -- set the mapping for each mode
      for i = 1, #modes do
        self.mappings[modes:sub(i, i)][key] = mapping_args
      end
    end
    return closure
  end,
  __index = {
    register = function(self)
      -- P(self)
      for mode, mappings in pairs(self.mappings) do
        for key, mapping_args in pairs(mappings) do
          -- @type string|function|nil
          local mapping = mapping_args[1]
          -- @type string
          local description = mapping_args[2]

          if mapping ~= nil then
            wk.register({ [key] = { mapping, description } }, { mode = mode })
          else
            wk.register({ [key] = { name = description } }, { mode = mode })
          end
        end
      end
      -- empty out registered mappings
      self.mappings = prototype().mappings
    end,
  },
})

-- if type(mapping) == "function" then
--     vim.api.nvim_set_keymap(mode:sub(i, i), key, '', { callback = mapping, desc = description })
-- else
--     vim.api.nvim_set_keymap(mode:sub(i, i), key, mapping, { desc = description })
-- end

return M
