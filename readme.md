# NeoVim

> My love, you're the unsolved wave, I'm the naked island.

## TODO

- [ ] `yj.telescope`, `M.tele/M.cfg`, `local cfg`
- [ ] once ice hot done
- [ ] mod: completion, editor, lang, tool, ui
- [ ] hl cursorline
- [ ] `yo` <==> require('young')
- [ ] vim restore text deleted by C-u or C-w in cmdline
- [ ] vim select files inside current selected folder in cmdline
- [ ] find files when using `Rg`
- [ ] highlights the search word in quickfix when using `Rg`
- [ ] in *.lua gf on require() can let Telescope find file in that module
- [ ] in *.lua gF on require() can let LSP try add that rtp to LSP's workspace library
- [ ] in *.lua gf on rr('foo').bar() can be used like require('foo').bar()
- [ ] combine range-highlight and numb to a single plugin
- [ ] Online community collect @cataloge and #tag metadata of plugin to help easily discover functionality/boundary of plugins
- [ ] cd to current buffer's dir which can toggle cd back, nvim-tree-keymap to cd buffer's dir
- [ ] `Telescope theme` only list installed themes, see <https://github.com/NvChad/extensions/tree/main/lua/telescope/_extensions>
- [ ] `Telescope terminal` list terminals
- [ ] `telescope-packer` provide function to open url/commit of repo, fix for windows
- [x] `gitsigns` blame_line or preview_hunk, allow pick window or set cursor
- [ ] local/machine/per-user settings, eg. colorscheme, background, font and even modules of plugins like M.lang('lisp', 'java')
- [ ] enable syntax and keybind for filetype of `packer`, just like buffer used by `PackerUpdate`
- [ ] config for lspkind-nvim
- [x] vim/nvim can't open `packer_compiled.lua` normally, but vscode can.
- [ ] nvim-tree: refine `search_node` to match fuzzy not exactly
- [x] add a wrapper for which-key and using in : LSP keymappings
- [ ] null-ls use notify to avoid [ERROR 10:23:50] ...t/null-ls.nvim/lua/null-ls/helpers/gener...d flake8 is not executable (make sure it's installed and on your $PATH)
- [ ] highlight for cmdline-history window
- [ ] an easy way to edit $VIMRUNTIME files, `:e $VIMRUNTIME/ftplugin.vim`
- [ ] highlight the put region with autocmd like `vim.highlight.on_yank` - see <https://www.reddit.com/r/neovim/comments/vh5p42/how_to_highlight_the_put_region_with_autocmd_like/> and <https://github.com/neovim/neovim/blob/f479dd0bbef9383df05b1908eec0013ba92499b5/runtime/lua/vim/highlight.lua#L83>
- [ ] autopair: remove single quote (' and `) rules for lisp file
- [ ] decouple which-key from core, by using local.lua

```
map("n", term_maps.new_horizontal, ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>")
map("n", term_maps.new_vertical, ":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>")
map("n", term_maps.new_window, ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>")
```

```
insert_nav = {
  backward = "<C-h>",
  forward = "<C-l>",
  next_line = "<C-k>",
  prev_line = "<C-j>",
},
```

## Problem

`project.nvim`

- ~~echo twice even in the same cwd when open new buffer~~
- ~~echo once in the same cwd when switch buffers~~
- use lcd instead of `nvim_set_current_dir`
- notify only once when enter the same directory repeatedly

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

`nvim-tree`

- renamed-icon do not appear in the renamed-file

`git-conflict`

- setup(): allow user-defined buffer-mappings

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

|       Function        |  Mapping  |
|         :---:         |   :---:   |
|  Toggle full screen   | `<A-CR>`  |
|  Increase font size   |  `<C-+>`  |
|  Decrease font size   |  `<C-->`  |
|      Change font      | `<C-BS>`  |
|     Default font      |  `<C-0>`  |
| Increase transparency |  `<A-+>`  |
| Decrease transparency |  `<A-->`  |
|     Change effect     | `<A-BS>`  |
|    Toggle ligature    | `<A-DEL>` |

## Performance

❯ hyperfine --min-runs=20 "nvim +qa" "nvim --headless +qa"

Benchmark 1: nvim +qa
  Time (mean ± σ):     266.7 ms ±  15.4 ms    [User: 121.3 ms, System: 55.7 ms]
  Range (min … max):   244.1 ms … 293.0 ms    20 runs

Benchmark 2: nvim --headless +qa
  Time (mean ± σ):     222.3 ms ±  13.4 ms    [User: 114.1 ms, System: 48.3 ms]
  Range (min … max):   198.1 ms … 252.9 ms    20 runs

```sh
# get latest remote commit of plugins
nvim --headless -c 'luafile ./utils/generate_new_lockfile.lua'
```

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
      ├──  tool
      │  ├──  blame.lua
      │  ├──  demo.lua
      │  ├──  init.lua
      │  └──  setup.lua
      ├──  util
      │  ├──  global.lua
      │  └──  init.lua
      ├──  lsp.lua
      ├──  packer_compiled.lua
      ├──  packer.lua
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

<https://github.com/TarunDaCoder/DaNvim>


```
-- <https://github.com/rbtnn/vim-gloaded>

let g:loaded_gloaded = 1

let g:loaded_2html_plugin      = 1 "$VIMRUNTIME/plugin/tohtml.vim
let g:loaded_getscript         = 1 "$VIMRUNTIME/autoload/getscript.vim
let g:loaded_getscriptPlugin   = 1 "$VIMRUNTIME/plugin/getscriptPlugin.vim
let g:loaded_gzip              = 1 "$VIMRUNTIME/plugin/gzip.vim
let g:loaded_logipat           = 1 "$VIMRUNTIME/plugin/logiPat.vim
let g:loaded_logiPat           = 1 "$VIMRUNTIME/plugin/logiPat.vim
let g:loaded_matchparen        = 1 "$VIMRUNTIME/plugin/matchparen.vim
let g:loaded_netrw             = 1 "$VIMRUNTIME/autoload/netrw.vim
let g:loaded_netrwFileHandlers = 1 "$VIMRUNTIME/autoload/netrwFileHandlers.vim
let g:loaded_netrwPlugin       = 1 "$VIMRUNTIME/plugin/netrwPlugin.vim
let g:loaded_netrwSettings     = 1 "$VIMRUNTIME/autoload/netrwSettings.vim
let g:loaded_rrhelper          = 1 "$VIMRUNTIME/plugin/rrhelper.vim
let g:loaded_spellfile_plugin  = 1 "$VIMRUNTIME/plugin/spellfile.vim
let g:loaded_sql_completion    = 1 "$VIMRUNTIME/autoload/sqlcomplete.vim
let g:loaded_syntax_completion = 1 "$VIMRUNTIME/autoload/syntaxcomplete.vim
let g:loaded_tar               = 1 "$VIMRUNTIME/autoload/tar.vim
let g:loaded_tarPlugin         = 1 "$VIMRUNTIME/plugin/tarPlugin.vim
let g:loaded_vimball           = 1 "$VIMRUNTIME/autoload/vimball.vim
let g:loaded_vimballPlugin     = 1 "$VIMRUNTIME/plugin/vimballPlugin.vim
let g:loaded_zip               = 1 "$VIMRUNTIME/autoload/zip.vim
let g:loaded_zipPlugin         = 1 "$VIMRUNTIME/plugin/zipPlugin.vim
let g:vimsyn_embed             = 1 "$VIMRUNTIME/syntax/vim.vim
```
