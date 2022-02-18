vim.cmd [[
  call wilder#setup({
  \ 'modes': [':', '/', '?'],
  \ 'accept_key': '<C-e>',
  \ })

  " 'border'            : 'single', 'double', 'rounded' or 'solid', can also be a list of 8 characters
  " 'highlights.border' : highlight to use for the border`
  " call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
  " \ 'pumblend': 20,
  " \ 'highlights': {
  " \   'border': 'Normal',
  " \ },
  " \ 'border': 'rounded',
  " \ })))

  let s:wilder_cmd_line_renderer = wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
  \ 'pumblend': 20,
  \ 'border': 'rounded',
  \ 'highlighter': wilder#basic_highlighter(),
  \ 'highlights': {
  \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#e27878', 'bold': v:true, 'underline': v:true}]),
  \   'selected_accent': wilder#make_hl('WilderSelectedAccent', 'PmenuSel', [{}, {}, {'foreground': '#e27878', 'bold': v:true, 'underline': v:true}]),
  \ },
  \ 'left': [wilder#popupmenu_devicons({'get_hl': wilder#devicons_get_hl_from_glyph_palette_vim()}), wilder#popupmenu_buffer_flags({'flags': ' '})],
  \ }))

  let s:wilder_search_renderer = wilder#wildmenu_renderer({
  \ 'highlighter': wilder#basic_highlighter(),
  \ 'separator': '  ',
  \ 'left': [' '],
  \ 'right': [' ', wilder#wildmenu_index()],
  \ })

  call wilder#set_option(
  \ 'renderer',
  \ wilder#renderer_mux({
  \   ':': s:wilder_cmd_line_renderer,
  \   '/': s:wilder_search_renderer,
  \   '?': s:wilder_search_renderer,
  \ })
  \ )

  call wilder#set_option('pipeline', [
  \ wilder#branch(
  \   wilder#python_file_finder_pipeline({
  \     'file_command': {_, arg -> stridx(arg, '.') != -1 ? ['fd', '-tf', '-H', '--strip-cwd-prefix'] : ['fd', '-tf', '--strip-cwd-prefix']},
  \     'dir_command': ['fd', '-td'],
  \   }),
  \   wilder#cmdline_pipeline({'fuzzy': 1}),
  \   [
  \     wilder#check({_, x -> empty(x)}),
  \     wilder#history(),
  \   ],
  \   wilder#python_search_pipeline({
  \     'pattern': wilder#python_fuzzy_pattern({
  \       'start_at_boundary': 0,
  \     }),
  \   }),
  \   wilder#vim_search_pipeline()
  \ ),
  \ ])

]]
