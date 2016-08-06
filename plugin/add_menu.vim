"   附加菜单[如想在菜单栏正确显示,只要修改编码即可]
"   All the commands work on the word that is under the cursor
function! s:Add_Misc_Menu(menu_clear)
    if has("gui_running")
        if (a:menu_clear)
            silent! unmenu &Misc
            silent! unmenu! &Misc
            amenu <silent> &Misc.调用C(&M)D<Tab>\:!cmd :!start cmd<CR>
            amenu <silent> &Misc.查找所有(&T)ag<Tab>\:tselect :tselect <CR>
            amenu <silent> &Misc.日历(&H)<Tab>\:CalendarH :CalendarH <CR>
            amenu <silent> &Misc.查看编码(&V) :set fileencoding<CR><CR> 
            amenu <silent> &Misc.-SEP1- <Nop> " 增加分隔符
            amenu <silent> &Misc.转为UTF-8无BOM编码格式(&U) :set fileencoding=utf-8<CR> :echo "Transfer Completed"<CR>
            amenu <silent> &Misc.转为ANSI编码格式(&G) :set fileencoding=gbk<CR><CR> :echo "Transfer Completed"<CR>
            amenu <silent> &Misc.去掉^M :%s/\r\+$//e<CR>
            " amenu <silent> &Misc.-SEP2- <Nop> " 增加分隔符
            " amenu <silent> &Misc.建立奇缘项目tags文件 :! ctags -R --languages=-Ant,Asm,Asp,Awk,Basic,BETA,C,C++,C\#,Cobol,DosBatch,Eiffel,Erlang,Flex,Fortran,HTML,Java,JavaScript,Lisp,Lua,Make,MatLab,OCaml,Pascal,Perl,PHP,Python,REXX,Ruby,Scheme,Sh,SLang,SML,SQL,Tcl,Tex,Vera,Verilog,VHDL,Vim,YACC,+Erlang -f E:\qingshi\qiyuan_server\trunk\xge\tags E:\qingshi\qiyuan_server\trunk\xge<CR>
            " amenu <silent> &Misc.建立凡仙项目tags文件 :! ctags -R --languages=-Ant,Asm,Asp,Awk,Basic,BETA,C,C++,C\#,Cobol,DosBatch,Eiffel,Erlang,Flex,Fortran,HTML,Java,JavaScript,Lisp,Lua,Make,MatLab,OCaml,Pascal,Perl,PHP,Python,REXX,Ruby,Scheme,Sh,SLang,SML,SQL,Tcl,Tex,Vera,Verilog,VHDL,Vim,YACC,+Erlang -f E:\g1\tags E:\g1<CR>
            " amenu <silent> &Misc.当前目录建立tags[不建议使用] :! ctags -R . <CR>
            " amenu <silent> &Misc.-SEP3- <Nop> " 增加分隔符
            amenu <silent> &Misc.-SEP4- <Nop> "增加分隔符
            amenu <silent> &Misc.开关对齐显示(&I)<Tab>\:IndentGuidesToggle :IndentGuidesToggle<CR>
            amenu <silent> &Misc.-SEP5- <Nop> "增加分隔符
            amenu <silent> &Misc.Application模板<Tab>\:ErlangApplication :ErlangApplication <CR>
            amenu <silent> &Misc.Supervisor模板<Tab>\:ErlangSupervisor :ErlangSupervisor <CR>
            amenu <silent> &Misc.GenServer模板<Tab>\:ErlangGenServer :ErlangGenServer <CR>
            amenu <silent> &Misc.GenFsm模板<Tab>\:ErlangGenFsm :ErlangGenFsm <CR>
            amenu <silent> &Misc.GenEvent模板<Tab>\:ErlangGenEvent :ErlangGenEvent <CR>
            amenu <silent> &Misc.-SEP6- <Nop>
            amenu <silent> &Misc.开启折叠 :let erlang_folding = 1 <CR>
            amenu <silent> &Misc.关闭折叠 :let erlang_folding = 0 <CR>
            " amenu <silent> &Misc.帮助<Tab> :e<CR>
        endif
    endif
endfunction


function! s:Add_Lookup_Menu(menu_clear)
    if has("gui_running")
        if (a:menu_clear)
            silent! unmenu &LookupFile
            silent! unmenu! &LookupFile
            amenu <silent> &LookupFile.&Tags<Tab>\:LUTags   :LUTags <CR>
            amenu <silent> &LookupFile.&Path<Tab>\:LUPath   :LUPath <CR>
            amenu <silent> &LookupFile.&Bufs<Tab>\:LUBufs   :LUBufs <CR>
            amenu <silent> &LookupFile.&Walk<Tab>\:LUWalk   :LUWalk <CR>
            amenu <silent> &LookupFile.&Args<Tab>\:LUArgs   :LUArgs <CR>
            amenu <silent> &LookupFile.&LookupFile<Tab>\:LookupFile     :LookupFile <CR>
        endif
    endif
