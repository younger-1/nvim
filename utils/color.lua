-- <https://github.com/nex-s/nvim-config/blob/acf6a4a24f43915beb016518f92622dfee698310/lua/core/x-color.lua>

--  ColorColumn	用于 'colorcolumn' 设置的列。
--  Conceal		代替隐藏文本的填充字符 (见 'conceallevel')。
--  Cursor		光标所在的字符。
--  lCursor		使用 |language-mapping| 时光标所在的字符 (见 'guicursor')。
--  CursorIM	类似于 Cursor，但用于 IME 模式。|CursorIM|
--  CursorColumn	置位 'cursorcolumn' 时，光标所在的屏幕列。
--  CursorLine	置位 'cursorline' 时，光标所在的屏幕行。
--  Directory	目录名 (还有列表里的其它特殊名字)。
--  DiffAdd		比较模式: 增加的行。|diff.txt|
--  DiffChange	比较模式: 改变的行。|diff.txt|
--  DiffDelete	比较模式: 删除的行。|diff.txt|
--  DiffText	比较模式: 改变行里的改动文本。|diff.txt|
--  EndOfBuffer	缓冲区的末行之后的填充行 (~)。缺省用 |hl-NonText| 类似的高亮。
--  ErrorMsg	命令行上的错误信息。
--  VertSplit	分离垂直分割窗口的列。
--  Folded		用于关闭的折叠的行。
--  FoldColumn	'foldcolumn'
--  SignColumn	显示 |signs| 的列。
--  IncSearch	'incsearch' 高亮；也用于被 ":s///c" 替换的文本。
--  LineNr		":number" 和 ":#" 命令与置位 'number' 或 'relativenumber' 选项时的行号。
--  LineNrAbove	置位 'relativenumber' 选项时，光标上方的行号。
--  LineNrBelow	置位 'relativenumber' 选项时，光标下方的行号。
--  CursorLineNr	和 LineNr 类似，置位 'cursorline' 且 'cursorlineopt' 设为 "number" 或 "both" 时，用于光标行。
--  CursorLineSign	和 SignColumn 类似，置位  'cursorline' 时用于光标行。
--  CursorLineFold	和 FoldColumn 类似，置位  'cursorline' 时用于光标行。
--  MatchParen	如果光标所在或刚刚在它之前的字符是配对的括号一部分的话，它和它的配对。|pi_paren.txt|
--  ModeMsg		'showmode' 消息 (例如，"-- INSERT --")。
--  MoreMsg		|more-prompt|
--  NonText		窗口尾部的 '@'，'showbreak' 的字符和其它在文本里实际不存在的字符 (例如，代替行尾放不下的双宽字符而显示的 ">")。
--  Normal		普通文本。
--  Pmenu		弹出菜单: 普通项目。
--  PmenuSel	弹出菜单: 选中项目。
--  PmenuSbar	弹出菜单: 滚动条。
--  PmenuThumb	弹出菜单: 滚动条的拇指 (thumb)。
--  Question	|hit-enter| 提示和 yes/no 问题。
--  QuickFixLine	快速修复窗口的当前 |quickfix| 项目。
--  Search		最近搜索模式的高亮 (见 'hlsearch')。也用于类似的要突出显示的项目。
--  CurSearch	最近搜索模式的当前匹配 (见 'hlsearch')。 备注: 只在刚搜索后才正确，内容作了修改或屏幕重画后可能会过时。
--  SpecialKey	":map" 列出的 Meta 和特殊键，也包括文本里不可显示字符的显示和 一般的: 和实际内容显示上有差异的文本。
--  SpellBad	拼写检查器不能识别的单词。|spell| 它会和本来应该使用的高亮进行组合。
--  SpellCap	应该大写字母开头的单词。|spell| 它会和本来应该使用的高亮进行组合。
--  SpellLocal	拼写检查器能识别但只在其它区域使用的单词。|spell| 它会和本来应该使用的高亮进行组合。
--  SpellRare	拼写检查器能识别但很少使用的单词。|spell| 它会和本来应该使用的高亮进行组合。
--  StatusLine	当前窗口的状态行。
--  StatusLineNC	非当前窗口的状态行 注意: 如果等于 "StatusLine"，Vim 会使用 "^^^" 指示当前窗口的状 态行。
--  StatusLineTerm	|terminal| 窗口为当前窗口时的状态行。
--  StatusLineTermNC   |terminal| 窗口不为当前窗口时的状态行。
--  TabLine		标签页行，非活动标签页标签。
--  TabLineFill	标签页行，没有标签的地方。
--  TabLineSel	标签页行，活动标签页标签。
--  Terminal	|terminal| 窗口 (见 |terminal-size-color|)。
--  Title		":set all"、":autocmd" 等输出的标题。
--  Visual		可视模式的选择区。
--  VisualNOS	Vim 是 "选择区的非拥有者" 时，可视模式的选择区。只有 X11 GUI 的 |gui-x11| 和 |xterm-clipboard| 才提供此支持。
--  WarningMsg	警告消息。
--  WildMenu	'wildmenu' 补全的当前匹配。
--  'statusline' 语法允许在状态行和标尺 (通过 'rulerformat') 上使用 9 种不同的高亮。这些高亮组的名字是 User1 到 User9。


