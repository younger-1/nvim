-- <https://github.com/ayamir/nvimdots/blob/cbe59f051b4a913fcdc014664ce32b37c3b0f577/lua/core/init.lua#L23>
local disable_distribution = function()
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

  vim.g.loaded_man = 1

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

disable_distribution()

-- Do not source the default filetype.vim
-- <https://github.com/nathom/filetype.nvim/issues/12>
vim.g.did_load_filetypes = 0
-- For now, Lua filetype detection is opt-in. You can enable it by adding:
vim.g.do_filetype_lua = 1

vim.filetype.add {
  extension = {
    -- foo = "fooscript",
  },
  filename = {
    -- ["Foofile"] = "fooscript",
  },
  pattern = {
    -- ["~/%.config/foo/.*"] = "fooscript",
  },
}

-- <https://github.com/kylo252/dotfiles/blob/de7cb1e8a08cff3d772a4253dfbcdb94dbba8d4f/.config/nvim/lua/user/settings.lua#L49>
-- if vim.fn.has "wsl" == 1 then
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
