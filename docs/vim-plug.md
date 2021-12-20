## Usage

<https://github.com/junegunn/vim-plug>
<https://github.com/junegunn/vim-plug/wiki/api>

*commands*

 --------------------------------------------------------------------------------------------------------
 Command                              | Description
 --------------------------------------------------------------------------------------------------------
  `PlugInstall [name ...] [#threads]` | Install plugins
  `PlugUpdate [name ...] [#threads]`  | Install or update plugins
  `PlugClean[!]`                      | Remove unlisted plugins (bang version will clean without prompt)
  `PlugUpgrade`                       | Upgrade vim-plug itself
  `PlugStatus`                        | Check the status of plugins
  `PlugDiff`                          | Examine changes from the previous update and the pending changes
  `PlugSnapshot[!] [output path]`     | Generate script for restoring the current snapshot of the plugins
 --------------------------------------------------------------------------------------------------------

 *options*

 ------------------------------------------------------------------------
 Option                       | Description
 ------------------------------------------------------------------------
  `branch` / `tag` / `commit` | Branch/tag/commit of the repository to use
  `rtp`                       | Subdirectory that contains Vim plugin
  `dir`                       | Custom directory for the plugin
  `as`                        | Use different name for the plugin
  `do`                        | Post-update hook (string or funcref)
  `on`                        | On-demand loading: Commands or <Plug>-mappings
  `for`                       | On-demand loading: File types
  `frozen`                    | Do not update unless explicitly specified
 ------------------------------------------------------------------------

 *global-options*

 --------------------------------------------------------------------------------------------------------------------------------------------
 Flag                 | Default                           | Description
 --------------------------------------------------------------------------------------------------------------------------------------------
  `g:plug_threads`    | 16                                | Default number of threads to use
  `g:plug_timeout`    | 60                                | Time limit of each task in seconds (Ruby & Python)
  `g:plug_retries`    | 2                                 | Number of retries in case of timeout (Ruby & Python)
  `g:plug_shallow`    | 1                                 | Use shallow clone
  `g:plug_window`     | `vertical topleft new`            | Command to open plug window
  `g:plug_pwindow`    | `above 12new`                     | Command to open preview window in  `PlugDiff`
  `g:plug_url_format` | `https://git::@github.com/%s.git` | `printf` format to build repo URL (Only applies to the subsequent `Plug` commands)
 -------------------------------------------------------------------------------------------------------------------------------------------- 

*keybindings*

 - `D` - `PlugDiff`
 - `S` - `PlugStatus`
 - `R` - Retry failed update or installation tasks
 - `U` - Update plugins in the selected range
 - `q` - Close the window
 - `:PlugStatus`
   - `L` - Load plugin
 - `:PlugDiff`
   - `X` - Revert the update

*on-demand-loading*

```vim
" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Multiple commands
Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }
" Loaded when clojure file is opened
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Multiple file types
Plug 'kovisoft/paredit', { 'for': ['clojure', 'scheme'] }
" On-demand loading on both conditions
Plug 'junegunn/vader.vim',  { 'on': 'Vader', 'for': 'vader' }
" Code to execute when the plugin is lazily loaded on demand
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
autocmd! User goyo.vim echom 'Goyo is now loaded!'
```

## Tips

<https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation>

Install plugins on the command line

```sh
# vim
vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"

# neovim
nvim -es -u init.vim -i NONE -c "PlugInstall" -c "qa"
```

Conditional activation

```vim
" Not good
Plug 'benekastah/neomake', has('nvim') ? {} : { 'on': [] }

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Looks better
Plug 'benekastah/neomake', Cond(has('nvim'))

" With other options
Plug 'benekastah/neomake', Cond(has('nvim'), { 'on': 'Neomake' })
```

Loading plugins manually

```viml
" Load on nothing
Plug 'SirVer/ultisnips', { 'on': [] }
Plug 'Valloric/YouCompleteMe', { 'on': [] }

augroup load_us_ycm
  autocmd!
  autocmd InsertEnter * call plug#load('ultisnips', 'YouCompleteMe')
                     \| autocmd! load_us_ycm
augroup END
```

Packer compiled example

```viml
augroup packer_load_aucmds
au!
" Filetype lazy-loads
au FileType qf ++once lua require("packer.load")({'nvim-bqf'}, { ft = "qf" }, _G.packer_plugins)
" Event lazy-loads
au CursorMoved * ++once lua require("packer.load")({'vim-wordmotion', 'vim-matchup'}, { event = "CursorMoved *" }, _G.packer_plugins)
au BufReadPre * ++once lua require("packer.load")({'persistence.nvim', 'indent-blankline.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)
augroup END
```

## FAQ

<https://github.com/junegunn/vim-plug/wiki/faq>

Managing dependencies

- Ordering of plugins only matters when overriding an earlier plugin's commands or mappings, so putting the dependency next to the plugin that depends on it or next to other plugins' dependencies are both okay.
- In the rare case where plugins do overwrite commands or mappings, vim-plug requires you to manually reorder your plugins.

```vim
" Vim script allows you to write multiple statements in a row using `|` separators
" But it's just a stylistic convention. If dependent plugins are written in a single line,
" it's easier to delete or comment out the line when you no longer need them.
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'do': './install --all' } | Plug 'junegunn/fzf.vim'

" Using manual indentation to express dependency
Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'
  Plug 'whatyouhide/vim-textobj-xmlattr'
  Plug 'reedes/vim-textobj-sentence'
```

<https://github.com/junegunn/vim-plug/commit/8a44109329757e29c4956162e3353df367ecdb71>

- Fix Windows support for Unix shells and powershell

```log
Excerpt from `:h shell-powershell`:

  To use powershell (on Windows):

    set shell=powershell shellquote=( shellpipe=\| shellxquote=
    set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
    set shellredir=\|\ Out-File\ -Encoding\ UTF8
```
