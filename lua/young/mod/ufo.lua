-- vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.opt.fillchars:append [[fold: ,foldopen:,foldsep: ,foldclose:]]

xy.map.n { 'zR', require('ufo').openAllFolds, 'Ufo open all folds' }
xy.map.n { 'zM', require('ufo').closeAllFolds, 'Ufo close all folds' }
xy.map.n { 'zr', require('ufo').openFoldsExceptKinds, 'Ufo open folds except kinds' }
xy.map.n { 'zm', require('ufo').closeFoldsWith, 'Ufo close folds with [N]' } -- closeAllFolds == closeFoldsWith(0)

-- local preview_key = '<tab>' -- TODO:register buffer-map or on_key for <tab>
local preview_key = 'J'
xy.map.n {
  preview_key,
  function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
      vim.fn.feedkeys(xy.util.t(preview_key), 'n')
    end
  end,
  'Ufo peek current fold',
}
xy.map.n { 'zk', require('ufo').goPreviousStartFold, 'Ufo go previous start fold' }

local function peek_prev_fold()
  require('ufo').goPreviousClosedFold()
  require('ufo').peekFoldedLinesUnderCursor()
end

local function peek_next_fold()
  require('ufo').goNextClosedFold()
  require('ufo').peekFoldedLinesUnderCursor()
end

xy.map.n { 'z[', peek_prev_fold, 'Ufo peek prev fold' }
xy.map.n { 'z]', peek_next_fold, 'Ufo peek next fold' }

local handler = function(virtText, lnum, endLnum, width, truncate, ctx)
  local newVirtText = {}
  local suffix = ('  %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })

  -- For treesitter provider
  if ctx then
    -- table.insert(newVirtText, { tostring(#ctx.get_fold_virt_text(endLnum)), 'WarningMsg' })
    -- table.insert(newVirtText, ctx.get_fold_virt_text(endLnum)[1])
    -- table.insert(newVirtText, ctx.get_fold_virt_text(endLnum)[#ctx.get_fold_virt_text(endLnum)])

    -- vim.list_extend(newVirtText, ctx.get_fold_virt_text(endLnum))
    local endVirtText = ctx.get_fold_virt_text(endLnum)
    if #endVirtText > 3 then
      local pos = #newVirtText + 1
      for i = #endVirtText, 1, -1 do
        if vim.tbl_contains({ ')', '}', ']', ',', ';' }, endVirtText[i][1]) then
          table.insert(newVirtText, pos, endVirtText[i])
        else
          break
        end
      end
    else
      for _, item in ipairs(ctx.get_fold_virt_text(endLnum)) do
        if not (vim.startswith(item[1], ' ') or vim.startswith(item[1], '	')) then
          table.insert(newVirtText, item)
        end
      end
    end
  end
  return newVirtText
end

-- return a string type use internal providers
-- return a string in a table like a string type
-- return empty string '' will disable any providers
-- return `nil` will use default value {'lsp', 'indent'}
local ftMap = {
  vim = 'indent',
  python = { 'indent' },
  git = '',
}

-- lsp->treesitter->indent
local function customizeSelector(bufnr)
  local function handleFallbackException(err, providerName)
    if type(err) == 'string' and err:match 'UfoFallbackException' then
      return require('ufo').getFolds(providerName, bufnr)
    else
      return require('promise').reject(err)
    end
  end

  return require('ufo')
    .getFolds('lsp', bufnr)
    :catch(function(err)
      return handleFallbackException(err, 'treesitter')
    end)
    :catch(function(err)
      return handleFallbackException(err, 'indent')
    end)
end

require('ufo').setup {
  open_fold_hl_timeout = 600,
  enable_get_fold_virt_text = true,
  fold_virt_text_handler = handler,
  provider_selector = function(bufnr, filetype, buftype)
    -- use indent provider for c fieltype
    -- if filetype == 'c' then
    --   return function()
    --     return require('ufo').getFolds('indent', bufnr)
    --   end
    -- end

    -- default:
    -- return { 'lsp', 'indent' }
    return { 'treesitter', 'indent' }
    -- return ftMap[filetype] or customizeSelector
  end,
  -- For now, only 'lsp' provider contain 'comment', 'imports' and 'region'.
  close_fold_kinds = { 'imports', 'comment' },
  preview = {
    -- win_config = {
    --   border = { '', '─', '', '', '', '─', '', '' },
    --   winhighlight = 'Normal:Folded',
    --   winblend = 0,
    -- },
    mappings = {
      -- scrollU = '<C-u>',
      -- scrollD = '<C-d>',
      switch = preview_key,
    },
  },
}
