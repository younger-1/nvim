" <https://github.com/johejo/gomod.vim/blob/master/syntax/gomod.vim>
" <https://github.com/maralla/gomod.vim/blob/master/syntax/gomod.vim>

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syntax keyword gomodVerbs go
syntax keyword gomodVerbExclude exclude contained
syntax keyword gomodVerbReplace replace contained
syntax keyword gomodVerbModule module contained
syntax keyword gomodVerbRequire require contained

syntax match  gomodModuleName '[0-9A-Za-z_\.\/-]\+' contained
syntax match  gomodModuleVersion 'v\d\+\(\.\d\+\(\.\d\+\)\?\)\?\(-\d\{14}-\x\{12}\)\?\(+incompatible\)\?' contained
syntax region gomodDep start="^\s*" end="$" contains=gomodModuleName,gomodModuleVersion,gomodComment contained
syntax match  gomodReplaceArrow /=>/
syntax region gomodComment start="//" end="$"

syntax region gomodModule start="replace\s\+" end="$" contains=gomodVerbReplace,gomodComment,gomodModuleName,gomodModuleVersion,gomodReplaceArrow transparent
syntax region gomodModule start="module\s\+"  end="$" contains=gomodVerbModule,gomodComment,gomodModuleName transparent
syntax region gomodModule start="require\s\+" end="$" contains=gomodVerbRequire,gomodComment,gomodModuleName,gomodModuleVersion transparent
syntax region gomodModule start="exclude\s\+" end="$" contains=gomodVerbExclude,gomodComment,gomodModuleName,gomodModuleVersion transparent
syntax region gomodModule start="require\s*(" end=")" contains=gomodVerbRequire,gomodComment,gomodDep transparent keepend skip="//[^)]*)"

hi default link gomodComment Comment
hi default link gomodReplaceArrow Operator
hi default link gomodVerbs Keyword
hi default link gomodVerbReplace Keyword
hi default link gomodVerbModule Keyword
hi default link gomodVerbRequire Keyword
hi default link gomodVerbExclude Keyword
hi default link gomodModuleVersion Constant
hi default link gomodModuleName Type

syntax sync minlines=10000

let b:current_syntax = "gomod"
