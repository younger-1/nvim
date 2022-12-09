local M = {}

-- function M.remove_augroup(name)
--   if vim.fn.exists('#' .. name) == 1 then
--     vim.cmd('au! ' .. name)
--   end
-- end

--- Disable autocommand groups if it exists
--- This is more reliable than trying to delete the augroup itself
---@param group string the augroup name
function M.disable_augroup(group, bufnr)
  -- defer the function in case the autocommand is still in-use
  -- vim.schedule(function()
  --   if vim.fn.exists('#' .. group) == 1 then
  --     vim.cmd('augroup ' .. group)
  --     if bufnr then
  --       vim.cmd [[autocmd! * <buffer>]]
  --     else
  --       vim.cmd [[autocmd!]]
  --     end
  --     vim.cmd 'augroup END'
  --   end
  -- end)

  if bufnr then
    -- augroup group_name
    --   autocmd! * <buffer>
    -- augroup END
    vim.api.nvim_clear_autocmds {
      group = group,
      -- pattern = '<buffer>',
      buffer = bufnr,
    }
  else
    -- augroup group_name
    --   autocmd!
    -- augroup END

    -- vim.api.nvim_clear_autocmds {
    --   group = group,
    -- }
    vim.api.nvim_create_augroup(group, { clear = true })
  end
end

--- Create autocommand groups based on the passed definitions
---@param augroups table contains trigger, pattern and text. The key will be used as a group name
function M.enable_augroups(augroups)
  -- for group_name, augroup in pairs(augroups) do
  --   vim.cmd('augroup ' .. group_name)
  --   if augroup.buffer then
  --     vim.cmd [[autocmd! * <buffer>]]
  --   else
  --     vim.cmd [[autocmd!]]
  --   end

  --   for _, def in ipairs(augroup) do
  --     local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
  --     vim.cmd(command)
  --   end

  --   vim.cmd [[augroup END]]
  -- end

  for group_name, autocmds in pairs(augroups) do
    xy.autogroup(group_name, autocmds)
  end
end

local augroup_prefix = '_xy_'
M.build_augroups = function(augroups, enable)
  for name, autocmds in pairs(augroups) do
    local group_name = augroup_prefix .. name

    M['enable_' .. name] = function(bufnr)
      autocmds.bufnr = bufnr
      M.enable_augroups { [group_name] = autocmds }
    end

    M['disable_' .. name] = function(bufnr)
      M.disable_augroup(group_name, bufnr)
    end

    M['toggle_' .. name] = function(bufnr)
      if 0 == vim.fn.exists('#' .. group_name .. '#' .. autocmds[1][1]) then
        M['enable_' .. name](bufnr)
      else
        M['disable_' .. name](bufnr)
      end
    end

    if enable == true then
      M['enable_' .. name]()
    end
  end
end