endfunction


function! s:Add_LeaderF_Menu_1(menu_clear)
    if has("gui_running")
        if (a:menu_clear)
            for [key, value] in items(g:proj_svn_path)
                exe "amenu <silent> &Leaderf.&". value["name"] . "<TAB>" . value["path"] . " :Leaderf " . value["path"] . "<CR>"
            endfor
        endif
    endif
endfunction

function! s:Add_LeaderF_Menu(menu_clear, menu_name, svn_path)
    if has("gui_running")
            for [key, value] in items(a:svn_path)
                exe "amenu <silent> &" . a:menu_name . ".&Leaderf.&". value["name"] . "<TAB>" . value["path"] . " :Leaderf " . value["path"] . "<CR>"
            endfor
    endif
endfunction


function! s:Add_Font_Menu(menu_clear)
    if has("gui_running")
        if (a:menu_clear)
            silent! unmenu &Font
            silent! unmenu! &Font
            amenu <silent> &Font.字体Fixedsys<Tab> :set guifont=Fixedsys:h12<CR> " Fixedsys:h12:b:i:u -- b加粗 i加斜 u下划线
            amenu <silent> &Font.字体Consolas<Tab> :set guifont=Consolas:h18<CR>
            amenu <silent> &Font.字体Courier\ New<Tab> :set guifont=Courier\ New:h16<CR>
            amenu <silent> &Font.字体Monaco<Tab> :set guifont=Monaco:h14<CR>
            amenu <silent> &Font.-SEP1- <Nop> "增加分隔符
            amenu <silent> &Font.主题desert<Tab> :colo desert<CR>
            amenu <silent> &Font.主题default<Tab> :colo default<CR>
            amenu <silent> &Font.主题delek<Tab> :colo delek<CR>
            amenu <silent> &Font.主题peachpuff<Tab> :colo peachpuff<CR>
            amenu <silent> &Font.主题zellner<Tab> :colo zellner<CR>
        endif
    endif
endfunction

function! s:Add_SVN(menu_clear, menu_name, svn_path)
    if has("gui_running")
        if (a:menu_clear)
            " exe "silent! unmenu &" . a:menu_name
            " silent! unmenu! &SVN
            for [key, value] in items(a:svn_path)
                exe "amenu <silent> &" . a:menu_name . ".&UP\\ 目录.&". value["name"] . "<TAB>". value["path"] . " :SVN update " . value["path"] . "<CR>"
            endfor
            for [key, value] in items(a:svn_path)
                exe "amenu <silent> &" . a:menu_name . ".&COMMIT\\ 目录.&". value["name"] . "<TAB>". value["path"] . " :SVN commit " . value["path"] . "<CR>"
            endfor
        endif
    endif
endfunction

function! s:Add_SVN_1(menu_clear)
    if has("gui_running")
        if (a:menu_clear)
            amenu <silent> &SVN.SVN\ U(&P)<TAB>\:SVN\ update        :SVN update . <CR>
            amenu <silent> &SVN.SVN\ (&A)DD<TAB>\:SVN\ add          :SVN add %<CR>
            amenu <silent> &SVN.SVN\ (&D)IFF<TAB>\:SVN\ diff        :SVN diff %<CR>
            amenu <silent> &SVN.SVN\ (&C)OMMIT<TAB>\:SVN\ commit    :SVN commit %<CR>
            amenu <silent> &SVN.SVN\ (&L)OG<TAB>\:SVN\ log          :SVN log %<CR>
        endif
    endif
endfunction

function! s:Add_Project()
    for [key, game] in items(g:proj_all)
        call s:Add_LeaderF_Menu(1, game['name'], game['conf'])
        call s:Add_SVN(1, game['name'], game['conf'])
    endfor
endfunction

function! <SID>CallNull()
endfunc

autocmd BufEnter * call s:Add_Font_Menu(1)
autocmd BufEnter * call s:Add_Misc_Menu(1)
autocmd BufEnter * call s:Add_LeaderF_Menu_1(1)
autocmd BufEnter * call s:Add_SVN_1(1)
autocmd BufEnter * call s:Add_Project()
" autocmd BufEnter * call s:Add_Lookup_Menu(1)
