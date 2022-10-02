Highlight apply step

- (optional) my config for highlight
- pre-config for <theme> (e.g. dracula)
- colorscheme <theme>
- plugin
  - after event triggered
  - source `plugin/*.{vim,lua}` (e.g. vim-illuminate)
  - (optional) my config for <plugin>
  - setup <plugin> (e.g. gitsigns)
  - (optional) my config for <plugin>

```lua
local hl = function(name, val)
  api.nvim_set_hl(0, name, val)
end

hl('LspReferenceText', { undercurl = true, bg = '#27406b' })
hl('LspReferenceRead', { undercurl = true, bg = '#3d5213' })
hl('LspReferenceWrite', { undercurl = true, bg = '#4a0f23' })
```

```lua
xy.hl = function(hls, force)
  for name, candidates in pairs(hls) do
    if not xy.util.is_gui_hl_set(name) or force then
      vim.api.nvim_set_hl(0, name, candidates)
    end
  end
end

xy.hl({
  LspReferenceText = { undercurl = true, bg = '#27406b' },
  LspReferenceRead = { undercurl = true, bg = '#3d5213' },
  LspReferenceWrite = { undercurl = true, bg = '#4a0f23' },
}, true)
```

```lua
-- only link when <name> do not have highlight
-- xy.hi_link = function(hls, force)
--   for name, candidates in pairs(hls) do
--     if force or not xy.util.is_gui_hl_set(name) then
--       if type(candidates) == 'string' then
--         if xy.util.is_gui_hl_set(candidates) then
--           vim.api.nvim_set_hl(0, name, {})
--           vim.api.nvim_set_hl(0, name, { link = candidates, default = true })
--         end
--       else
--         for _, d in ipairs(candidates) do
--           if xy.util.is_gui_hl_set(d) then
--             vim.api.nvim_set_hl(0, name, {})
--             vim.api.nvim_set_hl(0, name, { link = d, default = true })
--             break
--           end
--         end
--       end
--     end
--   end
-- end

--  ┌─────────────────┐
--  │ is_hl_link      │
--  │       ┌─────────┼───────┐
--  │    1  │    2    │   3   │
--  │       │         │       │
--  └───────┼─────────┘       │
--       4  │   is_gui_hl_set │
--          └─────────────────┘
-- link hl when: 1(need clear link), 3, 4
xy.hl_link = function(hls, force)
  for name, candidates in pairs(hls) do
    if not xy.util.is_gui_hl_set(name) or force then
      vim.cmd(('hi! def link %s %s'):format(name, candidates))
      -- vim.api.nvim_set_hl(0, name, {})
      -- vim.api.nvim_set_hl(0, name, { link = candidates, default = true })
    else
      if not xy.util.is_hl_link(name) then
        -- @see <https://github.com/neovim/neovim/issues/20323> nvim_set_hl is missing the ! behavior of hi! def link
        vim.cmd(('hi def link %s %s'):format(name, candidates))
        -- vim.api.nvim_set_hl(0, name, { link = candidates, default = true })
      end
    end
  end
end

xy.hl_link {
  IlluminatedWordText = 'LspReferenceText',
  IlluminatedWordRead = 'LspReferenceRead',
  IlluminatedWordWrite = 'LspReferenceWrite',
}
```