function M.done()
  tt()

  if xy.transparent_mode == true then
    -- hi! Normal ctermbg=none guibg=none
    -- hi! NonText ctermbg=none guibg=none
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('_transparent', {}),
      pattern = '*',
      callback = function()
        local hl_groups = {
          'Normal',
          'SignColumn',
          'NormalNC',
          'TelescopeBorder',
          'NvimTreeNormal',
          'EndOfBuffer',
          'MsgArea',
        }
        for _, name in ipairs(hl_groups) do
          vim.cmd(string.format('highlight %s ctermbg=none guibg=none', name))
        end
      end,
    })
  end

  -- can not use resolve when system is hardlink (e.g. docker image)
  -- local plugins_path = vim.fn.resolve(require('young.cfg').reload_path)
  local plugins_path = require('young.cfg').reload_path
  if is_windows then
    -- autocmds require forward slashes even on windows
    plugins_path = plugins_path:gsub('\\', '/')
  end

  -- TODO:https://zhuanlan.zhihu.com/p/557199534
  -- TODO:https://github.com/akinsho/dotfiles/blob/nightly/.config/nvim/plugin/autocommands.lua
  --- Load the default set of autogroups and autocommands.
  M.enable_augroups {
    _general = {
      -- NOTE: use ftplugin which could be shared with vim
      -- { 'FileType', 'qf,help,man', 'nnoremap <buffer> q <Cmd>close<CR>' },
      -- { "VimLeavePre", "*", "set title set titleold=" },
      {
        'TextYankPost',
        '*',
        -- "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 500})",
        "lua vim.highlight.on_yank({ higroup = 'Search', timeout = 500 })",
        desc = 'Highlight text on yank',
      },
      -- { 'FocusLost', '*', 'silent! wa' },
    },
    -- _goto_last_position = {
    --   {
    --     'BufReadPost',
    --     '*',
    --     [[if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"zvzz" | endif]],
    --     desc = 'Jump to last cursor position when opening a file',
    --   },
    --   -- {
    --   --   'BufReadPost',
    --   --   '*',
    --   --   function()
    --   --     local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    --   --     if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
    --   --       vim.api.nvim_win_set_cursor(0, { row, col })
    --   --     end
    --   --   end,
    --   -- },
    -- },
    _number = {
      { 'InsertEnter', '*', require('young.tool').no_rnu },
      { 'InsertLeave', '*', require('young.tool').rnu },
    },
    _cursorline = {
      { 'InsertEnter,WinLeave,FocusLost', '*', require('young.tool').no_cursorline },
      { 'InsertLeave,WinEnter,FocusGained', '*', require('young.tool').cursorline },
    },
    _cursor = {
      {
        'VimEnter,VimResume',
        '*',
        'set guicursor=n-v-c-sm:block-blinkon100,i-ci-ve:ver25-blinkon100,r-cr-o:hor20-blinkon100',
      },
      { 'VimLeave,VimSuspend', '*', 'set guicursor=a:ver25-blinkon100' },
    },
    _indentline = {
      {
        'BufReadPost',
        '*',
        function()
          vim.defer_fn(function()
            if not vim.bo.expandtab and fn.exists ':IndentBlankline' > 0 then
              vim.cmd 'IndentBlanklineDisable'
            end
          end, 500)
        end,
      },
      -- {
      --   'BufReadPost',
      --   '*',
      --   function()
      --     vim.cmd [[
      --     call timer_start(500,
      --         \ {-> execute('if !&expandtab && exists(":IndentBlankline") | exe "IndentBlanklineDisable" | endif')},
      --         \ {'repeat': 1})
      --   ]]
      --   end,
      -- },
    },
    _syntax = {
      {
        'BufEnter',
        '*',
        function()
          if vim.api.nvim_buf_line_count(0) > 10000 then
            vim.cmd [[syntax clear]]
          end
        end,
      },
    },
    _colorscheme = {
      -- { 'ColorScheme', '*', [[echomsg expand('<afile>') expand('<amatch>')]] },
      { 'ColorScheme', '*', 'hi PmenuSel blend=0' }, -- @see :h 'pumblend'
      { 'ColorScheme', '*', require('young.tool').hi_lsp_ref },
      { 'ColorScheme', '*', 'hi MatchParen gui=bold,underline' },
    },
    _formatoptions = {
      {
        { 'BufWinEnter', 'BufRead', 'BufNewFile' },
        '*',
        'setlocal formatoptions-=c formatoptions-=r formatoptions-=o',
      },
    },
    _auto_reload = { -- <https://github.com/jdhao/nvim-config/blob/2c7e4aa87aefcc32682d017eae9e3c1395ae8f2b/lua/custom-autocmd.lua#L52>
      {
        'FileChangedShellPost',
        '*',
        function()
          vim.notify('File changed on disk. Buffer reloaded!', vim.log.levels.WARN, { title = '' })
        end,
      },
      -- {
      --   { 'FocusGained', 'CursorHold' },
      --   '*',
      --   [[if getcmdwintype() == "" | checktime | endif]],
      -- },
    },
    -- _auto_resize = {
    --   { -- will cause split windows to be resized evenly if main window is resized
    --     'VimResized',
    --     '*',
    --     -- 'tabdo wincmd =',
    --     'wincmd =',
    --   },
    -- },
    -- _auto_mkdir = {
    --   {
    --     'BufWritePre',
    --     '*',
    --     function(ctx)
    --       fn.mkdir(fn.fnamemodify(ctx.file, ':p:h'), 'p')
    --     end,
    --   },
    -- },
    -- _auto_save = {
    --   { -- <https://github.com/regen100/dotfiles/blob/cd03be29af6d361201184c15297625ebfb575c24/nvim/.config/nvim/lua/user/autosave.lua#L17>
    --     'InsertLeave,BufLeave,TextChanged',
    --     '*',
    --     function()
    --       if fn.filereadable(fn.expand '%:p') == 0 then
    --         return
    --       end
    --       if not vim.bo.modifiable then
    --         return
    --       end
    --       vim.cmd 'silent! noautocmd w'
    --     end,
    --   },
    -- },
    _auto_cd = {
      -- TODO: toggle by key: one key for toggle auto mode, one key for lcd dir
      -- { 'VimEnter,BufWinEnter', '*', '++nested ProjectRoot' },
      -- { 'DirChanged', '*', 'echo "[cwd]: " .. getcwd()' },
    },
    _lsp = {
      -- { 'CursorHold', '*', 'lua vim.diagnostic.open_float(nil, { source = "always" })' },
      { 'FileType', 'lspinfo,lsp-installer,null-ls-info', 'nnoremap <buffer> q <Cmd>close<CR>' },
      { 'FileType', 'lspinfo,lsp-installer,null-ls-info,any-jump', require('young.tool').add_border },
      { 'FileType', 'sagahover,sagarename,lspsagaoutline', 'nnoremap <buffer> q <Cmd>close<CR>' },
      { 'FileType', 'notify,dap-float', 'nnoremap <buffer> q <Cmd>close<CR>' },
    },
    _startup = {
      { 'VimEnter', '*', require('young.tool').startup_time },
      --
      -- { 'VimEnter', '*', 'lua require("young.tool").startup_event("VimEnter")' },
      -- { 'BufRead', '*', 'lua require("young.tool").startup_event("BufRead")' },
      -- { 'BufReadPost', '*', 'lua require("young.tool").startup_event("BufReadPost")' },
      -- { 'BufEnter', '*', 'lua require("young.tool").startup_event("BufEnter")' },
      -- { 'BufWinEnter', '*', 'lua require("young.tool").startup_event("BufWinEnter")' },
      -- { 'CmdlineEnter', '*', 'lua require("young.tool").startup_event("CmdlineEnter")' },
      --
      -- { 'VimEnter', '*', 'lua require("young.tool").startup_event("VimEnter")', once = true },
      -- { 'BufRead', '*', 'lua require("young.tool").startup_event("BufRead")', once = true },
      -- { 'BufReadPost', '*', 'lua require("young.tool").startup_event("BufReadPost")', once = true },
      -- { 'BufEnter', '*', 'lua require("young.tool").startup_event("BufEnter")', once = true },
      -- { 'BufWinEnter', '*', 'lua require("young.tool").startup_event("BufWinEnter")', once = true },
      -- { 'CmdlineEnter', '*', 'lua require("young.tool").startup_event("CmdlineEnter")', once = true },
    },
    _packer = {
      -- { "BufWritePost", plugins_path, 'source <afile> | PackerCompile' },
      { 'BufWritePost', plugins_path, require('young.packer').recompile },
      { 'User', 'PackerCompileDone', "lua require('young.mod.notify').yntf('😆 PackerCompile done')" },
      { 'User', 'PackerComplete', 'doautocmd ColorScheme' },
    },
    _terminal = {
      -- { -- https://github.com/andrewferrier/dotfiles/blob/main/common/.config/nvim/plugin/terminal.lua
      --   'TermOpen',
      --   '*',
      --   function()
      --     vim.opt_local.number = false
      --     vim.opt_local.relativenumber = false
      --     vim.cmd 'startinsert'
      --   end,
      -- },
      -- { -- Auto close shell terminals (#15440)
      --   'TermClose',
      --   '*',
      --   [[if !v:event.status |
      --   \   let info = nvim_get_chan_info(&channel) |
      --   \   if get(info, 'argv', []) ==# [&shell] |
      --   \     exec 'bdelete! ' .. expand('<abuf>') |
      --   \   endif |
      --   \ endif]],
      -- },
    },
    -- _notify = { -- @see <https://github.com/b0o/nvim-conf/blob/8abde1b6a1e728747af165f813308e4dea24a76f/lua/user/notify.lua#L14>
    --   {
    --     'FocusGained',
    --     '*',
    --     'let g:nvim_focused = 1',
    --   },
    --   {
    --     'FocusLost',
    --     '*',
    --     'let g:nvim_focused = 0',
    --   },
    -- },
    -- _neogit = {
    --   {
    --     'User',
    --     'FugitiveChanged',
    --     function()
    --       local neogit = package.loaded.neogit
    --       if neogit then
    --         neogit.dispatch_refresh()
    --       end
    --     end,
    --   },
    -- },
  }

  local format_opts = { pattern = '*', timeout = 1000 }
  local fmt_cmd = fmt(':silent lua vim.lsp.buf.formatting_sync({}, %s)', format_opts.timeout)

  M.build_augroups {
    print_ascii = { { 'CursorHold', '*', ':normal! ga' } },
    format_on_save = { { 'BufWritePre', format_opts.pattern, fmt_cmd } },
    code_lens_refresh = {
      {
        'BufEnter,InsertLeave',
        nil,
        'lua vim.lsp.codelens.refresh()',
      },
    },
    lsp_document_highlight = {
      {
        'CursorHold',
        nil,
        -- fmt("lua require('young.autocmd.core').conditional_document_highlight(%d)", client_id),
        'lua vim.lsp.buf.document_highlight()',
      },
      {
        'CursorMoved',
        nil,
        'lua vim.lsp.buf.clear_references()',
      },
    },
  }

  M.build_augroups({
    -- Hide cursorline in insert mode and when the current window doesn't have focus
    -- autocmd InsertEnter * setlocal nocursorline
    -- autocmd InsertLeave * setlocal cursorline
    -- autocmd WinLeave,FocusLost * if !&diff | setlocal nocursorline | endif
    -- autocmd InsertLeave,WinEnter,FocusGained * let &l:cursorline = mode() !=# 'i'
    -- auto_cursorline = {
    --   {
    --     'InsertEnter',
    --     '*',
    --     'setlocal nocursorline',
    --   },
    --   {
    --     'WinLeave,FocusLost',
    --     '*',
    --     'if !&diff | setlocal nocursorline | endif',
    --   },
    --   {
    --     'InsertLeave,WinEnter,FocusGained',
    --     '*',
    --     'set cursorline',
    --   },
    -- },
  }, true)

  -- require 'young.autocmd.core'
end

-- return setmetatable(M, { __index = require 'young.autocmd.core' })
return M
