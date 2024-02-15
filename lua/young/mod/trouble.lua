local M = {}

M.once = function()
  local t = require('young.mod.telescope').cfg
  t.defaults.mappings.i['<c-t>'] = function(prompt_bufnr)
    require('trouble.providers.telescope').smart_open_with_trouble(prompt_bufnr)
  end
  t.defaults.mappings.n['t'] = function(prompt_bufnr)
    require('trouble.providers.telescope').smart_open_with_trouble(prompt_bufnr)
  end

  local cmd = require('young.key').cmd
  xy.map.register {
    ['<leader>x'] = {
      x = { cmd 'TroubleToggle', 'Open' },
      t = { cmd 'TodoTrouble', 'Todo' },
      ['.'] = { cmd 'Trouble telescope', 'Telescope' },
      ['<C-q>'] = { cmd 'TroubleToggle quickfix', 'QuickFix' },
      ['<C-a>'] = { cmd 'TroubleToggle loclist', 'LocList' },
      --
      d = { cmd 'TroubleToggle lsp_definitions', 'Def' },
      r = { cmd 'TroubleToggle lsp_references', 'Ref' },
      y = { cmd 'TroubleToggle lsp_type_definitions', 'Type' },
      i = { cmd 'TroubleToggle lsp_implementations', 'Impl' },
      e = { cmd 'TroubleToggle document_diagnostics', 'Diagnostics' },
      E = { cmd 'TroubleToggle workspace_diagnostics', 'Diagnostics(All)' },
    },
    [']x'] = {
      function()
        if require('trouble').is_open() then
          require('trouble').next { skip_groups = true, jump = true }
        end
      end,
      'Next trouble item',
    },
    ['[x'] = {
      function()
        if require('trouble').is_open() then
          require('trouble').previous { skip_groups = true, jump = true }
        end
      end,
      'Prev trouble item',
    },
  }
end

M.done = function()
  require('trouble').setup {
    position = 'bottom', -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = 'document_diagnostics', -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = '', -- icon used for open folds
    fold_closed = '', -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    action_keys = {
      -- map to {} to remove a mapping, for example: close = {},
      close = 'q', -- close the list
      cancel = '<esc>', -- cancel the preview and get back to your last window / buffer / cursor
      refresh = 'r', -- manually refresh
      jump = { '<cr>', '<tab>' }, -- jump to the diagnostic or open / close folds
      open_split = { '<c-x>' }, -- open buffer in new split
      open_vsplit = { '<c-v>' }, -- open buffer in new vsplit
      open_tab = { '<c-t>' }, -- open buffer in new tab
      jump_close = { 'o' }, -- jump to the diagnostic and close the list
      toggle_mode = 'm', -- toggle between "workspace" and "document" diagnostics mode
      toggle_preview = 'P', -- toggle auto_preview
      hover = 'K', -- opens a small popup with the full multiline message
      preview = 'p', -- preview the diagnostic location
      close_folds = { 'zM', 'zm' }, -- close all folds
      open_folds = { 'zR', 'zr' }, -- open all folds
      toggle_fold = { 'zA', 'za', 'i' }, -- toggle fold of current file
      previous = 'k', -- preview item
      next = 'j', -- next item
      -- TODO: window is not big enough
      help = '?',
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = { 'lsp_definitions' }, -- for the given modes, automatically jump if there is only a single result
    signs = {
      error = '',
      warning = '',
      hint = '',
      information = '',
      other = '﫠',
    },
    use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
  }
end

return M
