-- TODO: fd "mini.*.lua"

local on_windows = vim.loop.os_uname().version:match 'Windows'

local function join_paths(...)
  local path_sep = on_windows and '\\' or '/'
  return table.concat({ ... }, path_sep)
end

vim.cmd [[set runtimepath=$VIMRUNTIME]]

local temp_dir = vim.loop.os_getenv 'TEMP' or '/tmp'

vim.cmd('set packpath=' .. join_paths(temp_dir, 'nvim', 'site'))

local package_root = join_paths(temp_dir, 'nvim', 'site', 'pack')
local install_path = join_paths(package_root, 'packer', 'start', 'packer.nvim')
local compile_path = join_paths(install_path, 'plugin', 'packer_compiled.lua')

local function load_plugins()
  require('packer').startup {
    {
      'wbthomason/packer.nvim',
      'neovim/nvim-lspconfig',
    },
    config = {
      package_root = package_root,
      compile_path = compile_path,
    },
  }
end

_G.load_config = function()
  vim.lsp.set_log_level 'trace'
  if vim.fn.has 'nvim-0.5.1' == 1 then
    require('vim.lsp.log').set_format_func(vim.inspect)
  end
  local nvim_lsp = require 'lspconfig'
  local on_attach = function(_, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>ld', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>lq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  end

  -- Add the server that troubles you here
  local name = 'pyright'
  local cmd = { 'pyright-langserver', '--stdio' } -- needed for elixirls, omnisharp, sumneko_lua
  if not name then
    print 'You have not defined a server name, please edit minimal_init.lua'
  end
  if not nvim_lsp[name].document_config.default_config.cmd and not cmd then
    print [[You have not defined a server default cmd for a server
      that requires it please edit minimal_init.lua]]
  end

  nvim_lsp[name].setup {
    cmd = cmd,
    on_attach = on_attach,
  }

  print [[You can find your log at $HOME/.cache/nvim/lsp.log.]]
end

if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
  load_plugins()
  require('packer').sync()
  vim.cmd [[autocmd User PackerComplete ++once lua load_config()]]
else
  load_plugins()
  -- require('packer').sync()
  _G.load_config()
end

-- Options
local default_options = {
  backup = false,
  clipboard = '',
  cmdheight = 1,
  completeopt = { 'menuone', 'noselect' },
  conceallevel = 0,
  fileencoding = 'utf-8',
  -- foldmethod = 'expr', -- folding, set to "expr" for treesitter based folding
  -- foldexpr = 'nvim_treesitter#foldexpr()', -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
  hidden = true,
  inccommand = 'split',
  hlsearch = true,
  ignorecase = true,
  mouse = '',
  pumheight = 20,
  showmode = true,
  showtabline = 2,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  -- termguicolors = true,
  timeoutlen = 300,
  title = true,
  -- undodir = join_paths(vim.fn.stdpath "cache", "undo"),
  undofile = true,
  updatetime = 300,
  writebackup = false,
  tabstop = 8,
  expandtab = true,
  softtabstop = 2,
  shiftwidth = 2,
  smarttab = true,
  number = true,
  relativenumber = false,
  -- cursorline = true,
  numberwidth = 4,
  -- signcolumn = 'yes',
  wrap = false,
  spell = false,
  spelllang = 'en',
  scrolloff = 3,
  sidescrolloff = 8,
  confirm = true,
  showbreak = '↪',
  fileencodings = { 'ucs-bom', 'utf-8', 'utf-16', 'gbk', 'big5', 'gb18030', 'latin1' },
  fileformats = { 'unix', 'dos', 'mac' },
  synmaxcol = 400,
  list = true,
}

for k, v in pairs(default_options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append 'c'
vim.cmd 'set whichwrap+=<,>,[,],h,l'
vim.opt.listchars = {
  tab = '●·',
  extends = '→',
  precedes = '←',
  trail = '■',
  nbsp = '␣',
}

-- Mappings
vim.g.mapleader = ' '
local function nmap(key, cmd, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.api.nvim_set_keymap('n', key, cmd, opts)
end

nmap('<leader>q', ':q<CR>')
nmap('<leader>w', ':w<CR>')
nmap('<leader>c', ':bdel<CR>')

nmap('<leader>li', ':LspInfo<CR>')

nmap('<leader>pc', ':PackerCompile<CR>')
nmap('<leader>ps', ':PackerStatus<CR>')
nmap('<leader>pu', ':PackerUpdate<CR>')
nmap('<leader>pk', ':PackerClean<CR>')
nmap('<leader>pi', ':PackerInstall<CR>')

nmap('H', ':bp<CR>')
nmap('L', ':bn<CR>')
nmap('M', ':1messages<CR>')
nmap('<CR>', ':')
nmap('<BS>', '<C-^>')
nmap('<ESC>', '<cmd>nohl<CR>')
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')
nmap(']q', ':cnext<CR>')
nmap(']q', ':cprev<CR>')
nmap('<C-q>', ':call QuickFixToggle()<CR>')
nmap(']e', ':cnext<CR>')
nmap(']e', ':cprev<CR>')
nmap('<C-e>', ':call LocListToggle()<CR>')

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction

  function! LocListToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      silent! lopen
    else
      lclose
    endif
  endfunction
]]

-- Autocmds
-- The key will be the name of the group, and each definition
-- within the group should have:
--    1. Trigger
--    2. Pattern
--    3. Text
local define_augroups = function(definitions)
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

define_augroups {
  _general_settings = {
    { 'TextYankPost', '*', "lua vim.highlight.on_yank({ higroup = 'Search', timeout = 600 })" },
  },
  _filetype = {
    { 'FileType', 'qf,help,man', 'nnoremap <silent> <buffer> q :close<CR>' },
    { 'FileType', 'lspinfo,lsp-installer,null-ls-info', 'nnoremap <silent> <buffer> q :close<CR>' },
  },
}
