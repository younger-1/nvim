local M = {}

local get_format_on_save_opts = function()
  local defaults = {
    ---@usage pattern string pattern used for the autocommand (Default: '*')
    pattern = '*',
    ---@usage timeout number timeout in ms for the format request (Default: 1000)
    timeout = 1000,
  }

  return {
    pattern = defaults.pattern,
    timeout = defaults.timeout,
  }
end

function M.enable_format_on_save(opts)
  local fmd_cmd = string.format(':silent lua vim.lsp.buf.formatting_sync({}, %s)', opts.timeout)
  M.define_augroups {
    format_on_save = { { 'BufWritePre', opts.pattern, fmd_cmd } },
  }
  -- Log:debug "enabled format-on-save"
end

function M.disable_format_on_save()
  M.disable_augroup 'format_on_save'
  -- Log:debug "disabled format-on-save"
end

function M.configure_format_on_save()
  if lvim.format_on_save then
    local opts = get_format_on_save_opts()
    M.enable_format_on_save(opts)
  else
    M.disable_format_on_save()
  end
end

function M.toggle_format_on_save()
  if vim.fn.exists '#format_on_save#BufWritePre' == 0 then
    local opts = get_format_on_save_opts()
    M.enable_format_on_save(opts)
  else
    M.disable_format_on_save()
  end
end

function M.enable_lsp_document_highlight(client_id)
  M.define_augroups({
    lsp_document_highlight = {
      {
        'CursorHold',
        '<buffer>',
        string.format("lua require('lvim.lsp.utils').conditional_document_highlight(%d)", client_id),
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

function M.enable_code_lens_refresh()
  M.define_augroups({
    lsp_code_lens_refresh = {
      {
        'InsertLeave ',
        '<buffer>',
        'lua vim.lsp.codelens.refresh()',
      },
      {
        'InsertLeave ',
        '<buffer>',
        'lua vim.lsp.codelens.display()',
      },
    },
  }, true)
end

function M.disable_code_lens_refresh()
  M.disable_augroup 'lsp_code_lens_refresh'
end

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
