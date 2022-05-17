" <https://github.com/jamestthompson3/vimConfig/blob/b6567cd5e9102ff0fc64d770d1a0079ebf40d8f6/after/ftplugin/text.vim>
" FIX:not work

setlocal wrap linebreak spell

syntax region CodeFence start=+```\w\++ end=+```+ contains=@NoSpell
syntax region CodeBlock start=+`\w\++ end=+`+ contains=@NoSpell
syntax match UrlNoSpell /\w\+:\/\/[^[:space:]]\+/ contains=@NoSpell
