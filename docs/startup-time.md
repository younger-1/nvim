### base

```log
vim -u NONE --startuptime /tmp/vim.time +'q' && tail -n 5 /tmp/vim.time
001.055  000.062: start termcap
001.068  000.013: clearing screen
001.208  000.140: opening buffers
001.210  000.002: BufEnter autocommands
001.211  000.001: editing files in windows

nvim -u NONE --startuptime /tmp/nvim.time +'q' && tail -n 5 /tmp/nvim.time
004.916  000.030: inits 3
018.683  013.768: reading ShaDa
018.884  000.201: opening buffers
018.888  000.004: BufEnter autocommands
018.890  000.003: editing files in windows
```

hyperfine --min-runs=20 "nvim +qa" "nvim --headless +qa"

### 2022-02-27

linux

```log
Benchmark 1: nvim +qa
  Time (mean ± σ):     266.7 ms ±  15.4 ms    [User: 121.3 ms, System: 55.7 ms]
  Range (min … max):   244.1 ms … 293.0 ms    20 runs

Benchmark 2: nvim --headless +qa
  Time (mean ± σ):     222.3 ms ±  13.4 ms    [User: 114.1 ms, System: 48.3 ms]
  Range (min … max):   198.1 ms … 252.9 ms    20 runs
```

### 2022-08-02

linux

```log
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

linux

```log
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

```log
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

windows

```log
Benchmark #1: nvim +qa                                                                                                                                     0
  Time (mean ± σ):     751.7 ms ±  24.5 ms    [User: 5.7 ms, System: 10.4 ms]                                                                              1
  Range (min … max):   721.5 ms … 819.7 ms    20 runs

Benchmark #2: nvim --headless +qa
  Time (mean ± σ):     738.0 ms ±  38.1 ms    [User: 6.6 ms, System: 12.7 ms]                                                                              0
  Range (min … max):   705.0 ms … 856.3 ms    20 runs

