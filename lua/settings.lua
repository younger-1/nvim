local default_options = {
  backup = false,
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1,
  colorcolumn = "99999", -- fixes indentline for now
  completeopt = { "menuone", "noselect" },
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  -- fileformat = 'unix',
  foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
  foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
  guifont = "SauceCodePro NF", -- the font used in graphical neovim applications
  hidden = true, -- required to keep multiple buffers and open multiple buffers
  inccommand = "split",
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 200, -- time to wait for a mapped sequence to complete (in milliseconds)
  title = true, -- set the title of window to the value of the titlestring
  -- undodir = join_paths(vim.fn.stdpath "cache", "undo"), -- set an undo directory
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 4, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = false, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  spell = false,
  spelllang = "en",
  scrolloff = 4, -- is one of my fav
  sidescrolloff = 8,
}

-- Completion
vim.opt.shortmess:append "c"

for k, v in pairs(default_options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"

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
  vim.g.loaded_netrwFileHandlers = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrwSettings = 1

  vim.g.loaded_spellfile_plugin = 1
  vim.g.loaded_tutor_mode_plugin = 1

  -- <https://github.com/jdhao/nvim-config/blob/470e35439a76298b485dc7fc5f9a54b6ec8175f1/core/globals.vim#L11>
  -- Disable Python2 support
  vim.g.loaded_python_provider = 1
  -- Disable perl provider
  vim.g.loaded_perl_provider = 1
  -- Disable ruby provider
  vim.g.loaded_ruby_provider = 1
  -- Disable node provider
  -- vim.g.loaded_node_provider = 1
  -- vim.g.loaded_remote_plugins = 1

  -- [](https://github.com/nathom/filetype.nvim/issues/12)
  -- Do not source the default filetype.vim
  -- vim.g.did_load_filetypes = 1
end

local neovide_config = function()
  vim.cmd [[set guifont=JetBrainsMono\ Nerd\ Font:h12]]
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_no_idle = true
  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_cursor_trail_length = 0.05
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_speed = 20.0
  vim.g.neovide_cursor_vfx_particle_density = 5.0
end

disable_distribution()
-- neovide_config()

if vim.loop.os_uname().sysname == 'Windows_NT' then
  vim.g.sqlite_clib_path = join_paths(os.getenv 'SCOOP', 'apps', 'sqlite3dll', 'current', 'sqlite3.dll')
end

