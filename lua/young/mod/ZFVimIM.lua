vim.cmd [[
function! s:myLocalDb()
    let db = ZFVimIM_dbInit({
                \   'name' : 'YourDb',
                \ })
    call ZFVimIM_cloudRegister({
                \   'mode' : 'local',
                \   'dbId' : db['dbId'],
                \   'repoPath' : '/path/to/repo', " 词库路径
                \   'dbFile' : '/YourDbFile', " 词库文件, 相对 repoPath 的路径
                \   'dbCountFile' : '/YourDbCountFile', " 非必须, 词频文件, 相对 repoPath 的路径
                \ })
endfunction
autocmd User ZFVimIM_event_OnDbInit call s:myLocalDb()
]]
