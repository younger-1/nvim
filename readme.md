# Neovim

> My love, you're the unsolved wave, I'm the naked island.

## TODO

- [ ] `yj.telescope`, `M.tele/M.cfg`, `local cfg`
- [ ] once ice hot done
- [ ] hl cursorline
- [ ] `yo` <==> require('young')

## Problem

`project.nvim` 

- echo twice even in the same cwd when open new buffer
- echo once in the same cwd when switch buffers

`fzf.lua`

- Windows support

`surround`

- Normal: ys
- Visual: S 
- Operator: ds, cs, 

`lightspeed`

- Operator-pending mode is invoked with z/Z
- defaults, mapping to the following keys: `s, S` (Normal and Visual mode), `z, Z, x, X` (Operator-pending mode), and `f, F, t, T` (all modes).

`alpha`

- <https://wiki.archlinux.org/title/ASCII_art>
- <https://www.asciiart.eu/> 
- <https://github.com/pi314/ascii-arts>

## Features

### Lua IDE

<https://github.com/sumneko/lua-language-server/wiki/Setting>

Note:
`.luarc.json` will override the whole settings of `lspconfig`

### Keymappings

Currently used:

1. vanilla vim style
2. LunarVim style
3. lua api and its thin wrapper
4. [which-key](https://github.com/folke/which-key.nvim/)

May be useful:

- <https://github.com/tjdevries/astronauta.nvim>
- <https://github.com/b0o/mapx.nvim>
- <https://github.com/svermeulen/vimpeccable>
- <https://github.com/LionC/nest.nvim>

### GUI support

`init.lua`

- [x]  [nvui](https://github.com/rohit-px2/nvui)
- [ ]  [goneovim](https://github.com/akiyosi/goneovim)
- [ ]  [uivonim](https://github.com/smolck/uivonim)
- [ ]  [nvy](https://github.com/RMichelsen/Nvy)
- [ ]  [firenvim](https://github.com/glacambre/firenvim)

`ginit.vim`

- [x]  [neovide](https://github.com/neovide/neovide)
- [x]  [fvim](https://github.com/yatli/fvim)
- [x]  [neovim-qt](https://github.com/equalsraf/neovim-qt)
- [ ]  [neovim-gtk](https://github.com/daa84/neovim-gtk)
- [ ]  [vimr](https://github.com/qvacua/vimr)

## Structure

```
 nvim
└──  lua
   └──  young
      ├──  cfg
      │  ├──  autocmds.lua
      │  ├──  global.lua
      │  ├──  init.lua
      │  └──  option.lua
      ├──  gui
      │  ├──  font.lua
      │  ├──  fvim.lua
      │  ├──  goneovim.lua
      │  ├──  init.lua
      │  ├──  map.lua
      │  ├──  neovide.lua
      │  ├──  nvim-qt.lua
      │  ├──  nvui.lua
      │  └──  transparency.lua
      ├──  key
      │  ├──  init.lua
      │  ├──  leader-normal.lua
      │  ├──  leader-visual.lua
      │  ├──  mappings.lua
      │  ├──  normal.lua
      │  └──  which-key.lua
      ├──  mod
      │  ├──  telescope
      │  │  ├──  finder.lua
      │  │  ├──  init.lua
      │  │  └──  view.lua
      │  ├──  autopairs.lua
      │  ├──  barbar.lua
      │  ├──  bufferline.lua
      │  ├──  cmp.lua
      │  ├──  comment.lua
      │  ├──  filetype.lua
      │  ├──  gitsigns.lua
      │  ├──  indent-blankline.lua
      │  ├──  nvim-tree.lua
      │  ├──  project.lua
      │  ├──  tabline.lua
      │  ├──  toggleterm.lua
      │  └──  trouble.lua
      ├──  tools
      │  ├──  blame.lua
      │  ├──  demo.lua
      │  ├──  init.lua
      │  └──  setup.lua
      ├──  utils
      │  ├──  global.lua
      │  └──  init.lua
      ├──  lsp.lua
      ├──  packer_compiled.lua
      ├──  plugin-loader.lua
      └──  plugins.lua
```

## Acknowledge

Great thanks to:

<https://github.com//dotfiles/tree/master/nvim>

<https://github.com/LionC/dotfiles/tree/master/nvim>

<https://github.com/mnabila/nvimrc>

<https://github.com/whatsthatsmell/dots/tree/master/public%20dots/vim-nvim>

<https://github.com/max397574/NeovimConfig>

```
 max397574
├──  ftplugin
│  ├──  norg.lua
│  └──  tex.vim
└──  lua
  ├──  colors
  │  ├──  highlights.lua
  │  └──  init.lua
  ├──  configs
  │  ├──  lsp
  │  │  ├──  border.lua
  │  │  ├──  custom.lua
  │  │  ├──  init.lua
  │  │  ├──  kind.lua
  │  │  ├──  on_attach.lua
  │  │  └──  signs.lua
  │  ├──  blankline.lua
  │  ├──  bufferline.lua
  │  ├──  cmp.lua
  │  ├──  gitsigns.lua
  │  ├──  lir.lua
  │  ├──  lualine.lua
  │  ├──  lvim_helper.lua
  │  ├──  neorg.lua
  │  ├──  nvim_autopairs.lua
  │  ├──  nvim_comment.lua
  │  ├──  nvim_tree.lua
  │  ├──  snippets.lua
  │  ├──  specs.lua
  │  ├──  startup_nvim.lua
  │  ├──  telescope.lua
  │  ├──  tex.lua
  │  ├──  theme.lua
  │  ├──  toggleterm.lua
  │  ├──  treesitter.lua
  │  ├──  vmath.lua
  │  ├──  web_devicons.lua
  │  └──  which_key.lua
  ├──  after.lua
  ├──  autocommands.lua
  ├──  mappings.lua
  ├──  options.lua
  ├──  plugins.lua
  └──  utils.lua
```

<https://github.com/dtr2300/nvim>

```
 dtr2300
├──  ftdetect
│  └──  supercollider.lua
├──  ftplugin
│  ├──  fennel.lua
│  ├──  lua.lua
│  ├──  scnvim.lua
│  └──  supercollider.lua
└──  lua
   └──  config
      ├──  gui
      │  ├──  fvim.lua
      │  ├──  goneovim.lua
      │  ├──  init.lua
      │  ├──  neovide.lua
      │  ├──  nvimqt.lua
      │  ├──  nvui.lua
      │  └──  nvy.lua
      ├──  plugins
      │  ├──  alpha.lua
      │  ├──  barbar.lua
      │  ├──  colorizer.lua
      │  ├──  compe.lua
      │  ├──  init.lua
      │  ├──  lsp.lua
      │  ├──  lualine.lua
      │  ├──  notify.lua
      │  ├──  plenary.lua
      │  ├──  scnvim.lua
      │  ├──  sqlite.lua
      │  ├──  telescope.lua
      │  ├──  tree.lua
      │  ├──  treesitter.lua
      │  ├──  webdevicons.lua
      │  ├──  whichkey.lua
      │  └──  zenmode.lua
      ├──  utils
      │  ├──  globals.lua
      │  ├──  map.lua
      │  └──  terminal.lua
      ├──  autocmd.lua
      ├──  init.lua
      ├──  mappings.lua
      └──  options.lua
```

<https://github.com/EdenEast/nyx/tree/main/config/.config/nvim>

<https://github.com/RishabhRD/rdconfig/tree/master/.config/nvim>

<https://github.com/tamton-aquib/nvim>

```
  nvim
├──  init.lua
└──   lua
   ├──   general
   │  ├──  autocommands.lua
   │  ├──  mappings.lua
   │  ├──  packer.lua
   │  ├──  startup.lua
   │  └──  settings.lua
   ├──   custom
   │  ├──  noice_dark.lua
   │  ├──  noice_sus.lua
   │  └──  noice_board.lua
   ├──   lsp
   │  ├──  cmp.lua
   │  └──  lsps.lua
   ├──   plugins
   │  ├──  floaterm.lua
   │  ├──  nvim_tree.lua
   │  ├──  neorg.lua
   │  ├──  snippets.lua
   │  ├──  telescope.lua
   │  └──  treesittter.lua
   └──   ui
      ├──  colorschemes.lua
      ├──  dashboard.lua
      ├──  plug-colorizer.lua
      ├──  web_devicons.lua
      └──  staline.lua
```

<https://github.com/nanozuki/CrowsEnv/tree/master/dots/nvim>

<https://github.com/williamboman/nvim-config>

```
 ./
├──  after/
│  └──  plugin/
│     └──  sleuth.vim
├──  ftdetect/
│  └──  mine.vim
├──  ftplugin/
│  ├──  gitcommit.vim
│  ├──  gitmessengerpopup.vim
│  ├──  help.vim
│  └──  lsp-installer.vim
├──  lua/
│  └──  wb/
│     ├──  coq_3p/
│     │  └──  uuid.lua
│     ├──  coq_nvim/
│     │  └──  init.lua
│     ├──  formatter/
│     │  └──  init.lua
│     ├──  gitsigns/
│     │  └──  init.lua
│     ├──  lsp/
│     │  ├──  capabilities.lua
│     │  ├──  custom-server.lua
│     │  ├──  diagnostics.lua
│     │  ├──  handlers.lua
│     │  ├──  init.lua
│     │  └──  keymaps.lua
│     ├──  lualine/
│     │  └──  init.lua
│     ├──  nvim-autopairs/
│     │  └──  init.lua
│     ├──  nvim-colorizer/
│     │  └──  init.lua
│     ├──  nvim-tree/
│     │  └──  init.lua
│     ├──  nvim-treesitter/
│     │  └──  init.lua
│     ├──  telescope/
│     │  ├──  find_files.lua
│     │  ├──  git.lua
│     │  ├──  init.lua
│     │  └──  lsp.lua
│     ├──  vim-test/
│     │  └──  init.lua
│     ├──  plugins.lua
│     └──  settings.lua
├──  plugin/
│  ├──  buffers.vim
│  ├──  colors.vim
│  ├──  keymaps.vim
│  ├──  python.vim
│  ├──  tabline.vim
│  └──  vimspector.vim
└──  init.lua
```

<https://github.com/n3wborn/nvim>

```
 ./
├──  lua/
│  ├──  modules/
│  │  ├──  core/
│  │  │  ├──  autocommands.lua
│  │  │  ├──  colorscheme.lua
│  │  │  ├──  init.lua
│  │  │  ├──  mappings.lua
│  │  │  └──  statusline.lua
│  │  ├──  lsp/
│  │  │  ├──  init.lua
│  │  │  ├──  null-ls.lua
│  │  │  └──  tsserver.lua
│  │  └──  plugins/
│  │     ├──  blankline.lua
│  │     ├──  cmp.lua
│  │     ├──  colorizer.lua
│  │     ├──  formatter.lua
│  │     ├──  gitsigns.lua
│  │     ├──  init.lua
│  │     ├──  nvimtree.lua
│  │     ├──  packer.lua
│  │     ├──  telescope.lua
│  │     ├──  treesitter.lua
│  │     └──  trouble.lua
│  └──  utils.lua
└──  init.lua
```

<https://github.com/LunarVim/Neovim-from-scratch>

