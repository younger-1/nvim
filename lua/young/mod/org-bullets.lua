require('org-bullets').setup {
  -- concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
  symbols = {
    -- list = '•',
    -- headlines = { '◉', '○', '✸', '✿' },
    -- Or a function that receives the defaults and returns a list
    -- headlines = function(default_list)
    --   table.insert(default_list, '♥')
    --   return default_list
    -- end,
    -- checkboxes = {
    --   half = { '', 'OrgTSCheckboxHalfChecked' },
    --   done = { '✓', 'OrgDone' },
    --   todo = { '˟', 'OrgTODO' },
    -- },
  },
}

-- A simpler conceal based alternative is:
-- vim.cmd [[
-- syntax match OrgHeadlineStar1 /^\*\ze\s/me=e-1 conceal cchar=◉ containedin=OrgHeadlineLevel1 contained
-- syntax match OrgHeadlineStar2 /^\*\{2}\ze\s/me=e-1 conceal cchar=○ containedin=OrgHeadlineLevel2 contained
-- syntax match OrgHeadlineStar3 /^\*\{3}\ze\s/me=e-1 conceal cchar=✸ containedin=OrgHeadlineLevel3 contained
-- syntax match OrgHeadlineStar4 /^\*{4}\ze\s/me=e-1 conceal cchar=✿ containedin=OrgHeadlineLevel4 contained
-- ]]
