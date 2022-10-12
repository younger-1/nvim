## TODO

- [ ] `yj.telescope`, `M.tele/M.cfg`, `local cfg`
- [ ] once ice hot done
- [ ] mod: completion, editor, lang, tool, ui
- [ ] hl cursorline
- [x] `xy` <==> require('young')
- [ ] rename: require('xy')
- [ ] vim restore text deleted by C-u or C-w in cmdline
- [ ] vim select files inside current selected folder in cmdline
- [ ] find files when using `Rg`
- [ ] highlights the search word in quickfix when using `Rg`
- [ ] in \*.lua gf on require() can let Telescope find file in that module
- [ ] in \*.lua gF on require() can let LSP try add that rtp to LSP's workspace library
- [x] in \*.lua gf on rr('foo').bar() can be used like require('foo').bar()
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
- [ ] call-tree, no-refenrence-list
- [ ] decouple which-key from core, by using local.lua
- [ ] a quick-pannel to lookup git/file information (e.g. branch, ff, fenc, sw) which is not very common like changes and diagnostics
- [ ] split diagnostics and lsp, lazy load lsp setup to filetype(not good for lvim) or event, lazy load lsp_line after diagnostics
- [x] toggle transparence of colorscheme
- [ ] with prefix(XY), autocmd/manually generate vim-commands for all functions of rr('young.tool') and mod's function
- [ ] vscode-like highlight selected text, without put it to search history
- [ ] diffview: allow use other diff tool (e.g. delta, difftastic)
- [ ] undo: jump to location, display diff, then undo
- [ ] lsp/diagnostics: diagnostics are updated on as soon as InsertLeave happens. Defer it for 1 second
- [ ] Telescope git_branches: can not show worktree correctly
- [ ] Telescope keymaps or other plugin: open files of lua function used in rhs
- [ ] Telescope keymaps: only show <Plug> mappings
- [ ] Telescope commands: only show buf local commands

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

dictionary

```sh
curl -fLo ~/.config/nvim/spell/10k.txt --create-dirs https://github.com/iamcco/coc-zi/raw/master/words/10k.txt
```
## Config

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
