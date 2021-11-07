"" Name: plugin/foldtext.vim
"" Author: Maxim Kim <habamax@gmail.com>
"" https://github.com/habamax/.vim/blob/master/plugin/foldtext.vim

func! fold#Text()
    let foldchar = get(b:, 'foldchar', '•')
    let strip_comments = get(b:, 'foldtext_strip_comments', v:false)
    let strip_add_regex = get(b:, 'foldtext_strip_add_regex', '')

    let line = getline(v:foldstart)

    " markdown frontmatter -- just take the next line hoping it would be
    " title: Your title
    if line =~ '^----*$'
        let line = getline(v:foldstart+1)
    endif

    let indent = indent(v:foldstart)

    let foldlevel = repeat(foldchar, v:foldlevel)
    let foldindent = repeat(' ', max([indent-strdisplaywidth(foldlevel), strdisplaywidth(foldchar)]))
    let foldlines = (v:foldend - v:foldstart + 1)

    " always strip away fold markers
    let strip_regex = '\%(\s*{{{\d*\s*\)'
    if strip_comments
        let strip_regex .= '\|\%(^\s*'
                \. substitute(&commentstring, '\s*%s\s*', '', '')
                \. '*\s*\)'
    endif
    let line = substitute(line, strip_regex, '', 'g')

    " additional per buffer strip
    if strip_add_regex != ""
        let line = substitute(line, strip_add_regex, '', 'g')
    endif

    let line = substitute(line, '^\s*\|\s*$', '', 'g')
    let line = substitute(line, '^"', '', 'g')
    let line = substitute(line, ':$', '', 'g')


    let nontextlen = strdisplaywidth(foldlevel.foldindent.foldlines.' ()')
    let foldtext = strcharpart(line, 0, winwidth(0) - nontextlen)
    let foldtext="[".foldtext." ]"

    let foldlines_padding = ' '

    return printf("%s%s%s%s(%d) ",
                \ foldlevel,
                \ foldindent,
                \ foldtext,
                \ foldlines_padding,
                \ foldlines)
endfunc
