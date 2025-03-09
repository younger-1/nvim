-- <https://github.com/maxxnino/lvim/blob/main/lua/user/neovim.lua>
-- <https://github.com/n3wborn/nvim/blob/main/init.lua>
-- <https://github.com/rafamadriz/dotfiles/blob/c285f6e592850565d579350486271173e2795f80/private_dot_config/nvim/lua/settings.lua>

local default_options = {
  clipboard = '',

  mouse = 'nvi',

  confirm = true, -- show confirm dialog instead of error msg

  timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  updatetime = 200, -- faster completion

  autoindent = true,
  smartindent = true,

  expandtab = true,
  tabstop = 8, -- insert 8 spaces for a tab
  softtabstop = 0,
  shiftwidth = 0,
  smarttab = true,

  wrap = false,
  linebreak = true,

  breakindent = true,
  -- breakindentopt = { 'sbr' },
  showbreak = '↪ ',

  conceallevel = 2, -- Hide * markup for bold and italic, but not markers with substitutions

  swapfile = false, -- creates a swapfile

  undofile = true, -- enable persistent undo

  showtabline = 2, -- always show tabs
  laststatus = 3, -- global statusline

  cmdheight = 1,
  showcmd = true, -- show (partial) normal-mode command or visaul-mode selected chars
  showmode = false, -- dont show mode since we have a statusline
  ruler = false, -- disable the default ruler

  hlsearch = true,
  incsearch = true,
  inccommand = 'split',

  ignorecase = true,
  smartcase = true,

  fileformats = { 'unix', 'dos', 'mac' },
  fileencoding = 'utf-8', -- the encoding written to a file
  fileencodings = { 'ucs-bom', 'utf-8', 'default', 'latin1', 'utf-16', 'gbk', 'big5', 'gb18030' },

  foldcolumn = 'auto',
  foldmethod = 'expr', -- folding, set to "expr" for treesitter based folding
  -- foldexpr = 'v:lua.vim.treesitter.foldexpr()', -- TODO: treesitter/_fold.lua:get_folds_levels: table overflow
  foldtext = 'v:lua.vim.treesitter.foldtext()',
  -- foldtext = 'yo#fold#Text()',

  -- guifont = is_windows and 'SauceCodePro NF' or 'SauceCodePro Nerd Font',
  guifontwide = { 'Sarasa Term SC' },

  completeopt = { 'menuone', 'noselect' },
  pumwidth = 25, -- pop up menu width
  pumheight = 20, -- pop up menu height
  pumblend = 30, -- transparency for the |popup-menu|

  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window

  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  signcolumn = 'yes:2', -- always show the sign column, otherwise it would shift the text each time

  spell = false,
  spelllang = { 'en', 'cjk' },

  termguicolors = true, -- set term gui colors (most terminals support this)

  title = true, -- set the title of window to the value of the titlestring
  -- titlestring = '%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%) - LunarVim',

  cursorline = true, -- highlight the current line
  colorcolumn = { 80 },

  scrolloff = 10, -- is one of my fav
  sidescrolloff = 8,

  path = '.,,',

  qftf = '{info -> v:lua.require("young.cfg.quickfix").quickfixtextfunc(info)}',
  synmaxcol = 400,
  list = true,
  virtualedit = 'onemore',
  wildignore = {
    '**/node_modules/**',
    '**/coverage/**',
    '**/.idea/**',
    '**/.git/**',
    '**/.nuxt/**',
  },
  -- TODO:
  -- fillchars = 'vert:┃',
  -- fillchars = { -- thicker borders between windows
  --   horiz = '━',
  --   horizup = '┻',
  --   horizdown = '┳',
  --   vert = '┃',
  --   vertleft = '┫',
  --   vertright = '┣',
  --   verthoriz = '╋',
  -- },
  -- fillchars = {
  --   horiz = '█',
  --   horizup = '█',
  --   horizdown = '█',
  --   vert = '█',
  --   vertleft = '█',
  --   vertright = '█',
  --   verthoriz = '█',
  -- },
  -- fillchars = {
  --   horiz = '━',
  --   horizup = '━',
  --   horizdown = '━',
  --   vert = ' ',
  --   vertleft = '━',
  --   vertright = '━',
  --   verthoriz = '━',
  -- },
  -- <https://github.com/santigo-zero/csjneovim/blob/master/user/init.lua>
  fillchars = {
    horiz = '─',
    horizup = '⯊',
    horizdown = '⯋',
    vert = '│',
    -- vert = 'ඞ',
    vertleft = '◖',
    vertright = '◗',
    verthoriz = '●',
    diff = '╱',
    msgsep = '=',
    eob = '~',
  },
}

