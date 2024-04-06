" <https://github.com/gpanders/dotfiles/blob/670345f735839c96ce689c8c052dd02135b34803/.config/nvim/init.vim#L38-L49>
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ --line-number\ --recursive\ -I\ $*
  set grepformat=%f:%l:%m
  if has('mac')
    " BSD grep that ships with macOS reads from stdin when no arguments are
    " provided, so append /dev/null to prevent it from blocking
    set grepprg+=\ /dev/null
  endif
endif
