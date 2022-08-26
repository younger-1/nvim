
hyperfine --min-runs=20 "nvim +qa" "nvim --headless +qa"

### 2022-02-27

```
Benchmark 1: nvim +qa
  Time (mean ± σ):     266.7 ms ±  15.4 ms    [User: 121.3 ms, System: 55.7 ms]
  Range (min … max):   244.1 ms … 293.0 ms    20 runs

Benchmark 2: nvim --headless +qa
  Time (mean ± σ):     222.3 ms ±  13.4 ms    [User: 114.1 ms, System: 48.3 ms]
  Range (min … max):   198.1 ms … 252.9 ms    20 runs

```

### 2022-08-02

```
[init.lua                                14 ] [nil     ] [0] - 0.000013
[init.lua                                21 ] [nil     ] [0] - 0.014216
[lua/young/cfg/init.lua                  4  ] [done    ] [1] - 0.014270
[lua/young/cfg/init.lua                  10 ] [done    ] [1] - 0.016873
[lua/young/autocmd/init.lua              180] [done    ] [2] - 0.017664
[lua/young/key/init.lua                  34 ] [done    ] [2] - 0.018060
[init.lua                                24 ] [nil     ] [0] - 0.023182
[lua/young/packer.lua                    186] [done    ] [1] - 0.023192
[lua/young/packer.lua                    189] [done    ] [1] - 0.024928
[init.lua                                27 ] [nil     ] [0] - 0.540936
[init.lua                                33 ] [nil     ] [0] - 0.540961
[init.lua                                36 ] [nil     ] [0] - 0.541070
[init.lua                                39 ] [nil     ] [0] - 0.555483
```

### 2022-08-26

```
Benchmark 1: nvim +qa
  Time (mean ± σ):     243.7 ms ±  10.6 ms    [User: 134.4 ms, System: 96.1 ms]
  Range (min … max):   221.7 ms … 257.2 ms    20 runs

Benchmark 2: nvim --headless +qa
  Time (mean ± σ):     228.7 ms ±  16.9 ms    [User: 127.8 ms, System: 88.5 ms]
  Range (min … max):   208.5 ms … 282.5 ms    20 runs

[init.lua                                14 ] [nil     ] [0] - 0.000029
[init.lua                                21 ] [nil     ] [0] - 0.017804
[lua/young/cfg/init.lua                  4  ] [done    ] [1] - 0.017993
[lua/young/cfg/init.lua                  10 ] [done    ] [1] - 0.022282
[lua/young/autocmd/init.lua              227] [done    ] [2] - 0.023254
[lua/young/key/init.lua                  34 ] [done    ] [2] - 0.023913
[init.lua                                24 ] [nil     ] [0] - 0.031840
[lua/young/packer.lua                    196] [done    ] [1] - 0.031855
[lua/young/packer.lua                    199] [done    ] [1] - 0.035292
[init.lua                                27 ] [nil     ] [0] - 0.060802
[init.lua                                33 ] [nil     ] [0] - 0.060823
[init.lua                                36 ] [nil     ] [0] - 0.061073
[init.lua                                39 ] [nil     ] [0] - 0.082844
```

