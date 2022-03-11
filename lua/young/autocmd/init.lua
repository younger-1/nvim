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
      },
      {
        'BufWinEnter',
        '*',
        [[if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
      },
      { 'VimLeave', '*', 'set guicursor=a:ver25' },
      { 'InsertEnter', '*', 'lua require("young.tools").nornu()' },
      { 'InsertLeave', '*', 'lua require("young.tools").rnu()' },
      -- TODO: toggle by key: one key for toggle auto mode, one key for lcd dir
      -- { 'VimEnter,BufWinEnter', '*', '++nested ProjectRoot' },
      -- { 'DirChanged', '*', 'echo "[cwd]: " .. getcwd()' },
    },
    _colorscheme = {
      -- { 'ColorScheme', '*', 'echomsg expand('<afile>') expand('<amatch>')' },
      { 'ColorScheme', '*', 'hi PmenuSel blend=0' }, -- See :h 'pumblend'
    },
    _formatoptions = {
      {
        'BufWinEnter,BufRead,BufNewFile',
        '*',
        'setlocal formatoptions-=c formatoptions-=r formatoptions-=o',
      },
    },
    _filetypechanges = {
      { 'BufWinEnter', '.tf', 'setlocal filetype=terraform' },
      { 'BufRead', '*.tf', 'setlocal filetype=terraform' },
      { 'BufNewFile', '*.tf', 'setlocal filetype=terraform' },
      { 'BufWinEnter', '.zsh', 'setlocal filetype=sh' },
      { 'BufRead', '*.zsh', 'setlocal filetype=sh' },
      { 'BufNewFile', '*.zsh', 'setlocal filetype=sh' },
      --
      { 'BufRead', 'settings.json', 'setlocal filetype=jsonc' },
      { 'BufRead', 'coc-settings.json', 'setlocal filetype=jsonc' },
    },
    _auto_resize = {
      -- will cause split windows to be resized evenly if main window is resized
      { 'VimResized', '*', 'tabdo wincmd =' },
    },
    _general_lsp = {
      { 'FileType', 'lspinfo,lsp-installer,null-ls-info,minimap', 'nnoremap <silent> <buffer> q :close<CR>' },
    },
    custom_groups = {
      -- { "BufWritePost", plugins_path, 'source <afile> | PackerCompile' },
      { 'BufWritePost', plugins_path, "lua require('young.plugin-loader').recompile()" },
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
---@param name string the augroup name
function M.disable_augroup(name)
  -- defer the function in case the autocommand is still in-use
  vim.schedule(function()
    if vim.fn.exists('#' .. name) == 1 then
      vim.cmd('augroup ' .. name)
      vim.cmd 'autocmd!'
      vim.cmd 'augroup END'
    end
  end)
end

--- Create autocommand groups based on the passed definitions
---@param definitions table contains trigger, pattern and text. The key will be used as a group name
---@param buffer boolean indicate if the augroup should be local to the buffer
function M.define_augroups(definitions, buffer)
  for group_name, definition in pairs(definitions) do
    vim.cmd('augroup ' .. group_name)
    if buffer then
      vim.cmd [[autocmd! * <buffer>]]
    else
      vim.cmd [[autocmd!]]
    end

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
      vim.cmd(command)
    end

    vim.cmd [[augroup END]]
  end
end

local augroup_prefix = '_yo_'
-- enable augroup by default
M.build = function(augroups, enable)
  for name, autocmds in pairs(augroups) do
    local group_name = augroup_prefix .. name

    M['enable_' .. name] = function()
      M.define_augroups {
        [group_name] = autocmds,
      }
    end

    M['disable_' .. name] = function()
      M.disable_augroup(group_name)
    end

    M['toggle_' .. name] = function()
      if 0 == vim.fn.exists('#' .. group_name .. '#' .. autocmds[1][1]) then
        M['enable_' .. name]()
      else
        M['disable_' .. name]()
      end
    end

    if enable ~= false then
      M['enable_' .. name]()
    end
  end
end

M.done = function()
  local aus = M.load_augroups()
  M.define_augroups(aus)

  local format_opts = { pattern = '*', timeout = 1000 }
  local fmt_cmd = string.format(':silent lua vim.lsp.buf.formatting_sync({}, %s)', format_opts.timeout)
  M.build {
    auto_chdir = { { 'VimEnter,BufWinEnter', '*', [[++nested ProjectRoot]] } },
    format_on_save = { { 'BufWritePre', format_opts.pattern, fmt_cmd } },
  }

  M.build({
    print_ascii = { { 'CursorHold', '*', ':normal! ga' } },
  }, false)

  require 'young.autocmd.core'
end

-- return setmetatable(M, { __index = require 'young.autocmd.core' })
return M
