local npairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'
-- local cond = require 'nvim-autopairs.conds'
-- pp(cond)

-- If you want insert `(` after select function, but not for `tex`
-- local ok_cmp, cmp = pcall(require, 'cmp')
-- if ok_cmp then
--   local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
--   -- local map_char = { tex = '' }
--   local map_char = {
--     all = '(',
--     tex = '{',
--   }
--   cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = map_char })
-- end

-- [Default]
-- local disable_filetype = { "TelescopePrompt" }
-- local disable_in_macro = false  -- disable when recording or executing a macro
-- local disable_in_visualblock = false -- disable when insert after visual block mode
-- local ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", "")
-- local ignored_next_char = [=[[%w%%%'%[%"%.]]=]
-- local enable_moveright = true
-- local enable_afterquote = true  -- add bracket pairs after quote
-- local enable_check_bracket_line = true  --- check bracket in same line
-- local enable_bracket_in_quote = true
-- local enable_abbr = false -- trigger abbreviation
-- local break_undo = true -- switch for basic rule break undo sequence
-- local check_ts = false -- use treesitter to check for a pair
-- local map_cr = true -- map the <CR> key
-- local map_bs = true  -- map the <BS> key
-- local map_c_h = false -- map the <C-h> key to delete a pair
-- local map_c_w = false -- map <c-w> to delete an pair if possible
npairs.setup {
  disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
  map_c_h = true,
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = 'e',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey = 'Comment',
  },
}

-- npairs.add_rules {
--   Rule('(', ')'):use_key('<c-h>'):replace_endpair(function()
--     return '<bs><del>'
--   end, true),
-- }

-- Add spaces between parentheses
npairs.add_rules {
  Rule(' ', ' '):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({ '()', '{}' }, pair)
  end),
  -- Rule('( ', ' )')
  --   :with_pair(function()
  --     return false
  --   end)
  --   :with_move(function(opts)
  --     return opts.prev_char:match '.%)' ~= nil
  --   end)
  --   :use_key ')',
  -- Rule('{ ', ' }')
  --   :with_pair(function()
  --     return false
  --   end)
  --   :with_move(function(opts)
  --     return opts.prev_char:match '.%}' ~= nil
  --   end)
  --   :use_key '}',
  -- Rule('[ ', ' ]')
  --   :with_pair(function()
  --     return false
  --   end)
  --   :with_move(function(opts)
  --     return opts.prev_char:match '.%]' ~= nil
  --   end)
  --   :use_key ']',
}

npairs.add_rule(Rule('<', '>', { 'markdown', 'txt' }))

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
