" 热更文件"
function! <SID>Hot()
    " execute '!erl -name hot@192.168.4.30 -setcookie abc -pa /home/kingwen/qiyuan/qiyuan_server/xge/ -s hot start 2'
    " execute '!erl -name hot@192.168.4.30 -setcookie abc -pa /home/kingwen/sync/demo -s hot start 2'
    execute '!erl -name hot@192.168.4.30 -setcookie abc -pa /home/kingwen/pet/server/main -s hot start 2'
endfunc

" 停止所有 
function! <SID>Stop()
    " execute '!erl -name hot@192.168.4.30 -setcookie abc -pa /home/kingwen/qiyuan/qiyuan_server/xge/ -s hot stop'
    " execute '!erl -name hot@192.168.4.30 -setcookie abc -pa /home/kingwen/sync/demo -s hot stop'
    execute '!erl -name hot@192.168.4.30 -setcookie abc -pa /home/kingwen/pet/server/main -s hot stop'
endfunc

" 自己写的Make
" function! <SID>Mk()
"     let g:erlang_project="qiyuan"
"     let g:erlang_exec="!escript /home/kingwen/.vim/vimfiles/compiler/erlang_check.erl" . "\ \%\ " . g:erlang_project . "\ " . g:erlang_address . ""
"     execute g:erlang_exec
" endfunc

function! <SID>ChangeProj()
    if(g:erlang_project == "qiyuan")
        let g:erlang_project="pet"
    else
        let g:erlang_project="qiyuan"
    endif
    execute "setlocal makeprg=" . "escript\\ " . "/home/kingwen/.vim/vimfiles/compiler/erlang_check.erl" . "\\ \%" . "\\ " . g:erlang_project . "\\ " . g:erlang_address . ""
    echo "项目切换到:".g:erlang_project
endfunc

command! -nargs=0 Hot call <SID>Hot()
command! -nargs=0 Stop call <SID>Stop()
command! -nargs=0 ChangeProj call <SID>ChangeProj()
