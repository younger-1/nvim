vim.g.VM_default_mappings = 0

-- <https://github.com/Akianonymus/dotfiles/blob/master/src/.config/nvim/lua/custom/mappings.lua>
vim.cmd [[
     let g:VM_maps = {}
     let g:VM_maps["Undo"] = 'u'
     let g:VM_maps["Redo"] = '<C-r>'
     let g:VM_maps['Find Under']         = '<A-n>'
     let g:VM_maps['Find Subword Under'] = '<A-n>'
     function! VM_Start()
       nmap <buffer> n <Plug>(VM-Find-Next)zzzv
       nmap <buffer> N <Plug>(VM-Find-Prev)zzzv
     endfunction
     " todo: improve this
     function! VM_Exit()
       nunmap <buffer> n nzzv
       iunmap <buffer> N nzzv
     endfunction
  ]]
