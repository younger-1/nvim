local M = {}
-- local Log = require "lvim.core.log"

-- FIXME:
-- local config_dir = vim.fn.stdpath 'config'
-- local plugins_path = "plugins.lua"
local plugins_path = vim.fn.resolve(require('young.cfg').get_reload_path())
if is_windows then
  -- autocmds require forward slashes even on windows
  plugins_path = plugins_path:gsub('\\', '/')
end

if xy.transparent_mode == true then
  -- hi! Normal ctermbg=none guibg=none
  -- hi! NonText ctermbg=none guibg=none
  vim.api.nvim_create_autocmd('ColorScheme', {
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

--- Load the default set of autogroups and autocommands.
function M.load_augroups()
  return {
    _general_settings = {
      -- NOTE: use ftplugin which could be shared with vim
      -- { 'FileType', 'qf,help,man', 'nnoremap <silent> <buffer> q :close<CR>' },
      -- { "VimLeavePre", "*", "set title set titleold=" },
      {
        'TextYankPost',
        '*',
        -- "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 500})",
        "lua vim.highlight.on_yank({ higroup = 'Search', timeout = 500 })",
        desc = 'Highlight text on yank',
      },
      {
        'BufWinEnter',
        '*',
        [[if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"zvzz" | endif ]],
        desc = 'Jump to last cursor position when opening a file',
      },
      -- { 'FocusLost', '*', 'silent! wa' },
      {
        'VimEnter,VimResume',
        '*',
        'set guicursor=n-v-c-sm:block-blinkon100,i-ci-ve:ver25-blinkon100,r-cr-o:hor20-blinkon100',
      },
      { 'VimLeave,VimSuspend', '*', 'set guicursor=a:ver25-blinkon100' },
      -- { 'InsertEnter', '*', 'lua require("young.tool").nornu()' },
      -- { 'InsertLeave', '*', 'lua require("young.tool").rnu()' },
      { 'InsertEnter', '*', require('young.tool').nornu },
      { 'InsertLeave', '*', require('young.tool').rnu },
      -- TODO: toggle by key: one key for toggle auto mode, one key for lcd dir
      -- { 'VimEnter,BufWinEnter', '*', '++nested ProjectRoot' },
      -- { 'DirChanged', '*', 'echo "[cwd]: " .. getcwd()' },
      {
        'BufEnter',
        '*',
        function()
          if vim.api.nvim_buf_line_count(0) > 10000 then
            vim.cmd [[syntax off]]
          end
        end,
      },
    },
    _colorscheme = {
      -- { 'ColorScheme', '*', 'echomsg expand('<afile>') expand('<amatch>')' },
      { 'ColorScheme', '*', 'hi PmenuSel blend=0' }, -- See :h 'pumblend'
      { 'ColorScheme', '*', 'lua require("young.tool").lsp_ref()' }, -- See :h 'pumblend'
    },
    _formatoptions = {
      {
        'BufWinEnter,BufRead,BufNewFile',
        '*',
        'setlocal formatoptions-=c formatoptions-=r formatoptions-=o',
      },
    },
    _filetypechanges = {
      { 'BufRead', 'settings.json', 'setlocal filetype=jsonc' },
      { 'BufRead', 'coc-settings.json', 'setlocal filetype=jsonc' },
    },
    _auto_resize = {
      -- will cause split windows to be resized evenly if main window is resized
      { 'VimResized', '*', 'tabdo wincmd =' },
    },
    _general_lsp = {
      { 'FileType', 'lspinfo,lsp-installer,null-ls-info', 'nnoremap <silent> <buffer> q :close<CR>' },
      { 'FileType', 'lspinfo,lsp-installer,null-ls-info', 'lua require("young.tool").add_border()' },
      -- { 'CursorHold', '*', 'lua vim.diagnostic.open_float(nil, { source = "always" })' },
    },
    _startup = {
      { 'VimEnter', '*', 'lua require("young.tool").startup_time()' },
      --
      -- { 'VimEnter', '*', '++once', 'lua require("young.tool").startup_event("VimEnter")' },
      -- { 'BufRead', '*', '++once', 'lua require("young.tool").startup_event("BufRead")' },
      -- { 'BufReadPost', '*', '++once', 'lua require("young.tool").startup_event("BufReadPost")' },
      -- { 'BufEnter', '*', '++once', 'lua require("young.tool").startup_event("BufEnter")' },
      -- { 'BufWinEnter', '*', '++once', 'lua require("young.tool").startup_event("BufWinEnter")' },
    },
    custom_groups = {
      -- { "BufWritePost", plugins_path, 'source <afile> | PackerCompile' },
      { 'BufWritePost', plugins_path, "lua require('young.packer').recompile()" },
      { 'User', 'PackerCompileDone', "lua require('young.mod.notify').yntf('😆 PackerCompile done')" },
      { 'User', 'PackerComplete', 'doautocmd ColorScheme' },
    },
  }
end

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
    xy.autogroup(group_name, autocmds, true)
  end
end

local augroup_prefix = '_yo_'
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

M.done = function()
  tt()
  local aus = M.load_augroups()
  M.enable_augroups(aus)

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

  -- require 'young.autocmd.core'
end

-- return setmetatable(M, { __index = require 'young.autocmd.core' })
return M
