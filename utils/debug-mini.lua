-- TODO: fd "mini.*.lua"

-- Options
-- local default_options = {
--   backup = false,
--   clipboard = '',
--   cmdheight = 1,
--   completeopt = { 'menuone', 'noselect' },
--   conceallevel = 0,
--   fileencoding = 'utf-8',
--   -- foldmethod = 'expr', -- folding, set to "expr" for treesitter based folding
--   -- foldexpr = 'nvim_treesitter#foldexpr()', -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
--   hidden = true,
--   inccommand = 'split',
--   hlsearch = true,
--   ignorecase = true,
--   mouse = '',
--   pumheight = 20,
--   showmode = true,
--   showtabline = 2,
--   smartcase = true,
--   smartindent = true,
--   splitbelow = true,
--   splitright = true,
--   swapfile = false,
--   -- termguicolors = true,
--   timeoutlen = 300,
--   title = true,
--   -- undodir = join_paths(vim.fn.stdpath "cache", "undo"),
--   undofile = true,
--   updatetime = 300,
--   writebackup = false,
--   tabstop = 8,
--   expandtab = true,
--   softtabstop = 2,
--   shiftwidth = 2,
--   smarttab = true,
--   number = true,
--   relativenumber = false,
--   -- cursorline = true,
--   numberwidth = 4,
--   -- signcolumn = 'yes',
--   wrap = false,
--   spell = false,
--   spelllang = 'en',
--   scrolloff = 3,
--   sidescrolloff = 8,
--   confirm = true,
--   showbreak = '↪',
--   fileencodings = { 'ucs-bom', 'utf-8', 'utf-16', 'gbk', 'big5', 'gb18030', 'latin1' },
--   fileformats = { 'unix', 'dos', 'mac' },
--   synmaxcol = 400,
--   list = true,
-- }

-- for k, v in pairs(default_options) do
--   vim.opt[k] = v
-- end

-- vim.opt.shortmess:append 'c'
-- vim.cmd 'set whichwrap+=<,>,[,],h,l'
-- vim.opt.listchars = {
--   tab = '●·',
--   extends = '→',
--   precedes = '←',
--   trail = '■',
--   nbsp = '␣',
-- }

-- -- Mappings
vim.g.mapleader = ' '
local function nmap(key, cmd, opts)
  opts = vim.tbl_extend('force', { noremap = true, nowait = true }, opts or {})
  vim.api.nvim_set_keymap('n', key, cmd, opts)
end

nmap('<leader>q', ':q<CR>')
nmap('<leader>w', ':w<CR>')

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
nmap(']a', ':cnext<CR>')
nmap(']a', ':cprev<CR>')
nmap('<C-l>', ':call LocListToggle()<CR>')

nmap('<leader>pp', ':Lazy<CR>')
-- nmap('<leader>pc', ':PackerCompile<CR>')
-- nmap('<leader>ps', ':PackerStatus<CR>')
-- nmap('<leader>pu', ':PackerUpdate<CR>')
-- nmap('<leader>pk', ':PackerClean<CR>')
-- nmap('<leader>pi', ':PackerInstall<CR>')

nmap('<leader>li', ':LspInfo<CR>')
nmap('<leader>ll', ':exe "e " .. v:lua.vim.lsp.get_log_path()<CR>')

-- vim.cmd [[
-- function! QuickFixToggle()
--   lclose
--   if empty(filter(getwininfo(), 'v:val.quickfix'))
--     copen
--   else
--     cclose
--   endif
-- endfunction

-- function! LocListToggle()
--   cclose
--   if empty(filter(getwininfo(), 'v:val.loclist'))
--     silent! lopen
--   else
--     lclose
--   endif
-- endfunction
-- ]]

-- -- Autocmds
-- -- The key will be the name of the group, and each definition
-- -- within the group should have:
-- --    1. Trigger
-- --    2. Pattern
-- --    3. Text
-- local define_augroups = function(definitions)
--   for group_name, definition in pairs(definitions) do
--     vim.cmd('augroup ' .. group_name)
--     vim.cmd 'autocmd!'
--     for _, def in pairs(definition) do
--       local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
--       vim.cmd(command)
--     end
--     vim.cmd 'augroup END'
--   end
-- end

-- define_augroups {
--   _general_settings = {
--     { 'TextYankPost', '*', "lua vim.highlight.on_yank({ higroup = 'Search', timeout = 600 })" },
--   },
--   _filetype = {
--     { 'FileType', 'qf,help,man',                        'nnoremap <buffer> q <Cmd>close<CR>' },
--     { 'FileType', 'lspinfo,lsp-installer,null-ls-info', 'nnoremap <buffer> q <Cmd>close<CR>' },
--   },
-- }

require 'young'
require('young.cfg').done()

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup({
  {
    'neoclide/coc.nvim',
    branch = 'release',
  },
  {
    'rebelot/kanagawa.nvim',
    event = 'VeryLazy',
    config = function()
      vim.cmd [[
      silent! colorscheme kanagawa
      ]]
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('young.mod.telescope').done()
    end,
  },
  -- "folke/neodev.nvim",
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('young.mod.which_key').done()
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    config = function()
      require('young.mod.gitsigns').done()
    end,
  },
  {
    'numToStr/Comment.nvim',
    keys = { { 'gc', mode = { 'n', 'x' } } },
    config = function()
      require 'young.mod.comment'
    end,
  },
}, {
  ui = {
    custom_keys = {
      ['<localleader>d'] = function(plugin)
        require('young.util').dd(plugin)
      end,
    },
  },
})
