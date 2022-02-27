local M = {}
-- local Log = require "lvim.core.log"

local config_dir = vim.fn.stdpath 'config'

-- FIXME:
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
        "BufWinEnter",
        "*",
        [[if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
      },
      { 'VimLeave', '*', 'set guicursor=a:ver25' },
      -- { 'DirChanged', '*', 'echo "[cwd]: " .. getcwd()' },
      -- TODO: toggle by key
      { 'InsertEnter', '*', 'set norelativenumber' },
      { 'InsertLeave', '*', 'set relativenumber' },
      -- TODO: toggle by key: one key for toggle auto mode, one key for lcd dir
      { 'VimEnter,BufWinEnter', '*', '++nested ProjectRoot' },
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
  local fmd_cmd = string.format(':silent lua vim.lsp.buf.formatting_sync({}, %s)', opts.timeout_ms)
  M.define_augroups {
    format_on_save = { { 'BufWritePre', opts.pattern, fmd_cmd } },
  }
  -- Log:debug "enabled format-on-save"
end

function M.disable_format_on_save()
  M.remove_augroup 'format_on_save'
  -- Log:debug "disabled format-on-save"
end

function M.configure_format_on_save()
  if lvim.format_on_save then
    if vim.fn.exists '#format_on_save#BufWritePre' == 1 then
      M.remove_augroup 'format_on_save'
      -- Log:debug "reloading format-on-save configuration"
    end
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

function M.remove_augroup(name)
  if vim.fn.exists('#' .. name) == 1 then
    vim.cmd('au! ' .. name)
  end
end

function M.define_augroups(definitions) -- {{{1
  -- Create autocommand groups based on the passed definitions
  --
  -- The key will be the name of the group, and each definition
  -- within the group should have:
  --    1. Trigger
  --    2. Pattern
  --    3. Text
  -- just like how they would normally be defined from Vim itself
  for group_name, definition in pairs(definitions) do
    vim.cmd('augroup ' .. group_name)
    vim.cmd 'autocmd!'

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
      vim.cmd(command)
    end

    vim.cmd 'augroup END'
  end
end

M.done = function()
  local aus = M.load_augroups()
  M.define_augroups(aus)
end

return M