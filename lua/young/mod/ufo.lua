vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'J', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.cmd 'normal! J'
  end
end)
vim.keymap.set('n', 'zk', require('ufo').goPreviousStartFold)

local function peek_prev_fold()
  require('ufo').goPreviousClosedFold()
  require('ufo').peekFoldedLinesUnderCursor()
end

local function peek_next_fold()
  require('ufo').goNextClosedFold()
  require('ufo').peekFoldedLinesUnderCursor()
end

vim.keymap.set('n', 'z[', peek_prev_fold)
vim.keymap.set('n', 'z]', peek_next_fold)

local handler = function(virtText, lnum, endLnum, width, truncate)
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
  open_fold_hl_timeout = 800,
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
}
