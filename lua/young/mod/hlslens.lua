local M = {}

-- local function lens(render, posList, nearest, idx, relIdx)
--   local sfw = vim.v.searchforward == 1
--   local indicator, text, chunks
--   local absRelIdx = math.abs(relIdx)
--   if absRelIdx > 1 then
--     indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
--   elseif absRelIdx == 1 then
--     indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
--   else
--     indicator = ''
--   end

--   local lnum, col = unpack(posList[idx])
--   if nearest then
--     local cnt = #posList
--     if indicator ~= '' then
--       text = ('[%s %d/%d]'):format(indicator, idx, cnt)
--     else
--       text = ('[%d/%d]'):format(idx, cnt)
--     end
--     chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
--   else
--     text = ('[%s %d]'):format(indicator, idx)
--     chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
--   end
--   render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
-- end

M.once = function()
  local kopts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap(
    'n',
    'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts
  )
  vim.api.nvim_set_keymap(
    'n',
    'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts
  )
  -- vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
  -- vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
end

M.done = function()
  require('hlslens').setup {
    -- override_lens = lens,
  }
end

return M

-- TODO:
-- xy.autogroup('hlslens', {
--   { 'CursorMoved', '*', require('hlslens').start },
-- })

-- <https://github.com/b0o/nvim-conf/blob/main/lua/user/plugin/hlslens.lua>
-- local M = { vmlens = {} }
-- local hlslens = require 'hlslens'
-- local hlslens_config
-- local lens_backup

-- function M.vmlens.start()
--   if hlslens then
--     hlslens_config = require 'hlslens.config'
--     lens_backup = hlslens_config.override_lens

--     hlslens_config.override_lens = function(render, plist, nearest, idx, r_idx)
--       local _ = r_idx
--       local lnum, col = unpack(plist[idx])
--       local text, chunks
--       if nearest then
--         text = ('[%d/%d]'):format(idx, #plist)
--         chunks = { { ' ', 'Ignore' }, { text, 'VM_Extend' } }
--       else
--         text = ('[%d]'):format(idx)
--         chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
--       end
--       render.set_virt(0, lnum - 1, col - 1, chunks, nearest)
--     end

--     hlslens.start(true)
--   end
-- end

-- function M.vmlens.exit()
--   if hlslens then
--     hlslens_config.override_lens = lens_backup
--     hlslens.start(true)
--   end
-- end

-- vim.cmd [[
--   function VM_Start()
--     lua require'young.mod.hlslens'.vmlens.start()
--   endfunction
--   function VM_Exit()
--     lua require'young.mod.hlslens'.vmlens.exit()
--   endfunction
-- ]]

-- return M
