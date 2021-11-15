local M = {}
-- local Log = require "lvim.core.log"

local config_dir = vim.fn.stdpath 'config'

--- Load the default set of autogroups and autocommands.
function M.load_augroups()
  -- local user_config_file = vim.fn.resolve(require("lvim.config"):get_user_config_path())
  -- FIXME:
  local user_config_file = "plugins.lua"

  return {
    _general_settings = {
      { "FileType", "qf,help,man", "nnoremap <silent> <buffer> q :close<CR>" },
      {
        "TextYankPost",
        "*",
        "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 500})",
      },
      {
        "BufWinEnter",
        "dashboard",
        "setlocal cursorline signcolumn=yes cursorcolumn number",
      },
      -- { "BufWritePost", user_config_file, "lua require('lvim.config'):reload()" },
      { "BufWritePost", user_config_file, ":echomsg '[reload young]'" },
      { "FileType", "qf", "set nobuflisted" },
      -- { "VimLeavePre", "*", "set title set titleold=" },
    },
    _formatoptions = {
      {
        "BufWinEnter,BufRead,BufNewFile",
        "*",
        "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
      },
    },
    _filetypechanges = {
      { "BufWinEnter", ".tf", "setlocal filetype=terraform" },
      { "BufRead", "*.tf", "setlocal filetype=terraform" },
      { "BufNewFile", "*.tf", "setlocal filetype=terraform" },
      { "BufWinEnter", ".zsh", "setlocal filetype=sh" },
      { "BufRead", "*.zsh", "setlocal filetype=sh" },
      { "BufNewFile", "*.zsh", "setlocal filetype=sh" },
    },
    _git = {
      { "FileType", "gitcommit", "setlocal wrap" },
      { "FileType", "gitcommit", "setlocal spell" },
    },
    _markdown = {
      { "FileType", "markdown", "setlocal wrap" },
      { "FileType", "markdown", "setlocal spell" },
    },
    _buffer_bindings = {
      { "FileType", "floaterm", "nnoremap <silent> <buffer> q :q<CR>" },
    },
    _auto_resize = {
      -- will cause split windows to be resized evenly if main window is resized
      { "VimResized", "*", "tabdo wincmd =" },
    },
    _general_lsp = {
      { "FileType", "lspinfo,lsp-installer,null-ls-info", "nnoremap <silent> <buffer> q :close<CR>" },
    },
    custom_groups = {},
  }
end

local get_format_on_save_opts = function()
  local defaults = {
    ---@usage pattern string pattern used for the autocommand (Default: '*')
    pattern = "*",
    ---@usage timeout number timeout in ms for the format request (Default: 1000)
    timeout = 1000,
  }

  return {
    pattern = defaults.pattern,
    timeout = defaults.timeout,
  }
end

function M.enable_format_on_save(opts)
  local fmd_cmd = string.format(":silent lua vim.lsp.buf.formatting_sync({}, %s)", opts.timeout_ms)
  M.define_augroups {
    format_on_save = { { "BufWritePre", opts.pattern, fmd_cmd } },
  }
  -- Log:debug "enabled format-on-save"
end

function M.disable_format_on_save()
  M.remove_augroup "format_on_save"
  -- Log:debug "disabled format-on-save"
end

function M.configure_format_on_save()
  if lvim.format_on_save then
    if vim.fn.exists "#format_on_save#BufWritePre" == 1 then
      M.remove_augroup "format_on_save"
      -- Log:debug "reloading format-on-save configuration"
    end
    local opts = get_format_on_save_opts()
    M.enable_format_on_save(opts)
  else
    M.disable_format_on_save()
  end
end

function M.toggle_format_on_save()
  if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
    local opts = get_format_on_save_opts()
    M.enable_format_on_save(opts)
  else
    M.disable_format_on_save()
  end
end

function M.remove_augroup(name)
  if vim.fn.exists("#" .. name) == 1 then
    vim.cmd("au! " .. name)
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
    vim.cmd("augroup " .. group_name)
    vim.cmd "autocmd!"

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
      vim.cmd(command)
    end

    vim.cmd "augroup END"
  end
end

M.once = function()
  local aus = M.load_augroups()
  M.define_augroups(aus)
end

M.once()

return M