for k, v in pairs(default_options) do
  vim.opt[k] = v
end

if xy.has 'nvim-0.9' then
  vim.o.splitkeep = 'screen'
end

vim.opt.shortmess:append 'c'

-- disable saving current directory with views
vim.opt.viewoptions:remove 'curdir'

vim.opt.diffopt:append {
  'vertical',
  'indent-heuristic', -- Enable indent-heuristic to make vimdiff more closely match git diff
  'algorithm:patience',
}
if xy.has 'nvim-0.9' then
  vim.opt.diffopt:append 'linematch:60'
end

-- vim.cmd 'set whichwrap+=<,>,[,],h,l'
vim.opt.whichwrap:append '<,>,[,],h,l'

-- vim.opt.iskeyword:append '-'

-- vim.cmd [[set listchars=tab:●·,extends:→,precedes:←,trail:■]]
-- vim.cmd [[set listchars=tab:>-,space:·,eol:↲,trail:~,extends:>,precedes:<,nbsp:+]]
vim.opt.listchars = {
  -- tab = '>- ',
  -- tab = '→  ',
  -- tab = '➜  ',
  -- tab = '●· ',
  -- tab = '•• ',
  -- tab = 'ᐧᐧᐧ',
  -- tab = '»  ',
  -- tab = ' •»',
  -- tab = '  ',
  tab = '  ',
  -- tab = '  ',
  -- tab = '  ',
  -- tab = '  ',
  -- tab = 'ﲒ  ',
  -- tab = 'ﲖ  ',
  -- space = '·',
  -- eol = '⌐',
  -- eol = '',
  eol = '↲',
  -- eol = '﬋',
  -- eol = '﬌',
  -- eol = '↴',
  -- trail = '~',
  trail = '■',
  -- extends = '>',
  -- precedes = '<',
  -- extends = '→',
  -- precedes = '←',
  extends = '»',
  precedes = '«',
  -- extends = '⟩',
  -- precedes = '⟨',
  -- nbsp = '␣',
  nbsp = '⦸',
}

-- 朝闻道，金、木、水、火、土；【真香定律（王境泽）】；《静夜诗（李白）》。
-- 唐僧问道：‘泼猴，若我救你出来，你该如何报答我？’ 悟空：“你若放我出来，我定会送你上西天！”
vim.cmd [[set matchpairs+=<:>,「:」,『:』,【:】,（:）,《:》,‘:’,“:”,；:。,，:。]]

vim.cmd [[command! TagsUpdate !ctags -R .]]
-- vim.cmd [[command! Todo grep TODO]]

-- if vim.fn.exepath 'rg' then
--   vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case --color=never'
--   vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'
-- elseif vim.fn.exepath 'ag' then
--   vim.o.grepprg = 'ag --vimgrep --nogroup --nocolor'
-- else
--   vim.o.grepprg = 'grep --line-number --recursive -I $*'
--   vim.o.grepformat = '%f:%l:%m'
-- end

for _, path in ipairs {
  '..',
  'src',
} do
  vim.opt.path:append(path)
end

for _, path in ipairs {
  '/usr/include',
  '/usr/local/include',
  '/opt/homebrew/include',
  '/usr/local/opt/llvm/include/c++/v1',
  '/Library/Developer/CommandLineTools/usr/include/c++/v1',
  '~/cc',
} do
  if xy.util.is_dir(path) then
    vim.opt.path:append(path)
  end
end

for _, k in ipairs {
  'number',
  'relativenumber',
  'signcolumn',
} do
  xy.opt[k] = vim.o[k]
end
