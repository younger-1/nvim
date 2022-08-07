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
- [ ] in \*.lua gf on require() can let Telescope find file in that module
- [ ] in \*.lua gF on require() can let LSP try add that rtp to LSP's workspace library
- [ ] in \*.lua gf on rr('foo').bar() can be used like require('foo').bar()
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
- [ ] autopair: remove single quote (\' and \`) rules for lisp file
- [ ] decouple which-key from core, by using local.lua
- [ ] a quick-pannel to lookup git/file information such as branch, ff, fenc, sw, which is not very common like changes and diagnostics
- [ ] split diagnostics and lsp, lazy load lsp setup to filetype(not good for lvim) or event, lazy load lsp_line after diagnostics

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
# update to latest commit of pin plugins (xy.packer.pins)
nvim --headless -c 'luafile ./utils/generate_new_lockfile.lua'
```

## Structure

```
 nvim
├──  autoload/
│  └──  yo/
│     ├──  fn.vim
│     ├──  fold.vim
│     └──  redir.vim
├──  ftplugin/
│  ├──  c.vim
│  ├──  gitcommit.vim
│  ├──  help.vim
│  ├──  java.vim
│  ├──  json.vim
│  ├──  kitty.vim
│  ├──  lua.vim
│  ├──  markdown.vim
│  ├──  qf.vim
│  ├──  text.vim
│  ├──  txt.vim
│  └──  vim.vim
└──  lua
   └──  young
│     ├──  autocmd/
│     │  ├──  core.lua
│     │  └──  init.lua
│     ├──  cfg/
│     │  ├──  global.lua
│     │  ├──  init.lua
│     │  ├──  option.lua
│     │  ├──  quickfix.lua
│     │  └──  tabline.lua
│     ├──  gui/
│     │  ├──  firenvim.lua
│     │  ├──  font.lua
│     │  ├──  fvim.lua
│     │  ├──  goneovim.lua
│     │  ├──  init.lua
│     │  ├──  map.lua
│     │  ├──  neovide.lua
│     │  ├──  nvim_qt.lua
│     │  ├──  nvui.lua
│     │  ├──  transparency.lua
│     │  └──  vscode.lua
│     ├──  key/
│     │  ├──  init.lua
│     │  ├──  leader_normal.lua
│     │  ├──  leader_visual.lua
│     │  ├──  normal.lua
│     │  ├──  visual.lua
│     │  └──  which_key.lua
│     ├──  lang/
│     │  ├──  java.lua
│     │  ├──  java_.lua
│     │  └──  python.lua
│     ├──  lsp/
│     │  ├──  null_ls/
│     │  │  └──  linters.lua
│     │  ├──  providers/
│     │  │  ├──  clangd.lua
│     │  │  ├──  jdtls.lua
│     │  │  ├──  jsonls.lua
│     │  │  ├──  pylsp.lua
│     │  │  ├──  pyright.lua
│     │  │  ├──  sumneko_lua.lua
│     │  │  └──  yamlls.lua
│     │  ├──  common.lua
│     │  ├──  config.lua
│     │  ├──  handler.lua
│     │  ├──  init.lua
│     │  ├──  installer.lua
│     │  ├──  misc.lua
│     │  └──  null_ls.lua
│     ├──  mod/
│     │  ├──  alpha/
│     │  │  ├──  init.lua
│     │  │  └──  screen.lua
│     │  ├──  feline/
│     │  │  ├──  init.lua
│     │  │  ├──  nv_ide.lua
│     │  │  └──  nvchad.lua
│     │  ├──  galaxyline/
│     │  │  └──  init.lua
│     │  ├──  lualine/
│     │  │  ├──  theme/
│     │  │  │  └──  vscode.lua
│     │  │  ├──  apl.lua
│     │  │  ├──  bubbles.lua
│     │  │  ├──  evil.lua
│     │  │  ├──  evil_v.lua
│     │  │  ├──  init.lua
│     │  │  └──  slanted.lua
│     │  ├──  telescope/
│     │  │  ├──  actions.lua
│     │  │  ├──  finder.lua
│     │  │  ├──  init.lua
│     │  │  └──  view.lua
│     │  ├──  asterisk.lua
│     │  ├──  autopairs.lua
│     │  ├──  barbar.lua
│     │  ├──  bqf.lua
│     │  ├──  bufferline.lua
│     │  ├──  cinnamon.lua
│     │  ├──  cmp.lua
│     │  ├──  colorizer.lua
│     │  ├──  comment.lua
│     │  ├──  copilot.lua
│     │  ├──  dial.lua
│     │  ├──  easy_align.lua
│     │  ├──  fidget.lua
│     │  ├──  filetype.lua
│     │  ├──  fine_cmd.lua
│     │  ├──  fzf.lua
│     │  ├──  git_conflict.lua
│     │  ├──  gitlinker.lua
│     │  ├──  gitsigns.lua
│     │  ├──  gps.lua
│     │  ├──  hop.lua
│     │  ├──  illuminate.lua
│     │  ├──  indent_blankline.lua
│     │  ├──  jabs.lua
│     │  ├──  lightbulb.lua
│     │  ├──  lightspeed.lua
│     │  ├──  lir.lua
│     │  ├──  lsp_lines.lua
│     │  ├──  lsp_signature.lua
│     │  ├──  matchup.lua
│     │  ├──  minimap.lua
│     │  ├──  neoclip.lua
│     │  ├──  neorg.lua
│     │  ├──  neoscroll.lua
│     │  ├──  notify.lua
│     │  ├──  nvim_tree.lua
│     │  ├──  package_info.lua
│     │  ├──  persistence.lua
│     │  ├──  project.lua
│     │  ├──  rest.lua
│     │  ├──  scrollview.lua
│     │  ├──  searchbox.lua
│     │  ├──  session_manager.lua
│     │  ├──  smart_splits.lua
│     │  ├──  specs.lua
│     │  ├──  spectre.lua
│     │  ├──  tabline.lua
│     │  ├──  todo_comments.lua
│     │  ├──  toggleterm.lua
│     │  ├──  treesitter.lua
│     │  ├──  trouble.lua
│     │  ├──  wilder.lua
│     │  ├──  window_picker.lua
│     │  ├──  yabs.lua
│     │  ├──  zen.lua
│     │  └──  ZFVimIM.lua
│     ├──  tool/
│     │  ├──  blame.lua
│     │  ├──  demo.lua
│     │  ├──  init.lua
│     │  └──  setup.lua
│     ├──  util/
│     │  ├──  init.lua
│     │  └──  jsonify.lua
│     ├──  init.lua
│     ├──  packer.lua
│     ├──  packer_compiled.lua
│     └──  plugins.lua
├──  plugin/
│  ├──  abbr.vim
│  ├──  autocmd.lua
│  ├──  func.vim
│  ├──  helper.vim
│  ├──  mappings.lua
│  └──  vim-ripgrep.vim
```

## Acknowledge

see [reference](utils/reference/reference.md)

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
