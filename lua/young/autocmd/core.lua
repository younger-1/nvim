local M = require 'young.autocmd'

-- function M.enable_auto_chdir()
--   M.define_augroups {
--     -- Need ++nested to trigger DirChanged event for updating nvim-tree, gitsigns
--     auto_chdir = { { 'VimEnter,BufWinEnter', '*', [[++nested ProjectRoot]] } },
--     -- auto_chdir = { { 'VimEnter,BufWinEnter', '*', [[++nested lua require('young.tool').chdir(true)]] } },
--   }
-- end

-- function M.disable_auto_chdir()
--   M.disable_augroup 'auto_chdir'
-- end

-- function M.toggle_auto_chdir()
--   -- Must use event here. Once enable a group, `exists('group_name')` always return 1
--   if vim.fn.exists '#auto_chdir#VimEnter,BufWinEnter' == 0 then
--     M.enable_auto_chdir()
--   else
--     M.disable_auto_chdir()
--   end
-- end

-- local format_on_save_opts = {
--   ---@usage pattern string pattern used for the autocommand (Default: '*')
--   pattern = '*',
--   ---@usage timeout number timeout in ms for the format request (Default: 1000)
--   timeout = 1000,
-- }

-- function M.enable_format_on_save(opts)
--   opts = vim.tbl_extend('force', format_on_save_opts, opts or {})
--   local fmt_cmd = string.format(':silent lua vim.lsp.buf.formatting_sync({}, %s)', opts.timeout)
--   M.define_augroups {
--     format_on_save = { { 'BufWritePre', opts.pattern, fmt_cmd } },
--   }
--   -- Log:debug "enabled format-on-save"
-- end

-- function M.disable_format_on_save()
--   M.disable_augroup 'format_on_save'
--   -- Log:debug "disabled format-on-save"
-- end

-- function M.toggle_format_on_save()
--   if vim.fn.exists '#format_on_save#BufWritePre' == 0 then
--     M.enable_format_on_save()
--   else
--     M.disable_format_on_save()
--   end
-- end

M.conditional_document_highlight = function(id)
  local client_ok, method_supported = pcall(function()
    return vim.lsp.get_client_by_id(id).supports_method 'textDocument/documentHighlight'
  end)
  if not client_ok or not method_supported then
    return
  end
  vim.lsp.buf.document_highlight()
end

function M.enable_lsp_document_highlight(client_id)
  M.define_augroups({
    lsp_document_highlight = {
      {
        'CursorHold',
        '<buffer>',
        string.format("lua require('young.autocmd.core').conditional_document_highlight(%d)", client_id),
      },
      {
        'CursorMoved',
        '<buffer>',
        'lua vim.lsp.buf.clear_references()',
      },
    },
  }, true)
end

function M.disable_lsp_document_highlight()
  M.disable_augroup 'lsp_document_highlight'
end

-- function M.enable_code_lens_refresh()
--   M.define_augroups({
--     lsp_code_lens_refresh = {
--       {
--         'InsertLeave ',
--         '<buffer>',
--         'lua vim.lsp.codelens.refresh()',
--       },
--       {
--         'InsertLeave ',
--         '<buffer>',
--         'lua vim.lsp.codelens.display()',
--       },
--     },
--   }, true)
-- end

-- function M.disable_code_lens_refresh()
--   M.disable_augroup 'lsp_code_lens_refresh'
-- end

function M.enable_transparent_mode()
  vim.cmd 'au ColorScheme * hi Normal ctermbg=none guibg=none'
  vim.cmd 'au ColorScheme * hi SignColumn ctermbg=none guibg=none'
  vim.cmd 'au ColorScheme * hi NormalNC ctermbg=none guibg=none'
  vim.cmd 'au ColorScheme * hi MsgArea ctermbg=none guibg=none'
  vim.cmd 'au ColorScheme * hi TelescopeBorder ctermbg=none guibg=none'
  vim.cmd 'au ColorScheme * hi NvimTreeNormal ctermbg=none guibg=none'
  vim.cmd 'au ColorScheme * hi EndOfBuffer ctermbg=none guibg=none'
  vim.cmd "let &fcs='eob: '"
end

return M