vim.api.nvim_set_hl(0, "CursorLine",   { bg = "#282828", fg = "NONE", })
vim.api.nvim_set_hl(0, "VisualNOS",    { bg = "#444444", fg = "#000000", })
vim.api.nvim_set_hl(0, "Normal",       { bg = "#252525", fg = "#828282", })
vim.api.nvim_set_hl(0, "StatusLine",   { bg = "#3A3A3A", fg = "#AF87D7", })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#303030", fg = "#767676", })

vim.api.nvim_set_hl(0, "NonText",      { bg = "NONE", fg = "#303030", })
vim.api.nvim_set_hl(0, "VertSplit",    { bg = "NONE", fg = "#353535", })
vim.api.nvim_set_hl(0, "Warning",      { bg = "NONE", fg = "#D66F01", })
vim.api.nvim_set_hl(0, "ModeMsg",      { bg = "NONE", fg = "#767676", })
vim.api.nvim_set_hl(0, "Error",        { bg = "NONE", fg = "#ffffff", })
vim.api.nvim_set_hl(0, "Conceal",      { bg = "NONE", fg = "#626262", })
vim.api.nvim_set_hl(0, "PreProc",      { bg = "NONE", fg = "#767676", })
vim.api.nvim_set_hl(0, "SpecialKey",   { bg = "NONE", fg = "#6c5b9e", })
vim.api.nvim_set_hl(0, "FoldColumn",   { bg = "NONE", fg = "#666666", })
vim.api.nvim_set_hl(0, "PmenuSbar",    { bg = "NONE", fg = "#ffffff", })
vim.api.nvim_set_hl(0, "WildMenu",     { bg = "NONE", fg = "#D75F5F", })
vim.api.nvim_set_hl(0, "ColorColumn",  { bg = "NONE", fg = "#000000", })
vim.api.nvim_set_hl(0, "SignColumn",   { bg = "NONE", fg = "#767676", })
vim.api.nvim_set_hl(0, "PmenuThumb",   { bg = "NONE", fg = "#ffffff", })
vim.api.nvim_set_hl(0, "Cursor",       { bg = "NONE", fg = "#000000", })
vim.api.nvim_set_hl(0, "DiffAdd",      { bg = "NONE", fg = "#87AF87", })
vim.api.nvim_set_hl(0, "DiffChange",   { bg = "NONE", fg = "#DE0000", })
vim.api.nvim_set_hl(0, "DiffDelete",   { bg = "NONE", fg = "#AF5F87", })
vim.api.nvim_set_hl(0, "DiffText",     { bg = "NONE", fg = "#D7AF5F", })
vim.api.nvim_set_hl(0, "Operator",     { bg = "NONE", fg = "#555555", })
vim.api.nvim_set_hl(0, "Statement",    { bg = "NONE", fg = "#A5A5A5", })
vim.api.nvim_set_hl(0, "Special",      { bg = "NONE", fg = "#8567A3", })
vim.api.nvim_set_hl(0, "Identifier",   { bg = "NONE", fg = "#C53B82", })
vim.api.nvim_set_hl(0, "Constant",     { bg = "NONE", fg = "#C53B82", })
vim.api.nvim_set_hl(0, "Number",       { bg = "NONE", fg = "#afc460", })
vim.api.nvim_set_hl(0, "Boolean",      { bg = "NONE", fg = "#C53B82", })
vim.api.nvim_set_hl(0, "Keyword",      { bg = "NONE", fg = "#6A6A6A", })
vim.api.nvim_set_hl(0, "Function",     { bg = "NONE", fg = "#C53B82", })
vim.api.nvim_set_hl(0, "Delimiter",    { bg = "NONE", fg = "#8567A3", })
vim.api.nvim_set_hl(0, "Question",     { bg = "NONE", fg = "#BBE73D", })
vim.api.nvim_set_hl(0, "Conditonal",   { bg = "NONE", fg = "#ffffff", })
vim.api.nvim_set_hl(0, "Label",        { bg = "NONE", fg = "#D0EE7A", })
vim.api.nvim_set_hl(0, "Character",    { bg = "NONE", fg = "#ffffff", })
vim.api.nvim_set_hl(0, "Typedef",      { bg = "NONE", fg = "#000000", })
vim.api.nvim_set_hl(0, "SpecialChar",  { bg = "NONE", fg = "#333333", })
vim.api.nvim_set_hl(0, "Tag",          { bg = "NONE", fg = "#ffffff", })
vim.api.nvim_set_hl(0, "Debug",        { bg = "NONE", fg = "#ffffff", })
vim.api.nvim_set_hl(0, "ErrorMsg",     { bg = "NONE", fg = "#C53B82", })
vim.api.nvim_set_hl(0, "WarningMsg",   { bg = "NONE", fg = "#d1771b", })
vim.api.nvim_set_hl(0, "MoreMsg",      { bg = "NONE", fg = "#777777", })
vim.api.nvim_set_hl(0, "Ignore",       { bg = "NONE", fg = "#d1771b", })
vim.api.nvim_set_hl(0, "QuickFixLine", { bg = "NONE", fg = "#DE0000", })

