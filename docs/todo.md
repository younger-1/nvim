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
- [ ] a more powerful <C-g>
  - pwd, filepath
  - statusline info
  - a quick-pannel to lookup git/file information (e.g. branch, ff, fenc, sw) which is not very common like changes and diagnostics
- [ ] split diagnostics and lsp, lazy load lsp setup to filetype(not good for lvim) or event, lazy load lsp_line after diagnostics
- [x] toggle transparence of colorscheme
- [ ] with prefix(XY), autocmd/manually generate vim-commands for all functions of rr('young.tool') and mod's function
- [ ] vscode-like highlight selected text, without put it to search history
- [ ] diffview: allow use other diff tool (e.g. delta, difftastic)
- [ ] undo: jump to location, display diff, then undo
- [ ] lsp/diagnostics: diagnostics are updated on as soon as InsertLeave happens. Defer it for 1 second
- [ ] setlocal winbar: can't disable window-local winbar, but can enable window-local winbar
- [ ] Telescope git_branches: can not show worktree correctly
- [ ] Telescope keymaps or other plugin: open files of lua function used in rhs
- [ ] Telescope keymaps: only show <Plug> mappings
- [ ] Telescope commands: only show buf local commands
- [ ] Telescope: break dot-repeat
- [ ] Telescope live_grep: use glob_pattern, type_filter, search_dirs
- [ ] yanky (upstream): allow different notify
- [ ] yanky (bug): copy `g()` made it to `v:null`
- [ ] quickfixtextfunc: default not show line and column, apply a key to trigger different quickfixtextfunc
- [ ] Comment style: @see
- [ ] young.tool.run_with_option: run something with options, after finishing running, set options to origin value
- [ ] winbar: show file path, remove incline
- [ ] winbar: show markdown headers
- [ ] winbar: info in preview window
- [ ] remove xy.map, hook vim.keymap.set to record debug info
- [ ] reserve legacy code in young.legacy.version module
- [ ] neovim: winbar: 1)echo winheight(0), 2)resize
- [ ] neovim: cursorline: local to buffer, not local to window
- [ ] gcp: comment pasted text
- [ ] gui: [md+hover] image/math viewer, html/link viewer (like vscode's github-issue-preview, enable viewer for url match regex pattern)
- [ ] vim: / to search in message, very useful!
- [ ] Telescope: from child picker go back to parent picker. e.g. Ctrl-f in `Telescope packer` find files in that entry
- [ ] Telescope: live_grep toggle 1.regex or fixed string, 2.match case or not
- [ ] magic `q`: quit all modifiable floating window
- [ ] cmp-cmdline: only load once for `after/plugin/cmp_cmdline.lua`
- [ ] Telescope keymaps: add indicators for expr
- [ ] refine get_def_locations: 1.keymap: maparg with buffer, 2.autocmd: remove para, 3.autocmd: remove repeated entry
- [ ] module: use tap instead of auto-pcall in config
- [ ] hydra: global keymap e.g. <esc> to quit
- [ ] ts-hydra: use extmarks display jumpable location in screen: <https://github.com/ziontee113/whistle-blower/blob/master/lua/whistle-blower/core/virt-jump.lua>
- [ ] open hex file toooooooooooooooooooooo slow
- [ ] autocmd: relative number only in visual mode
- [ ] vim function: 1.telescope: <leader>svf, 2.get_def_locations
- [ ] neo-tree: 1.<leader>sg and <leader>sf and follow symlink's real path, 2.display symlink path, 3.show hidden files, 4.display icon for empty folders, 5.display long path
- [ ] nvim-tree: 1.dim hidden files
- [ ] lazy.nvim: let `init` to execute after startup, otherwise `init` code would be overrided by `./plugin` code
- [ ] project specific `oldfiles` (default files that Vim remembers is 100)
- [ ] improve workflow: latest line commit, file commit
- [ ] Telescope git_commits: show time in result panel
- [ ] put all hunks of current commit to quickfix
- [ ] Telescope project: remove <C-w> mapping
- [ ] cfg: move autocmd and key to plugin/, record startup time, and think how to reload them

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

`packer.nvim`

Defer packer made the following unusable

```
nvim --headless +'PackerUpdate' +q
nvim --headless +'PackerCompile' +q
```

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
- press ? in tree, cause error:

```
E5108: Error executing lua: ...packer/opt/nvim-tree.lua/lua/nvim-tree/renderer/help.lua:14: attempt to index local 'cb' (a function value)
stack traceback:
        ...packer/opt/nvim-tree.lua/lua/nvim-tree/renderer/help.lua:14: in function 'compute_lines'
        ...packer/opt/nvim-tree.lua/lua/nvim-tree/renderer/init.lua:65: in function 'draw'
        ...ree.lua/lua/nvim-tree/actions/tree-modifiers/toggles.lua:25: in function 'help'
        ...ker/opt/nvim-tree.lua/lua/nvim-tree/actions/dispatch.lua:54: in function 'handle_action_on_help_ui'
        ...ker/opt/nvim-tree.lua/lua/nvim-tree/actions/dispatch.lua:116: in function 'dispatch'
        .../packer/opt/nvim-tree.lua/lua/nvim-tree/actions/init.lua:260: in function <.../packer/opt/nvim-tree.lua/lua/nvim-tree/actions/init.lua:259>

Error executing Lua callback: ...packer/opt/nvim-tree.lua/lua/nvim-tree/renderer/help.lua:14: attempt to index local 'cb' (a function value)
stack traceback:
        ...packer/opt/nvim-tree.lua/lua/nvim-tree/renderer/help.lua:14: in function 'compute_lines'
        ...packer/opt/nvim-tree.lua/lua/nvim-tree/renderer/init.lua:65: in function 'draw'
        ...site/pack/packer/opt/nvim-tree.lua/lua/nvim-tree/lib.lua:80: in function 'open_view_and_draw'
        ...site/pack/packer/opt/nvim-tree.lua/lua/nvim-tree/lib.lua:126: in function 'open'
        ...vim/site/pack/packer/opt/nvim-tree.lua/lua/nvim-tree.lua:95: in function 'open'
        ...vim/site/pack/packer/opt/nvim-tree.lua/lua/nvim-tree.lua:79: in function 'toggle'
        ...vim/site/pack/packer/opt/nvim-tree.lua/lua/nvim-tree.lua:300: in function <...vim/site/pack/packer/opt/nvim-tree.lua/lua/nvim-tree.lua:299>
```

`git-conflict`

- setup(): allow user-defined buffer-mappings

dictionary

```sh
curl -fLo ~/.config/nvim/spell/10k.txt --create-dirs https://github.com/iamcco/coc-zi/raw/master/words/10k.txt
```

`harpoon`

- `toggle_quick_menu` follow cwd
- config to allow manually trigger remember marks (col&line of files), not at every `BufLeave, VimLeave`
- obey col&line when open marks with `nav_file` or `toggle_quick_menu`

```lua
vim.api.nvim_create_autocmd({ "BufLeave, VimLeave" }, {
    callback = function()
        require("harpoon.mark").store_offset()
    end,
})
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
