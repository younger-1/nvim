> My love, you're the unsolved wave, I'm the naked island.

## Introduction

Feature-rich, beautiful and fast neovim config.

- Aesthetic and beautiful appearance
- Blazing fast startup time
  - Builtin startup time check
  - Lazy load plugins as much as possible
  - Reduce unnecessary plugins by builtin autocmd and function
- Coding friendly
  - Goto definition/reference and code completion powered by *LSP*
  - Highlight and in-file navigation powered by *Treesitter*
  - Git: git related action
  - Search: telescope related action
- Discoverable UX: out of box and easy to use
  - Spacemacs inspired keybinding scheme - ergonomics, mnemonics and consistency
- Modular config: extensible and easy to hack
  - Every piece of config can be *reload*
  - Decouple plugins from core config and core keymappings
  - Sane defaults for each plugin
  - *Pin* core plugins for snapshot and rollback
- For all major platforms: **Windows/Linux/macOS/BSD**

## Features

### Langauge

|  Lang  |      LSP      |       Format       |    Lint    | Test  | Debug |
| :---:  |     :---:     |       :---:        |   :---:    | :---: | :---: |
|  Zig   |      zls      |                    |            |       |       |
|  Rust  | rust_analyzer |                    |            |       |       |
| C/C++  |    clangd     |                    |            |       |       |
|   Go   |     gopls     |                    |            |       |       |
|  Java  |     jdtls     | google_java_format |            |       |       |
|  Lua   |  sumneko_lua  |       stylua       |   selene   |       |       |
| Python |    pyright    |       black        |   flake8   |       |       |
|  Vim   |     vimls     |                    |            |       |       |
|   Sh   |    bashls     |       shfmt        | shellcheck |       |       |
|  Yaml  |    yamlls     |                    |            |       |       |
|  Json  |    jsonls     |                    |            |       |       |

see [language](docs/lang.md)

### Keymappings

see [shortcut](docs/shortcut.md#GUI)

### Modules

see [plugins.lua](lua/young/plugins.lua)

- BWT
- LSP
- UI
- appearance
- basic
- change
- code
- edit
- file
- find
- git
- lang
- neovim
- telescope
- theme
- tool
- write

### GUI

For keymappings of these neovim gui, see [shortcut](docs/shortcut.md#GUI)

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

### Performance

Start up in 82ms.

see [startup time](docs/startup-time.md)

### Update

Pin plugins to pined commit version

```sh
# update to latest commit of pin plugins: xy.plugins.pins()
nvim --headless -c 'luafile ./utils/generate_new_lockfile.lua'
```

### Personal

Local machine scope config for overriding defaults without disturb git repo

- `<leader>yl` to open local config, which is a copy of [template](utils/local.template.lua)
- Only language-server for now.
- Be able to customize every piece of core/plugin config through `xy` magic! (coming soom)

## Appearance

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

## TODO

see [todo](docs/todo.md)

## Acknowledge

see [reference](utils/reference/reference.md)