vim.api.nvim_set_hl(0, "TabLine",      { bg = "NONE", fg = "#FFFFFF", })
vim.api.nvim_set_hl(0, "TabLineFill",  { bg = "NONE", fg = "#FFFFFF", })
vim.api.nvim_set_hl(0, "TabLineSel",   { bg = "NONE", fg = "#FFFFFF", })
vim.api.nvim_set_hl(0, "CursorColumn", { bg = "NONE", fg = "#FFFFFF", })
vim.api.nvim_set_hl(0, "SpellRare",    { bg = "NONE", fg = "#FFFFFF", })
vim.api.nvim_set_hl(0, "htmlTag",      { bg = "NONE", fg = "#000000", })
vim.api.nvim_set_hl(0, "htmlEndTag",   { bg = "NONE", fg = "#000000", })

vim.api.nvim_set_hl(0, "diffAdded",    { bg = "NONE", fg = "#9EB73D", })
vim.api.nvim_set_hl(0, "diffRemoved",  { bg = "NONE", fg = "#C53B82", })

vim.api.nvim_set_hl(0, "StatusLineTerm",    { bg = "NONE", fg = "#FFFFFF", })
vim.api.nvim_set_hl(0, "StatusLineTermNC",  { bg = "NONE", fg = "#FFFFFF", })
vim.api.nvim_set_hl(0, "helpHyperTextJump", { bg = "NONE", fg = "#AF87D7", })

vim.api.nvim_set_hl(0, "SpecialComment", { bg = "NONE", fg = "#d1771b", })
vim.api.nvim_set_hl(0, "CursorLineFold", { bg = "#ffffff", fg = "#000000", })

vim.api.nvim_set_hl(0, "Visual",       { bg = "#232323", fg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "Search",       { bg = "NONE", fg = "#C53B82", bold = true })
vim.api.nvim_set_hl(0, "IncSearch",    { bg = "NONE", fg = "#C53B82", bold = true })
vim.api.nvim_set_hl(0, "MatchParen",   { bg = "NONE", fg = "#C53B82", bold = true })
vim.api.nvim_set_hl(0, "PmenuSel",     { bg = "NONE", fg = "NONE",    bold = true })
vim.api.nvim_set_hl(0, "Directory",    { bg = "NONE", fg = "#AF87D7", bold = true })
vim.api.nvim_set_hl(0, "Title",        { bg = "NONE", fg = "#C6C6C6", bold = true })

vim.api.nvim_set_hl(0, "Type",         { bg = "NONE", fg = "#8567A3", italic = true })
vim.api.nvim_set_hl(0, "Comment",      { bg = "NONE", fg = "#525252", italic = true })
vim.api.nvim_set_hl(0, "Float",        { bg = "NONE", fg = "#afc460", italic = true })
vim.api.nvim_set_hl(0, "String",       { bg = "NONE", fg = "#8567A3", italic = true })
vim.api.nvim_set_hl(0, "Repeat",       { bg = "NONE", fg = "#8567A3", italic = true })
vim.api.nvim_set_hl(0, "Include",      { bg = "NONE", fg = "#BBE73D", italic = true })
vim.api.nvim_set_hl(0, "Define",       { bg = "NONE", fg = "#C53B82", italic = true })
vim.api.nvim_set_hl(0, "Structure",    { bg = "NONE", fg = "#BBE73D", italic = true })
vim.api.nvim_set_hl(0, "Macro",        { bg = "NONE", fg = "#BBE73D", italic = true })
vim.api.nvim_set_hl(0, "StorageClass", { bg = "NONE", fg = "#BBE73D", italic = true })

vim.api.nvim_set_hl(0, "LineNr",       { bg = "#252525", fg = "#6F6F6F", italic = true })
vim.api.nvim_set_hl(0, "Folded",       { bg = "#232323", fg = "#494949", italic = true })
vim.api.nvim_set_hl(0, "Pmenu",        { bg = "#2a2a2a", fg = "NONE",    italic = true })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#282828", fg = "#6c5b9e", italic = true })

vim.api.nvim_set_hl(0, "Underlined",   { bg = "NONE", fg = "#ffffff", underline = true })
vim.api.nvim_set_hl(0, "SpellBad",     { bg = "NONE", fg = "#AF5F87", underline = true })
vim.api.nvim_set_hl(0, "SpellCap",     { bg = "NONE", fg = "#87AF87", underline = true })
vim.api.nvim_set_hl(0, "SpellLocal",   { bg = "NONE", fg = "#D7AF5F", underline = true })

vim.api.nvim_set_hl(0, "Exception",    { bg = "NONE", fg = "#BBE73D", italic = true, bold = true })
vim.api.nvim_set_hl(0, "Todo",         { bg = "NONE", fg = "#D66F01", italic = true, bold = true })