```
000.008  000.008: --- NVIM STARTING ---
000.893  000.885: locale set
001.368  000.475: inits 1
001.389  000.021: window checked
001.395  000.005: parsing arguments
003.517  002.122: init lua interpreter
003.779  000.262: expanding arguments
003.849  000.070: inits 2
004.254  000.404: init highlight
004.255  000.001: waiting for UI
006.899  002.644: done waiting for UI
006.913  000.014: init screen for UI
006.943  000.030: init default mappings
007.002  000.059: init default autocommands
009.030  000.167  000.167: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/ftplugin.vim
009.373  000.043  000.043: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/indent.vim
066.118  000.026  000.026: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/neorg/ftdetect/norg.vim
078.479  068.891  068.865: sourcing /Users/bytedance/.config/nvim/init.lua
078.521  002.418: sourcing vimrc file(s)
079.363  000.024  000.024: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/start/editorconfig.nvim/ftdetect/editorconfig.vim
079.890  000.848  000.825: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/filetype.lua
080.002  000.023  000.023: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/filetype.vim
080.457  000.094  000.094: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/syntax/synload.vim
080.564  000.475  000.380: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/syntax/syntax.vim
082.690  000.031  000.031: sourcing /Users/bytedance/.config/nvim/plugin/abbr.vim
082.954  000.183  000.183: sourcing /Users/bytedance/.config/nvim/plugin/func.vim
083.138  000.112  000.112: sourcing /Users/bytedance/.config/nvim/plugin/helper.vim
083.269  000.064  000.064: sourcing /Users/bytedance/.config/nvim/plugin/log-autocmd.vim
083.447  000.105  000.105: sourcing /Users/bytedance/.config/nvim/plugin/vim-ripgrep.vim
084.700  000.033  000.033: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/gzip.vim
084.800  000.017  000.017: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/health.vim
084.915  000.015  000.015: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/man.vim
085.005  000.023  000.023: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/matchit.vim
085.106  000.025  000.025: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/matchparen.vim
085.212  000.031  000.031: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/netrwPlugin.vim
085.604  000.013  000.013: sourcing /Users/bytedance/.local/share/nvim/rplugin.vim
085.616  000.316  000.303: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/rplugin.vim
085.758  000.072  000.072: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/shada.vim
085.855  000.017  000.017: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/spellfile.vim
085.948  000.021  000.021: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/tarPlugin.vim
086.031  000.016  000.016: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/tohtml.vim
086.136  000.016  000.016: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/tutor.vim
086.233  000.022  000.022: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/zipPlugin.vim
086.676  000.068  000.068: sourcing /Users/bytedance/.config/nvim/plugin/autocmd.lua
087.579  000.836  000.836: sourcing /Users/bytedance/.config/nvim/plugin/mappings.lua
088.388  006.497: loading rtp plugins
090.399  000.817  000.817: sourcing /Users/bytedance/.config/nvim/pack/xavier/start/typecorr/plugin/my-typecorr.vim
091.398  000.060  000.060: sourcing /Users/bytedance/.config/nvim/pack/xavier/start/whid/plugin/whid.vim
093.396  000.084  000.084: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/start/editorconfig.nvim/plugin/editorconfig.vim
094.325  000.126  000.126: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim/plugin/fix_cursorhold_nvim.vim
095.651  000.072  000.072: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/start/lir.nvim/plugin/lir.vim
096.630  000.038  000.038: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/start/nightfox.nvim/plugin/nightfox.vim
097.207  000.136  000.136: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-lspconfig/plugin/lspconfig.vim
097.814  000.048  000.048: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-web-devicons/plugin/nvim-web-devicons.vim
098.428  000.041  000.041: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/start/plenary.nvim/plugin/plenary.vim
099.878  000.598  000.598: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/start/vim-abolish/plugin/abolish.vim
100.748  000.399  000.399: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/start/vim-surround/plugin/surround.vim
101.437  000.069  000.069: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/start/vim-zoom/plugin/zoom.vim
101.938  011.062: loading packages
104.202  002.264: loading after plugins
104.220  000.018: inits 3
111.648  007.428: reading ShaDa
116.124  000.859  000.859: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/lightspeed.nvim/plugin/init.lua
128.441  000.103  000.103: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/which-key.nvim/plugin/which-key.vim
137.157  003.507  003.507: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/vim-illuminate/plugin/illuminate.vim
138.687  000.167  000.167: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/vim-external/plugin/external.vim
141.498  001.736  001.736: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/barbar.nvim/plugin/bufferline.lua
142.643  000.150  000.150: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/vim-asterisk/plugin/asterisk.vim
147.705  000.048  000.048: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/todo-comments.nvim/plugin/todo.vim
150.443  001.243  001.243: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/dressing.nvim/plugin/dressing.lua
151.332  000.032  000.032: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim/plugin/symbols-outline.vim
154.114  000.519  000.519: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/lspsaga.nvim/plugin/lspsaga.lua
156.803  036.792: opening buffers
157.153  000.350: BufEnter autocommands
157.157  000.003: editing files in windows
210.035  052.878: VimEnter autocommands
210.039  000.004: UIEnter autocommands
210.041  000.002: before starting main loop
211.097  000.176  000.176: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/smart-splits.nvim/plugin/smart-splits.lua
213.941  001.055  001.055: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/vim-wordmotion/plugin/wordmotion.vim
218.587  000.026  000.026: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/matchparen.vim
219.050  000.147  000.147: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/matchparen.vim
219.626  000.257  000.257: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/vim-matchup/autoload/matchup.vim
220.010  000.119  000.119: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/vim-matchup/autoload/matchup/perf.vim
221.034  000.567  000.567: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/vim-matchup/autoload/matchup/loader.vim
222.078  000.696  000.696: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/vim-matchup/autoload/matchup/matchparen.vim
223.300  007.396  005.585: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/vim-matchup/plugin/matchup.vim
223.659  000.018  000.018: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim
225.737  000.306  000.306: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/Comment.nvim/after/plugin/Comment.lua
228.583  000.580  000.580: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/telescope.nvim/plugin/telescope.lua
274.560  000.065  000.065: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/telescope-frecency.nvim/plugin/frecency.vim
279.177  002.880  002.880: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/plugin/nvim-treesitter.lua
285.974  000.369  000.369: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/playground/plugin/nvim-treesitter-playground.lua
290.150  000.542  000.542: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/scripts.vim
292.139  001.181  001.181: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects/plugin/nvim-treesitter-textobjects.vim
293.721  000.785  000.785: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim/plugin/indent_blankline.vim
295.418  000.472  000.472: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-refactor/plugin/nvim-treesitter-refactor.vim
306.178  000.307  000.307: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/dial.nvim/plugin/dial.vim
309.815  000.062  000.062: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua/plugin/colorizer.vim
321.677  003.422  003.422: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/vim-wakatime/plugin/wakatime.vim
323.901  000.051  000.051: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/specs.nvim/plugin/specs.vim
328.556  000.641  000.641: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/scripts.vim
330.171  000.514  000.514: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/scripts.vim
331.444  000.475  000.475: sourcing /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/scripts.vim
332.297  000.140  000.140: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/vim-matchup/autoload/matchup/pos.vim
333.268  000.457  000.457: sourcing /Users/bytedance/.local/share/nvim/site/pack/packer/opt/vim-matchup/autoload/matchup/delim.vim
336.214  104.280: first screen update
```
