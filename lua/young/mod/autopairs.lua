local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
-- pp(cond)

-- [Default]
-- local disable_filetype = { "TelescopePrompt" }
-- local disable_in_macro = false  -- disable when recording or executing a macro
-- local ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", "")
-- local enable_moveright = true
-- local enable_afterquote = true  -- add bracket pairs after quote
-- local enable_check_bracket_line = true  --- check bracket in same line
-- local check_ts = false -- tree-sitter
-- local map_bs = true  -- map the <BS> key
-- local map_c_w = false -- map <c-w> to delete an pair if possible
npairs.setup { 
  fast_wrap = {},
}

-- If you want insert `(` after select function, but not for `tex`
local cmp_status_ok, cmp = pcall(require, "cmp")
if cmp_status_ok then
  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  -- local map_char = { tex = '' }
  local map_char = {
      all = "(",
      tex = "{",
  },
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = map_char })
end

npairs.add_rules {
  Rule("(",")")
    :use_key("<c-h>")
    :replace_endpair(function() return "<bs><del>" end, true)
}

-- Add spaces between parentheses
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
  Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
  Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']')
}

npairs.add_rule(Rule("<",">", { "markdown", "txt" }))

-- TODO: **, __
-- npairs.add_rules {
--   Rule("*", "*", "markdown")
--     -- don't add a pair if the next character is %
--     :with_pair(cond.not_after_regex_check("%%"))
--     -- don't add a pair if the previous character is xxx
--     :with_pair(cond.not_before_regex_check("xxx", 3))
--     -- don't move right when repeat character
--     :with_move(cond.none())
--     -- don't delete if the next character is xx
--     :with_del(cond.not_after_regex_check("xx"))
--     -- disable add newline when press <cr>
--     :with_cr(cond.none()),
--   Rule("_", "_", "markdown")
--     :with_pair(function(opts)
--         print(vim.inspect(opts))
--         -- don't add pair on that line
--         if opts.line == "nvim nb" then
--           return false
--         end
--     end),
-- }

