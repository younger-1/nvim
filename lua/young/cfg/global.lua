-- <https://github.com/ayamir/nvimdots/blob/cbe59f051b4a913fcdc014664ce32b37c3b0f577/lua/core/init.lua#L23>

do
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1

  vim.g.loaded_gzip = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1

  vim.g.loaded_logiPat = 1
  vim.g.loaded_rrhelper = 1

  -- vim.g.loaded_man = 1

  -- Do not use builtin matchit.vim and matchparen.vim since we use vim-matchup
  vim.g.loaded_matchit = 1
  vim.g.loaded_matchparen = 1

  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrwFileHandlers = 1
  vim.g.loaded_netrwSettings = 1

  vim.g.loaded_spellfile_plugin = 1
  vim.g.loaded_tutor_mode_plugin = 1

  -- <https://github.com/jdhao/nvim-config/blob/470e35439a76298b485dc7fc5f9a54b6ec8175f1/core/globals.vim#L11>
  -- Disable Python2 support
  vim.g.loaded_python_provider = 0
  -- Disable perl provider
  vim.g.loaded_perl_provider = 0
  -- Disable ruby provider
  vim.g.loaded_ruby_provider = 0
  -- Disable node provider
  vim.g.loaded_node_provider = 0

  -- vim.g.loaded_remote_plugins = 1
end

vim.g.mapleader = ' '

-- In NeoVim 0.8+ this is the default - @see
-- https://github.com/neovim/neovim/issues/14090#issuecomment-1177933661
if not xy.has 'nvim-0.8' then
  -- Do not source the default filetype.vim. @see
  -- <https://github.com/nathom/filetype.nvim/issues/12>
  vim.g.did_load_filetypes = 0
  -- Lua filetype detection is opt-in. You can enable it by adding:
  vim.g.do_filetype_lua = 1
end

-- TODO:filetype.lua
vim.filetype.add {
  extension = {
    conf = 'config',
    tex = 'latex', -- We always want LaTeX, avoid slow detection logic
    -- edn = 'clojure',
    -- boot = 'clojure',
    -- h = function(path, bufnr) -- a heuristic that only sets the filetype to C++ if the header file includes another C++-style header (i.e. one without a trailing .h):
    --   if vim.fn.search('\\C^#include <[^>.]\\+>$', 'nw') ~= 0 then
    --     return 'cpp'
    --   end
    --   return 'c'
    -- end,
    thrift = 'thrift',
  },
  filename = {
    conf = 'config',
    config = 'config',
    ['.luarc.json'] = 'jsonc',
    ['settings.json'] = 'jsonc',
    ['coc-settings.json'] = 'jsonc',
    -- ['tsconfig.json'] = 'jsonc',
    -- ['jsconfig.json'] = 'jsonc',
    ['.envrc'] = 'bash',
    ['go.mod'] = 'gomod',
    ['.clang-format'] = 'yaml',
    ['BUILD_cn'] = 'bzl',
    ['BUILD_i18n'] = 'bzl',
    ['pixi.lock'] = 'yaml',
  },
  pattern = {
    ['.*%.gitignore.*'] = 'gitignore',
    ['.*/%.config/git/.*'] = 'gitconfig',
    ['.*/dotter/git/.*'] = 'gitconfig',
    ['.*/kitty/.*%.conf'] = 'kitty',
    ['.*/kitty/.*%.session'] = 'kitty-session',
    -- ['.*Dockerfile.*'] = 'dockerfile',
    -- ['%.env.*'] = 'sh',
    -- ['.*envrc.*'] = 'sh',
    -- ['.*/systemd/user/.*'] = 'systemd',
    -- ['.*/hugo/layouts/.*%.html'] = 'gohtmltmpl',
    -- ['environment.*'] = 'dosini',
    -- ['grub.*'] = 'dosini',
  },
}

-- <https://github.com/kylo252/dotfiles/blob/de7cb1e8a08cff3d772a4253dfbcdb94dbba8d4f/.config/nvim/lua/user/settings.lua#L49>
-- if xy.has 'wsl' then
--   vim.g.clipboard = {
--     copy = {
--       ["+"] = "win32yank.exe -i --crlf",
--       ["*"] = "win32yank.exe -i --crlf",
--     },
--     paste = {
--       ["+"] = "win32yank.exe -o --lf",
--       ["*"] = "win32yank.exe -o --lf",
--     },
--   }
-- end

-- NOTE: in Window, env name is case insensitive. NOT in Linux
-- vim.env.SCOOP
-- vim.loop.os_getenv 'scoop'
local scoop = os.getenv 'scoop'

if is_windows then
  if scoop then
    vim.g.sqlite_clib_path = join_paths(scoop, 'apps', 'sqlite3dll', 'current', 'sqlite3.dll')
  else
    vim.notify('[young]: scoop not installed', vim.log.levels.INFO)
  end
end

-- Two reason to use `python3`:
-- 1. most linux require `python3`; 2. windows's scoop will generete `python3` shim to avoid using conda env
vim.g.python3_host_prog = vim.fn.exepath 'python3'

vim.g.xy = { coc = xy.coc }
