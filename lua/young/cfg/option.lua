-- <https://github.com/maxxnino/lvim/blob/main/lua/user/neovim.lua>
-- <https://github.com/n3wborn/nvim/blob/main/init.lua>

local default_options = {
  backup = false,
  clipboard = '',
  cmdheight = 1,
  completeopt = { 'menuone', 'noselect' },
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = 'utf-8', -- the encoding written to a file
  foldenable = false,
  foldmethod = 'expr', -- folding, set to "expr" for treesitter based folding
  foldexpr = 'nvim_treesitter#foldexpr()', -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
  -- guifont = is_windows and 'SauceCodePro NF' or 'SauceCodePro Nerd Font',
  guifontwide = { 'Sarasa Term SC' },
  hidden = true, -- required to keep multiple buffers and open multiple buffers
  inccommand = 'split',
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = '', -- allow the mouse to be used in neovim
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
  -- titlestring = '%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%) - LunarVim',
  -- undodir = join_paths(vim.fn.stdpath "cache", "undo"), -- set an undo directory
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  tabstop = 8, -- insert 2 spaces for a tab
  expandtab = true, -- convert tabs to spaces
  softtabstop = 2,
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  smarttab = true,
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = false, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
  wrap = false,
  spell = false,
  spelllang = 'en',
  scrolloff = 4, -- is one of my fav
  sidescrolloff = 8,
  confirm = true,
  showbreak = '↪',
  qftf = '{info -> v:lua.require("young.cfg.quickfix").quickfixtextfunc(info)}',
  fileencodings = { 'ucs-bom', 'utf-8', 'utf-16', 'gbk', 'big5', 'gb18030', 'latin1' },
  fileformats = { 'unix', 'dos', 'mac' },
  synmaxcol = 400,
  list = true,
  -- TODO:
  fillchars = 'vert:┃',
}

for k, v in pairs(default_options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append 'c'

vim.cmd 'set whichwrap+=<,>,[,],h,l'

-- vim.cmd [[set listchars=tab:●·,extends:→,precedes:←,trail:■]]
vim.opt.listchars = {
  tab = '●·',
  extends = '→',
  precedes = '←',
  trail = '■',
  nbsp = '␣',
}
-- vim.cmd [[set listchars=space:·,eol:↲,trail:~,tab:>-,extends:>,precedes:<,nbsp:+]]
-- vim.opt.listchars = {
--   eol = '↲',
--   extends = '>',
--   nbsp = '+',
--   precedes = '<',
--   space = '·',
--   tab = '>-',
--   trail = '~',
-- }

-- 朝闻道，金、木、水、火、土；【真香定律（王境泽）】；《静夜诗（李白）》。
-- 唐僧问道：‘泼猴，若我救你出来，你该如何报答我？’ 悟空：“你若放我出来，我定会送你上西天！”
vim.cmd [[set matchpairs+=<:>,「:」,『:』,【:】,（:）,《:》,‘:’,“:”,；:。,，:。]]