[init.lua                                14 ] [nil     ] [0] - 0.000028
[init.lua                                21 ] [nil     ] [0] - 0.026043
[init.lua                                24 ] [nil     ] [0] - 0.026055
[lua/young/cfg/init.lua                  4  ] [done    ] [1] - 0.026236
[lua/young/cfg/init.lua                  8  ] [done    ] [1] - 0.052078
[lua/young/autocmd/init.lua              228] [done    ] [2] - 0.058618
[lua/young/key/init.lua                  34 ] [done    ] [2] - 0.059478
[init.lua                                27 ] [nil     ] [0] - 0.067055
[lua/young/packer.lua                    201] [done    ] [1] - 0.067068
[lua/young/packer.lua                    204] [done    ] [1] - 0.070522
[init.lua                                30 ] [nil     ] [0] - 0.157432
[init.lua                                36 ] [nil     ] [0] - 0.157444
[init.lua                                39 ] [nil     ] [0] - 0.157648
[init.lua                                42 ] [nil     ] [0] - 0.182954
```

```log
000.042  000.042: --- NVIM STARTING ---
034.271  034.229: locale set
035.558  001.287: inits 1
035.847  000.289: window checked
035.880  000.033: parsing arguments
042.737  006.857: init lua interpreter
042.946  000.208: expanding arguments
043.063  000.118: inits 2
047.730  004.666: init highlight
047.739  000.009: waiting for UI
051.349  003.610: done waiting for UI
051.407  000.059: init screen for UI
051.535  000.128: init default mappings
051.711  000.176: init default autocommands
068.529  000.265  000.265: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\ftplugin.vim
070.788  000.214  000.214: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\indent.vim
212.823  000.154  000.154: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\neorg\ftdetect\norg.vim
243.688  172.296  172.142: sourcing C:\Users\younger\.config\nvim\init.lua
243.766  019.281: sourcing vimrc file(s)
248.436  000.128  000.128: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\start\editorconfig.nvim\ftdetect\editorconfig.vim
252.368  005.362  005.234: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\filetype.lua
253.107  000.177  000.177: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\filetype.vim
256.317  000.394  000.394: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\syntax\synload.vim
256.672  003.107  002.713: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\syntax\syntax.vim
269.621  000.152  000.152: sourcing C:\Users\younger\.config\nvim\plugin\abbr.vim
270.099  000.246  000.246: sourcing C:\Users\younger\.config\nvim\plugin\func.vim
270.815  000.506  000.506: sourcing C:\Users\younger\.config\nvim\plugin\helper.vim
271.247  000.224  000.224: sourcing C:\Users\younger\.config\nvim\plugin\log-autocmd.vim
271.726  000.271  000.271: sourcing C:\Users\younger\.config\nvim\plugin\vim-ripgrep.vim
283.005  000.444  000.444: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\gzip.vim
283.728  000.251  000.251: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\health.vim
284.372  000.190  000.190: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\man.vim
285.011  000.208  000.208: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\matchit.vim
285.780  000.205  000.205: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\matchparen.vim
286.710  000.312  000.312: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\netrwPlugin.vim
311.295  000.828  000.828: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\autoload\remote\host.vim
315.771  000.576  000.576: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\autoload\remote\define.vim
316.518  027.513  026.109: sourcing C:\Users\younger\.local\share\nvim-data/rplugin.vim
316.569  029.205  001.692: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\rplugin.vim
317.277  000.315  000.315: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\shada.vim
317.806  000.152  000.152: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\spellfile.vim
318.322  000.149  000.149: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\tarPlugin.vim
318.987  000.196  000.196: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\tohtml.vim
319.458  000.132  000.132: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\tutor.vim
319.902  000.147  000.147: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\zipPlugin.vim
321.558  000.312  000.312: sourcing C:\Users\younger\.config\nvim\plugin\autocmd.lua
324.824  003.041  003.041: sourcing C:\Users\younger\.config\nvim\plugin\mappings.lua
331.241  042.172: loading rtp plugins
333.224  000.371  000.371: sourcing C:\Users\younger\.config\nvim\pack\xavier\start\typecorr\plugin\my-typecorr.vim
334.396  000.156  000.156: sourcing C:\Users\younger\.config\nvim\pack\xavier\start\whid\plugin\whid.vim
343.645  000.233  000.233: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\start\editorconfig.nvim\plugin\editorconfig.vim
345.326  000.143  000.143: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\start\firenvim\plugin\firenvim.vim
346.552  000.213  000.213: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\start\FixCursorHold.nvim\plugin\fix_cursorhold_nvim.vim
349.846  000.222  000.222: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\start\lir.nvim\plugin\lir.vim
353.291  000.240  000.240: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\start\nightfox.nvim\plugin\nightfox.vim
355.296  000.445  000.445: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\start\nvim-lspconfig\plugin\lspconfig.vim
357.016  000.205  000.205: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\start\nvim-web-devicons\plugin\nvim-web-devicons.vim
358.972  000.237  000.237: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\start\plenary.nvim\plugin\plenary.vim
363.285  001.761  001.761: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\start\vim-abolish\plugin\abolish.vim
365.426  000.852  000.852: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\start\vim-surround\plugin\surround.vim
366.683  000.192  000.192: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\start\vim-zoom\plugin\zoom.vim
367.915  031.404: loading packages
367.929  000.014: loading after plugins
367.982  000.053: inits 3
380.788  012.805: reading ShaDa
386.202  000.217  000.217: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\symbols-outline.nvim\plugin\symbols-outline.vim
394.097  001.718  001.718: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\dressing.nvim\plugin\dressing.lua
396.279  000.205  000.205: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\which-key.nvim\plugin\which-key.vim
403.509  003.719  003.719: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\barbar.nvim\plugin\bufferline.lua
408.268  000.878  000.878: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\lspsaga.nvim\plugin\lspsaga.lua
412.304  000.383  000.383: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\vim-external\plugin\external.vim
418.324  000.635  000.635: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\vim-asterisk\plugin\asterisk.vim
424.991  002.006  002.006: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\lightspeed.nvim\plugin\init.lua
490.702  000.243  000.243: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\todo-comments.nvim\plugin\todo.vim
498.607  004.869  004.869: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\vim-illuminate\plugin\illuminate.vim
501.677  106.015: opening buffers
502.505  000.829: BufEnter autocommands
502.516  000.011: editing files in windows
746.369  243.852: VimEnter autocommands
748.481  001.140  001.140: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\start\firenvim\autoload\firenvim.vim
748.569  001.061: UIEnter autocommands
748.576  000.007: before starting main loop
752.987  002.537  002.537: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\vim-wordmotion\plugin\wordmotion.vim
756.090  000.488  000.488: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\smart-splits.nvim\plugin\smart-splits.lua
781.122  000.158  000.158: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\matchparen.vim
784.280  000.468  000.468: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\plugin\matchparen.vim
787.271  000.694  000.694: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\vim-matchup\autoload\matchup.vim
792.383  000.399  000.399: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\vim-matchup\autoload\matchup\perf.vim
796.248  001.074  001.074: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\vim-matchup\autoload\matchup\loader.vim
799.890  001.241  001.241: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\vim-matchup\autoload\matchup\matchparen.vim
802.717  043.188  039.153: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\vim-matchup\plugin\matchup.vim
803.929  000.117  000.117: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\vim-matchup\after\plugin\matchit.vim
809.354  000.778  000.778: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\Comment.nvim\after\plugin\Comment.lua
815.525  000.652  000.652: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\dial.nvim\plugin\dial.vim
979.119  155.231  155.231: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\vim-wakatime\plugin\wakatime.vim
982.005  000.200  000.200: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\specs.nvim\plugin\specs.vim
992.614  003.085  003.085: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\nvim-treesitter\plugin\nvim-treesitter.lua
1073.852  001.010  001.010: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\playground\plugin\nvim-treesitter-playground.lua
1104.727  001.257  001.257: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\scripts.vim
1109.865  002.611  002.611: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\nvim-treesitter-textobjects\plugin\nvim-treesitter-textobjects.vim
1113.196  000.735  000.735: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\nvim-treesitter-refactor\plugin\nvim-treesitter-refactor.vim
1118.478  002.671  002.671: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\indent-blankline.nvim\plugin\indent_blankline.vim
1128.861  000.826  000.826: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\telescope.nvim\plugin\telescope.lua
1409.732  000.268  000.268: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\telescope-frecency.nvim\plugin\frecency.vim
1448.065  001.620  001.620: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\scripts.vim
1467.137  000.287  000.287: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\nvim-colorizer.lua\plugin\colorizer.vim
1548.988  001.237  001.237: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\scripts.vim
1555.068  001.239  001.239: sourcing C:\Users\younger\scoop\apps\neovim\current\share\nvim\runtime\scripts.vim
1562.976  000.416  000.416: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\vim-matchup\autoload\matchup\pos.vim
1568.591  001.367  001.367: sourcing C:\Users\younger\.local\share\nvim-data\site\pack\packer\opt\vim-matchup\autoload\matchup\delim.vim
1574.862  604.466: first screen update
1574.877  000.015: --- NVIM STARTED ---
```
